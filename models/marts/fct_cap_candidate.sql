{{
    config(
        materialized = 'table'
    )
}}

/*
    One row per triggered marketer per candidate assessment: the CAP score of
    the candidates attached to marketers whose recruiting credit triggered this
    year, with the office, zone and recruiter the credit belongs to.

    This is the final SELECT of the CAP query. Three differences from it, all
    deliberate:

      1. `limit 10` is gone. It was a testing leftover, as it was in
         FOD_query.sql.

      2. current_date is cur_dt. The original mixed the load date (in `trig`)
         with current_date (in `ytd_trigger` and the contract join). Everything
         in this project anchors on the load date -- see stg_a360__load_control.

      3. Column names are snake_case throughout, rather than the original's
         mixture of Cap_Date, GO_Code and can_stg_nm.

    This model outputs candidate NAMES: it is the one place the protegrity
    unprotect runs, and unlike the views upstream it is a materialised table.
    Grant on it accordingly -- see the comment on candidate_name below.

    TWO CONSTANT COLUMNS, reproduced rather than removed:

      triggered_flg  is always 'Y'. It tests `t.mktr_no is null` on the driving
                     table of an inner-joined CTE, which cannot be null.
      ytd_trigger    is always 'Y'. int_triggered_marketers has already filtered
                     rcr_elig_dt to the current year to date, so the test
                     restates a filter that has already been applied.

    They are here because this model is a drop-in replacement for that query and
    something downstream may still select them. Both would become meaningful if
    the report were widened to include untriggered marketers -- which is a real
    thing to want -- by making int_triggered_marketers' window a flag instead of
    a filter. Until then, do not read either column as evidence of anything. The
    accepted_values tests in _marts.yml pin them to 'Y' so that the day one
    stops being constant, the build says so.
*/

with triggered as (

    select * from {{ ref('int_triggered_marketers') }}

),

candidate as (

    select * from {{ ref('int_candidate_cap_score') }}

),

joined as (

    select

          org.zone_cd
        , org.org_unit_cd                       as go_code
        , org.go_nm
        , org.zone_nm                           as zone_name

        -- EDH's recruiter name wins; the a360 name built in
        -- int_triggered_marketers is the fallback, as in the original.
        , coalesce(c.can_recrt_nm, t.rcr_name)  as recruiter_name

        , c.recrt_mktr_id

        -- The only place in the project that decrypts anything. can_full_nm is
        -- protected at rest and every model upstream carries it that way; the
        -- call lands here so the access decision is visible in one file, and so
        -- the staging views stay safe to hand out.
        --
        -- Two things this needs from the environment: EXECUTE on the protegrity
        -- UDF for whoever runs dbt AND for whoever reads the table, since the
        -- output is a materialised table of candidate names. Without the grant
        -- the build fails outright rather than returning ciphertext, which is
        -- the right way round.
        , protegrity.unprotect_clientname(c.can_full_nm_protected)
                                                as candidate_name

        , t.mktr_no
        , t.rcr_no
        , t.split

        , c.can_stg_nm                          as stage
        , c.cap_date
        , c.fit_score_val                       as cap_score
        , c.cap_score_75plus
        , c.pts_date
        , c.can_mktr_id                         as marketer_id
        , c.candidate_id

        -- Constant 'Y'. See the header.
        , case when t.mktr_no is null then 'N' else 'Y' end as triggered_flg
        , case
            when t.rcr_elig_dt between date_trunc('year', current_date) and current_date
            then 'Y' else 'N'
          end                                   as ytd_trigger

        , t.ea_pgm_ind
        , t.mk_cnt_tp_nm

        , d.cur_dt

    from triggered t

    cross join {{ ref('int_reporting_periods') }} d

    -- Left, as in the original -- but the where clause below requires a score,
    -- so in practice this behaves as an inner join. Widen the filter and the
    -- left join starts mattering again.
    left join candidate c
        on c.producer_mktr_no = t.mktr_no

    -- Selects no column, and reproduced from the original anyway. All it can
    -- do is change the row count, and only if a marketer appears twice in the
    -- dashboard dimension -- which the `unique` test on that model's mktr_no
    -- rules out. Inert while that test passes; the day it fails, this join
    -- doubles the report and that test is the explanation.
    left join {{ ref('stg_a360__marketer_dashboard') }} mk
        on mk.mktr_no = t.mktr_no

    -- Office and zone come from the marketer's ORIGINAL org unit, not their
    -- current one. That is what the CAP query joins on, and it is what makes
    -- this report differ from fct_marketer_production for a marketer who has
    -- moved office.
    left join {{ ref('stg_a360__org_zone_vg') }} org
        on org.org_unit_cd = t.orig_org_unit_cd

),

final as (

    select *
    from joined

    -- The qualifying rule, verbatim: an assessed candidate whose marketer is
    -- either on the enhanced-agreement program or on a TAS contract.
    --
    -- `like '%TAS%'` is case-sensitive substring matching on display text, the
    -- same fragility the title list has in fct_marketer_production: a contract
    -- type renamed to 'Tas Producer' silently stops qualifying. Move it onto
    -- mk_cnt_tp_cd once someone confirms which codes it is standing in for --
    -- stg_a360__contract_type exposes both columns for that swap.
    where cap_score is not null
      and (ea_pgm_ind = 'T' or mk_cnt_tp_nm like '%TAS%')

)

select * from final
