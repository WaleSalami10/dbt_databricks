/*
    Marketer class (career level) history -- a type-2 dimension.

    One row per marketer per class, valid between mk_cls_edt and
    mk_cls_xdt inclusive. int_class_by_marketer reads it as a point-in-time
    lookup: "which row's window contains this reporting date?".

    That lookup assumes the windows for a marketer do not overlap. The
    mutually_exclusive_ranges test in _staging.yml is what enforces the
    assumption -- if it fails, the class shown on the report is whichever
    overlapping row max() happened to pick.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_cls_hist') }}

)

select

      cast(trim(mktr_no) as string)     as mktr_no
    , cast(mk_cls_tp_cd as int)         as mk_cls_tp_cd
    , cast(mk_cls_edt as timestamp)     as mk_cls_edt
    , cast(mk_cls_xdt as timestamp)     as mk_cls_xdt

from source
