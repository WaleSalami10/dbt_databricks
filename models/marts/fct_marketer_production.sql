{{
    config(
        materialized = 'table',
        unique_key   = 'mktr_no'
    )
}}

/*
    One row per marketer: who they are, where they sit in the org, and what they
    produced across the five reporting periods.

    This replaces the final SELECT of FOD_query.sql, which it reproduces
    faithfully -- including `select distinct` and both manpower joins. One thing
    is deliberately different: `limit 10` is gone, since it was a testing
    leftover on line 182.

    Two things to know about what that faithfulness costs:

      1. `select distinct` collapses duplicate rows rather than preventing them.
         The fan-out it hides comes from the join to marketer history, which is
         one-row-per-marketer only by assumption. Distinct makes a fan-out
         invisible when the duplicated rows are identical, and does NOT help
         when they differ -- then you get two rows for one marketer and a
         doubled report. The `unique` test on mktr_no in _marts.yml is what
         actually catches that, and it is left in place for exactly that reason.

      2. The two joins to manpower (mp / mpr) are on the SAME key with no
         distinguishing predicate, so `prior_prorata` always equals `prorata`.
         That is the original's behaviour, reproduced. A genuine prior-period
         value needs a snapshot date this table does not currently expose --
         see the README before wiring one up.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

marketer as (

    select
          dash.mktr_no
        , dash.rel_mktr_no
        , dash.mk_cls_tp_cd
        , rcr.abreviated_nm
        , rcr.mk_fst_nm
        , rcr.mk_lst_nm
        , ttl.ttl_nm
        , zn.go_nm
        , zn.zn_nm

    from {{ ref('stg_a360__marketer_dashboard') }} dash

    -- Self-join: rel_mktr_no points at the related (recruiting) marketer,
    -- and that is whose name appears on the report.
    inner join {{ ref('stg_a360__marketer_dashboard') }} rcr
        on rcr.mktr_no = dash.rel_mktr_no

    inner join {{ ref('stg_a360__org_zone') }} zn
        on zn.org_unit_cd = rcr.alt_org_unit_cd

    inner join {{ ref('stg_a360__title_type') }} ttl
        on ttl.mk_ttl_tp_cd = rcr.mk_ttl_tp_cd

    -- FOD_query.sql lines 178-179, verbatim. ttl_nm is already initcap'd by
    -- stg_a360__title_type, which is what makes the text match on the first
    -- list work at all -- and what makes it fragile. See that model's header.
    --
    -- The status codes are quoted for the same reason as everywhere else in
    -- this project: '01' is text, and as an integer it matches nothing.
    where ttl.ttl_nm in ('Managing Partner', 'Partner', 'Senior Partner',
                         'Executive Partner', 'Associate Partner')
      and rcr.mk_sts_tp_cd in ('01', '04', '1C')

),

joined as (

    select
          m.mktr_no
        , m.rel_mktr_no
        , m.abreviated_nm
        , m.mk_fst_nm
        , m.mk_lst_nm
        , m.ttl_nm
        , m.go_nm
        , m.zn_nm
        , m.mk_cls_tp_cd

        , appt.orig_appt_dt
        , ctr.contractenddate

        -- The marketer's first six months, used for new-agent tracking.
        , date_trunc('month', appt.orig_appt_dt)                       as start_6mo
        , cast(last_day(dateadd(month, 6, appt.orig_appt_dt))
               as timestamp)                                           as end_6mo

        -- FOD_query.sql lines 120-127, verbatim. Codes are UNQUOTED here:
        -- mk_cls_tp_cd is an integer, unlike the text status codes above.
        -- An unmapped code falls through to 'Other', as the original's ELSE did.
        , case
            when m.mk_cls_tp_cd = 1  then 'CC'
            when m.mk_cls_tp_cd = 2  then '1P'
            when m.mk_cls_tp_cd = 3  then '2P'
            when m.mk_cls_tp_cd = 4  then '3P'
            when m.mk_cls_tp_cd = 5  then 'Estab'
            when m.mk_cls_tp_cd = 10 then 'PTAS'
            else 'Other'
          end                                                           as cls_copy
        , case when mp.pro_rata_ind  = 1 then 1 else 0 end              as prorata
        , mp.count_active
        -- Always equal to prorata above: mpr is the same table joined on the
        -- same key. Reproduced from FOD_query.sql line 132 as-is.
        , case when mpr.pro_rata_ind = 1 then 1 else 0 end              as prior_prorata

        , coalesce(f.fyc_me,  0) as fyc_me
        , coalesce(f.fyc_ytd, 0) as fyc_ytd
        , coalesce(f.fyc_mtd, 0) as fyc_mtd
        , coalesce(f.fyc_cw,  0) as fyc_cw
        , coalesce(f.fyc_pw,  0) as fyc_pw

        , coalesce(p.cases_me,  0) as cases_me
        , coalesce(p.cases_ytd, 0) as cases_ytd
        , coalesce(p.cases_mtd, 0) as cases_mtd
        , coalesce(p.cases_cw,  0) as cases_cw
        , coalesce(p.cases_pw,  0) as cases_pw

        , ch.cw_class
        , ch.pw_class
        , ch.prvme_class
        , ch.cur_class

    from marketer m

    inner join {{ ref('stg_a360__marketer_appointment') }} appt
        on appt.mktr_no = m.mktr_no

    -- Left join on purpose: keeping it as an inner join drops marketers and
    -- makes total FYC / paid cases fail to tie out to the source.
    left join {{ ref('int_marketer_contract') }} ctr
        on ctr.mktr_no = m.mktr_no

    -- Both manpower joins, as in FOD_query.sql lines 160-161. mpr is the same
    -- table on the same key: it exists to feed prior_prorata, which is
    -- therefore identical to prorata. Give mpr a prior-period predicate and the
    -- column starts meaning something; until then it is a duplicate by design.
    left join {{ ref('stg_a360__manpower') }} mp
        on mp.mktr_no = m.mktr_no

    left join {{ ref('stg_a360__manpower') }} mpr
        on mpr.mktr_no = m.mktr_no

    left join {{ ref('int_fyc_by_marketer') }} f
        on f.mktr_no = m.mktr_no

    left join {{ ref('int_paid_cases_by_marketer') }} p
        on p.mktr_no = m.mktr_no

    left join {{ ref('int_class_by_marketer') }} ch
        on ch.mktr_no = m.mktr_no

),

final as (

    -- DISTINCT, as in FOD_query.sql line 81. It collapses rows duplicated by an
    -- upstream fan-out only when those rows are byte-identical; when they are
    -- not, the marketer appears twice and the report doubles. The `unique` test
    -- on mktr_no in _marts.yml is the guard that actually catches that -- do not
    -- read this DISTINCT as one.
    select distinct
          j.*
        , d.cur_dt

        -- Was the marketer inside their first six months, and still under
        -- contract, at each period end?
        , case
            when d.prv_me between j.start_6mo and j.end_6mo
             and j.contractenddate >= d.prv_me
            then 'Y' else 'N'
          end as prevmonthflg_sixmth

        , case
            when d.curr_month_enddate between j.start_6mo and j.end_6mo
             and j.contractenddate >= d.cur_mnst
            then 'Y' else 'N'
          end as currmonthflg_sixmth

        -- Was the marketer actively contracted on each reporting date?
        --
        -- `activet_pw` below is spelt exactly as FOD_query.sql spells it. It
        -- reads like a typo for active_pw and almost certainly is one, but the
        -- point of this model is to be a drop-in replacement for that query, so
        -- the name is reproduced rather than corrected. Fix it in both places
        -- together, once you know nothing downstream reads it.
        , case when d.prv_me          between j.orig_appt_dt and j.contractenddate then 1 else 0 end as active_prvme
        , case when d.cur_dt          between j.orig_appt_dt and j.contractenddate then 1 else 0 end as active_mtd
        , case when d.cur_dt          between j.orig_appt_dt and j.contractenddate then 1 else 0 end as active_ytd
        , case when d.cw_start_dt     between j.orig_appt_dt and j.contractenddate then 1 else 0 end as active_cw
        , case when d.prev_week_start between j.orig_appt_dt and j.contractenddate then 1 else 0 end as activet_pw

    from joined j
    cross join dates d

)

select * from final
