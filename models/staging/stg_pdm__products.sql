with products as (
select
    plan_cd_nk,
    product_ln_cd,
    product_grp_nm,
    product_nm
from {{ source('pdm', 'dim_product') }}
where {{ pdm_as_of() }}
)
select * from products
