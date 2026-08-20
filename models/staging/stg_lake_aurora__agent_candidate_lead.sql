/*
    Candidate leads, one row per version of a lead.

    edh_record_status_in is the ODS soft delete: 'A' is the live row and
    anything else is superseded. This model does NOT filter on it -- staging
    renames and casts -- so anything reading this model directly gets history as
    well as the current picture. int_candidate_cap_score applies the filter.

    can_full_nm is PROTECTED and stays that way here. Decrypting it is a
    protegrity UDF call, it needs grants this project does not assume, and it
    turns a view anyone can query into one carrying candidate names. The mart
    makes that call, once, where the access decision is visible.
*/

with source as (

    select * from {{ source('ext_lake_aurora_ods_producer2', 'agent_candidate_lead') }}

)

select

      cast(trim(can_id_nk) as string)           as can_id_nk
    , cast(trim(can_mktr_id) as string)         as can_mktr_id
    , cast(trim(recrt_mktr_id) as string)       as recrt_mktr_id
    , cast(trim(can_recrt_nm) as string)        as can_recrt_nm
    , can_full_nm                               as can_full_nm_protected
    , cast(trim(can_stg_nm) as string)          as can_stg_nm
    , cast(trim(edh_record_status_in) as string) as edh_record_status_in

from source
