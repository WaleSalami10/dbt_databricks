/*
    Marketer dashboard dimension, EDH lake version.

    edh_record_status_in is EDH's soft delete: 'A' is the live row. This model
    does NOT filter on it -- staging renames and casts, nothing clever --
    int_fod_new_agents applies the filter.
*/

with source as (

    select * from {{ source('lake_orap10', 'mk_dashbrd') }}

)

select

      cast(trim(mktr_id_nk) as string)         as mktr_no
    , cast(trim(rel_mktr_id) as string)        as rcr_no
    , cast(trim(edh_record_status_in) as string) as edh_record_status_in

from source
