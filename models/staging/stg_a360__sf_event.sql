/*
    Salesforce case-development events, one row per event.

    is_deleted_cd is Salesforce's soft-delete flag and the actvt_dt year
    window is a business rule -- neither is applied here, both are applied in
    int_fod_events, same convention as every other soft-delete flag in this
    project.
*/

with source as (

    select * from {{ source('a360_fod', 'sf_event') }}

)

select

      cast(trim(sale_force_id) as string)         as sale_force_id
    , cast(trim(case_ownr_acf2id_id) as string)    as case_ownr_acf2id_id
    , cast(trim(event_ownr_desc) as string)        as event_ownr_desc
    , cast(trim(case_agent_nm_desc) as string)     as case_agent_nm_desc
    , trim(case_dev_tool_desc)                     as case_dev_tool_desc
    , cast(trim(case_dev_in_prog_desc) as string)  as case_dev_in_prog_desc
    , cast(trim(case_fod_occur_desc) as string)    as case_fod_occur_desc
    , cast(is_fod_mgr_ownr_ind as int)              as is_fod_mgr_ownr_ind
    , cast(actvt_dt as date)                        as actvt_dt
    , cast(is_deleted_cd as int)                    as is_deleted_cd
    , cast(last_modify_dt as timestamp)             as last_modify_dt

from source
