/*
    Development-in-progress records. Restricts sf_event to events with an
    active development in progress; last_modified_dt anchors the
    p_adp_lst_mod_dt_dip point-in-time join in int_fod_events.
*/

with source as (

    select * from {{ source('a360_fod', 'sf_case_development_in_progress_c') }}

)

select

      cast(trim(sale_force_id_nk) as string) as sale_force_id_nk
    , cast(last_modified_dt as timestamp)    as last_modified_dt

from source
