with products as (
select
    plan_cd_nk,
    product_ln_cd,
    product_grp_nm,
    product_nm
from {{ source('pdm', 'dim_product') }}
where edh_record_status_in = 'A'
)
select * from products
