/*
    Point-in-time control table for sf_case_development_in_progress_c.
    int_fod_events joins on (sale_force_id_nk, dt) to keep only each
    development-in-progress row's current, as-loaded version.
*/

with source as (

    select * from {{ source('a360_fod', 'p_adp_lst_mod_dt_dip') }}

)

select

      cast(trim(sale_force_id_nk) as string) as sale_force_id_nk
    , cast(dt as timestamp)                  as dt

from source
