{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['snapshot_date'],
        unique_key = ['snapshot_date', 'cnt_id_nk', 'cnt_iss_cd_nk', 'producer_id_nk'],
        file_format = 'delta'
    )
}}

-- Original: create or replace table
--   prod_builder_fieldexperience.fx_test.ppg_stg_cnt_prd_mapping
--
-- Was a full rebuild pinned to CURRENT_DATE. Now partitioned by snapshot_date,
-- so a missed day can be backfilled with:
--   dbt run -s ppg_stg_cnt_prd_mapping --vars '{snapshot_date: "2026-07-14"}'

with categorized as (
    select * from {{ ref('int_products__categorized') }}
),

dates as (
    select * from {{ ref('stg_pdm__dates') }}
)

select distinct
    dt.snapshot_date,
    dt.month_end_date,
    prd.lob_nm,
    prd.cnt_id_nk,
    prd.cnt_iss_cd_nk,
    prd.cnt_eff_dt,
    prd.primry_ownr_cl_id,
    prd.producer_id_nk,
    prd.producer_cnt_role_nm,
    prd.product_category_need_based_by_product,
    prd.product_type,
    prd.product_category_risk_wm,
    prd.product_category_protection_accumulation_alternate
from categorized prd
cross join dates dt
where prd.product_type is not null
