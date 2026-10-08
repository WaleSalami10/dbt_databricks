/*
    Point-in-time control table for sf_event -- the sf_event equivalent of
    p_adp_lst_mod_dt_dip. int_fod_events joins on (sale_force_id, dt) to keep
    only each event's current, as-loaded version.
*/

with source as (

    select * from {{ source('a360_fod', 'p_adp_lst_mod_dt_stg') }}

)

select

      cast(trim(sale_force_id) as string) as sale_force_id
    , cast(dt as timestamp)               as dt

from source
