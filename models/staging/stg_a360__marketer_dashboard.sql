/*
    Marketer dashboard dimension. One row per marketer: their codes, their name,
    and the marketer who recruited them.

    rel_mktr_no points at that recruiting marketer, which is why the mart joins
    this model to itself -- the report is grouped by the recruiter's name,
    office and title, not the producer's.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_dashbrd') }}

)

select

      cast(trim(mktr_no) as string)         as mktr_no
    , cast(trim(rel_mktr_no) as string)     as rel_mktr_no

    , cast(mk_cls_tp_cd as int)             as mk_cls_tp_cd
    , cast(trim(mk_ttl_tp_cd) as string)    as mk_ttl_tp_cd
    , cast(trim(mk_sts_tp_cd) as string)    as mk_sts_tp_cd
    , cast(trim(alt_org_unit_cd) as string) as alt_org_unit_cd

    , cast(trim(abreviated_nm) as string)   as abreviated_nm
    , cast(trim(mk_fst_nm) as string)       as mk_fst_nm
    , cast(trim(mk_lst_nm) as string)       as mk_lst_nm

from source
