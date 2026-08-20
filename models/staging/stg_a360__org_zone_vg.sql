/*
    General office and zone lookup, the _vg variant -- same shape as
    stg_a360__org_zone plus zone_cd.

    Two models for two source tables, deliberately. The CAP report resolves the
    office from the marketer's ORIGINAL org unit against this table; the
    production report resolves it from the recruiter's CURRENT unit against
    orap10_cur_go_zone. Collapsing them into one model would hide that the two
    reports do not have to agree.
*/

with source as (

    select * from {{ source('a360', 'orap10_cur_go_zone_vg') }}

)

select

      cast(trim(org_unit_cd) as string) as org_unit_cd
    , cast(trim(org_unit_nm) as string) as go_nm
    , cast(trim(zone_cd) as string)     as zone_cd
    , cast(trim(zone_nm) as string)     as zone_nm

from source
