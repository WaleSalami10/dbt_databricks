/*
    General office and zone lookup, one row per org unit. Supplies the two
    geography columns the report groups by.
*/

with source as (

    select * from {{ source('a360', 'orap10_cur_go_zone') }}

)

select

      cast(trim(org_unit_cd) as string)     as org_unit_cd
    , cast(trim(org_unit_nm) as string)     as go_nm
    , cast(trim(zone_nm) as string)         as zn_nm

from source
