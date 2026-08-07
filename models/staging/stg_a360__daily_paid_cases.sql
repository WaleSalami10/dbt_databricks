/*
    Daily paid cases and premium, one row per marketer per day per product.

    The product LINE (the 'LF' life filter the report applies) is not on this
    table -- it comes from the product dimension. The join lives in
    int_paid_cases_by_marketer rather than here, so this model stays a
    one-to-one rename of its source.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_daly_ctcp_prm_smy') }}

)

select

      cast(trim(mktr_no) as string)         as mktr_no
    , cast(trim(alt_prdt_cd) as string)     as product_cd
    , cast(ctcp_paid_dt as timestamp)       as paid_dt
    , cast(ctcp_case_cnt as int)            as cases_qty
    , cast(ctcp_prm_amt as decimal(18, 2))  as premium_amt

from source
