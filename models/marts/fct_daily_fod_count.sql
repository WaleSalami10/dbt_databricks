{{
    config(
        materialized = 'table',
        unique_key   = ['mktr_no', 'rcr_no', 'title', 'agent_name', 'owner', 'event_date']
    )
}}

/*
    Daily FOD (Field Office Development) count by agent. One row per
    marketer, recruiter, title, agent, owner and event date, with the count of
    distinct events qualifying as FOD, PRP and IID that day.

    This replaces the final SELECT of the FOD_query.sql daily count report.
    fod_count additionally requires case_fod_occur_desc = 'Yes' and
    is_fod_mgr_ownr_ind = 1 -- prp_count and iid_count only require the tool
    match, reproduced from the source query as-is. The `limit 10` on the
    original was a testing leftover and is not carried over.
*/

with events as (

    select * from {{ ref('int_fod_events') }}

)

select

      mktr_no
    , rcr_no
    , title
    , agent_name
    , owner
    , event_date

    , count(distinct case
        when case_dev_tool = 'FOD'
         and case_fod_occur_desc = 'Yes'
         and is_fod_mgr_ownr_ind = 1
            then event_id
      end)                                          as fod_count

    , count(distinct case
        when case_dev_tool = 'PRP' then event_id
      end)                                          as prp_count

    , count(distinct case
        when case_dev_tool = 'IID' then event_id
      end)                                          as iid_count

from events

group by mktr_no, rcr_no, title, agent_name, owner, event_date
