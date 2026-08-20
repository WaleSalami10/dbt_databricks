/*
    Marketer CONTRACT history -- one row per marketer per contract, valid
    between mk_cnt_edt and mk_cnt_xdt inclusive.

    Not to be confused with stg_a360__marketer_status, which is contract STATUS
    history off a different source table (orap10_mk_sts_atv). The CAP query uses
    this one: it asks which contract type was in force on the day the recruiting
    credit triggered.

    The end date gets the same treatment as the status model's: exposed raw as
    well as resolved, with a 9999 sentinel resolved to 9999-12-31 so BETWEEN
    works. If this source turns out never to use the sentinel the resolution is
    a no-op, which is the cheaper way to be wrong.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_cnt_atv') }}

)

select

      cast(trim(mktr_no) as string)         as mktr_no
    , cast(trim(mk_cnt_tp_cd) as string)    as mk_cnt_tp_cd
    , cast(mk_cnt_edt as timestamp)         as mk_cnt_edt
    , cast(mk_cnt_xdt as string)            as mk_cnt_xdt_raw

    , case
        when cast(mk_cnt_xdt as string) like '%9999%'
            then cast('9999-12-31' as timestamp)
        else cast(mk_cnt_xdt as timestamp)
      end                                   as mk_cnt_xdt

from source
