/*
    Marketer contract-status history -- a type-2 dimension, one row per marketer
    per status, valid between mk_sts_atv_edt and mk_sts_atv_xdt inclusive.

    The source stores "open ended" as a 9999 sentinel in the end date. Two
    columns come out of this model rather than one, on purpose:

      mk_sts_atv_xdt_raw   the source value, untouched. Downstream code that
                            needs to KNOW a contract is open ended (rather than
                            ending in the year 9999) tests this.

      mk_sts_atv_xdt       the same value as a timestamp, sentinel resolved to
                            9999-12-31 so that BETWEEN comparisons work without
                            every consumer re-implementing the sentinel check.

    int_marketer_contract resolves the sentinel a second time, into the end of
    the current reporting year -- that is a business rule about contracts, not a
    type conversion, which is why it does not live here.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_sts_atv') }}

)

select

      cast(trim(mktr_no) as string)         as mktr_no
    , cast(trim(mk_sts_tp_cd) as string)    as mk_sts_tp_cd
    , cast(mk_sts_atv_edt as timestamp)     as mk_sts_atv_edt
    , cast(mk_sts_atv_xdt as string)        as mk_sts_atv_xdt_raw

    , case
        when cast(mk_sts_atv_xdt as string) like '%9999%'
            then cast('9999-12-31' as timestamp)
        else cast(mk_sts_atv_xdt as timestamp)
      end                                   as mk_sts_atv_xdt

from source
