/*
    Daily first-year commission, one row per marketer per day.

    Rename and cast only. The bucketing into reporting periods happens in
    int_fyc_by_marketer, which is also where the year filter is applied -- this
    model stays a full, unfiltered view of the source so that
    tests/assert_fyc_ties_to_source has something honest to tie back to.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_daly_fyc_join_mv') }}

)

select

      cast(trim(mktr_no) as string)         as mktr_no
    , cast(fyc_smy_edt as timestamp)        as fyc_smy_edt
    , cast(mk_shr_fyc_am as decimal(18, 2)) as mk_shr_fyc_am

from source
