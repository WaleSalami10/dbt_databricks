{{
    config(
        materialized = 'table',
        unique_key   = 'mktr_no'
    )
}}

/*
    One row per marketer: who they are, where they sit in the org, and what they
    produced across the five reporting periods.

    This replaces the final SELECT of FOD_query.sql. Three things changed on the
    way over, all deliberate:

      1. `limit 10` is gone (it was a testing leftover).
      2. `select distinct` is gone. Distinct was masking a fan-out from the join
         to marketer history. The uniqueness test in _agency__models.yml will now
         fail loudly if a marketer appears twice, which is what you want.
      3. The two joins to manpower (mp / mpr) in the original were on the SAME
         key with no distinguishing filter, so `prorata` and `prior_prorata`
         always held the same value. Only one join is kept below -- see the
         README before wiring up a genuine prior-period version.
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
        , ttl.title_nm
        , zn.general_office_nm
        , zn.zone_nm

    from {{ ref('stg_a360__marketer_dashboard') }} dash

    -- Self-join: rel_mktr_no points at the related (recruiting) marketer,
    -- and that is whose name appears on the report.
    inner join {{ ref('stg_a360__marketer_dashboard') }} rcr
        on rcr.mktr_no = dash.rel_mktr_no

    inner join {{ ref('stg_a360__org_zone') }} zn
        on zn.org_unit_cd = rcr.alt_org_unit_cd

    inner join {{ ref('stg_a360__title_type') }} ttl
        on ttl.mk_ttl_tp_cd = rcr.mk_ttl_tp_cd

    -- Both filters are expressed as joins to seeds rather than hardcoded IN
    -- lists. An inner join to a lookup is a filter: only rows with a matching
    -- code survive.
    inner join {{ ref('reportable_titles') }} rt
        on rt.title_nm = ttl.title_nm

    inner join {{ ref('reportable_dashboard_status_codes') }} rs
        on rs.status_cd = rcr.mk_sts_tp_cd

),

joined as (

    select
          m.mktr_no
        , m.rel_mktr_no
        , m.abreviated_nm
        , m.mk_fst_nm
        , m.mk_lst_nm
        , m.title_nm
        , m.general_office_nm
        , m.zone_nm
        , m.mk_cls_tp_cd

        , appt.orig_appt_dt
        , ctr.contract_end_dt

        -- The marketer's first six months, used for new-agent tracking.
        , date_trunc('month', appt.orig_appt_dt)                       as start_6mo
        , cast(last_day(dateadd(month, 6, appt.orig_appt_dt))
               as timestamp)                                           as end_6mo

        , cls.class_label
        , case when mp.pro_rata_ind = 1 then 1 else 0 end               as prorata
        , mp.count_active

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

    left join {{ ref('stg_a360__manpower') }} mp
        on mp.mktr_no = m.mktr_no

    left join {{ ref('int_fyc_by_marketer') }} f
        on f.mktr_no = m.mktr_no

    left join {{ ref('int_paid_cases_by_marketer') }} p
        on p.mktr_no = m.mktr_no

    left join {{ ref('int_class_by_marketer') }} ch
        on ch.mktr_no = m.mktr_no

    left join {{ ref('marketer_class_labels') }} cls
        on cls.class_cd = m.mk_cls_tp_cd

),

final as (

    select
          j.*
        , d.cur_dt

        -- Was the marketer inside their first six months, and still under
        -- contract, at each period end?
        , case
            when d.prv_me between j.start_6mo and j.end_6mo
             and j.contract_end_dt >= d.prv_me
            then 'Y' else 'N'
          end as prevmonthflg_sixmth

        , case
            when d.cur_month_end_dt between j.start_6mo and j.end_6mo
             and j.contract_end_dt >= d.cur_mnst
            then 'Y' else 'N'
          end as currmonthflg_sixmth

        -- Was the marketer actively contracted on each reporting date?
        , case when d.prv_me          between j.orig_appt_dt and j.contract_end_dt then 1 else 0 end as active_prvme
        , case when d.cur_dt          between j.orig_appt_dt and j.contract_end_dt then 1 else 0 end as active_mtd
        , case when d.cur_dt          between j.orig_appt_dt and j.contract_end_dt then 1 else 0 end as active_ytd
        , case when d.cw_start_dt     between j.orig_appt_dt and j.contract_end_dt then 1 else 0 end as active_cw
        , case when d.prev_week_start between j.orig_appt_dt and j.contract_end_dt then 1 else 0 end as active_pw

    from joined j
    cross join dates d

)

select * from final
