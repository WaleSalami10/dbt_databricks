with products as (
select
    plan_cd_nk,
    product_ln_cd,
    product_grp_nm,
    product_nm
from {{ pdm_relation('pdm', 'dim_product') }}
where {{ pdm_as_of('dim_product') }}
)
select * from products
