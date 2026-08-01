-- Original CTE: core_wm_client_product
--
-- The four CASE expressions are now a seed lookup. Match on the specific
-- product_nm first; fall back to the '*' wildcard row for that
-- product_ln_cd + product_grp_nm.
with base as (
    select * from {{ ref('int_products__unified') }}
),

products as (
    select * from {{ ref('stg_pdm__products') }}
),

map as (
    select * from {{ ref('product_category_map') }}
),

with_product as (
    select
        base.*,
        prd.product_ln_cd,
        prd.product_grp_nm,
        prd.product_nm
    from base
    left join products prd
        on prd.plan_cd_nk = base.plan_cd
),

categorized as (
    select
        wp.lob_nm,
        wp.cnt_id_nk,
        wp.cnt_iss_cd_nk,
        wp.cnt_eff_dt,
        wp.plan_cd,
        wp.primry_ownr_cl_id,
        wp.producer_id_nk,
        wp.producer_cnt_role_nm,
        wp.source_domain,

        coalesce(exact.product_category_risk_wm,
                 wild.product_category_risk_wm)
            as product_category_risk_wm,

        coalesce(exact.product_category_protection_accumulation_alternate,
                 wild.product_category_protection_accumulation_alternate)
            as product_category_protection_accumulation_alternate,

        coalesce(exact.product_category_need_based_by_product,
                 wild.product_category_need_based_by_product)
            as product_category_need_based_by_product,

        coalesce(exact.product_type, wild.product_type)
            as product_type

    from with_product wp
    left join map exact
        on  exact.product_ln_cd  = wp.product_ln_cd
        and exact.product_grp_nm = wp.product_grp_nm
        and exact.product_nm     = wp.product_nm
    left join map wild
        on  wild.product_ln_cd  = wp.product_ln_cd
        and wild.product_grp_nm = wp.product_grp_nm
        and wild.product_nm     = '*'
)

select * from categorized
