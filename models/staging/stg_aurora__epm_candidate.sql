/*
    Candidate side of the EPM case. Purely a bridge: case id in, candidate id out.
*/

with source as (

    select * from {{ source('ext_aurora_ods_producer2', 'epm_candidate') }}

)

select

      cast(trim(epm_case_id) as string)     as epm_case_id
    , cast(trim(candidate_id) as string)    as candidate_id

from source
