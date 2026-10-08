{{ config(tags=['intermediate', 'monthly']) }}

/*
    The `fod_overall_events` CTE from the FOD query: qualifying Salesforce
    events for FOD program marketers, one row per event.

    Two things carried over deliberately, both reproduced from the source
    query rather than "fixed":

      1. `owner` and `ownerid` in the source query are the SAME column
         (event_ownr_desc) under two names. Only `owner` survives into this
         model since `ownerid` is unused downstream -- see fct_daily_fod_count.
      2. The active-status code list below is FOD_query.sql's own copy of the
         ten active-status codes -- other reports built on this same a360 mart
         have historically carried their own copy of the same list, so if one
         gets added back here later, keep the two in sync.

    One change from the source query: the event-year filter was a hardcoded
    `year(actvt_dt) in (2025, 2026)`, which goes stale every January. Here it
    is anchored to int_reporting_periods' cur_dt instead (current year and the
    year before) -- the same window today, and it does not need editing next
    year.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

new_agents as (

    select * from {{ ref('int_fod_new_agents') }}

),

crm_user as (

    -- Only marketer ids that are purely numeric qualify -- FOD_query.sql's
    -- WHERE clause, moved here since it is really a join-key filter.
    select *
    from {{ ref('stg_a360__crm_user') }}
    where case_marketer_id_c rlike '^[0-9]+$'

),

active_status as (

    select *
    from {{ ref('stg_a360__marketer_status') }}
    where mk_sts_tp_cd in ('01', '04', '05', '07', '08', '09', '0A', '0B', '0C', '1C')

),

events as (

    select

          new_agents.mktr_no
        , new_agents.rcr_no
        , crm_user.user_title            as title
        , sf_event.sale_force_id         as event_id
        , sf_event.case_agent_nm_desc    as agent_name
        , sf_event.event_ownr_desc       as owner
        , sf_event.case_dev_tool_desc    as case_dev_tool
        , sf_event.case_dev_in_prog_desc
        , sf_event.case_fod_occur_desc
        , sf_event.is_fod_mgr_ownr_ind
        , sf_event.actvt_dt              as event_date
        , sf_event.last_modify_dt

    from new_agents

    inner join crm_user
        on new_agents.mktr_no = cast(crm_user.case_marketer_id_c as int)

    inner join {{ ref('stg_a360__sf_event') }} sf_event
        on  crm_user.acf2id_c = sf_event.case_ownr_acf2id_id
        and sf_event.is_deleted_cd = 0
        and sf_event.case_dev_tool_desc in ('FOD', 'PRP', 'IID')

    cross join dates

    where year(sf_event.actvt_dt) in (year(dates.cur_dt) - 1, year(dates.cur_dt))

),

qualifying as (

    select events.*
    from events

    inner join active_status
        on  active_status.mktr_no = events.mktr_no
        and events.event_date between active_status.mk_sts_atv_edt
                                   and active_status.mk_sts_atv_xdt

    inner join {{ ref('stg_a360__case_dev_in_progress') }} dip
        on events.case_dev_in_prog_desc = dip.sale_force_id_nk

    inner join {{ ref('stg_a360__adp_last_mod_dip') }} last_mod_dip
        on  dip.sale_force_id_nk = last_mod_dip.sale_force_id_nk
        and dip.last_modified_dt = last_mod_dip.dt

    inner join {{ ref('stg_a360__adp_last_mod_stg') }} last_mod_stg
        on  events.event_id = last_mod_stg.sale_force_id
        and events.last_modify_dt = last_mod_stg.dt

)

select

      mktr_no
    , rcr_no
    , title
    , event_id
    , agent_name
    , owner
    , case_dev_tool
    , case_fod_occur_desc
    , is_fod_mgr_ownr_ind
    , event_date

from qualifying
