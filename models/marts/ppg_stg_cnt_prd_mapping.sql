{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        unique_key = ['month_end_date', 'cnt_id_nk', 'cnt_iss_cd_nk', 'producer_id_nk'],
        file_format = 'delta'
    )
}}

-- Original: create or replace table
--   prod_builder_fieldexperience.fx_test.ppg_stg_cnt_prd_mapping
--
-- WHAT CHANGED
-- Was a full rebuild pinned to CURRENT_DATE. It then became incremental
-- partitioned by a DAILY snapshot_date, which did not match the report: every
-- table downstream of this one is keyed by month_end_date, so a daily grain
-- here meant ~30 partitions per reporting month that all described the same
-- month, and a rerun on a different day quietly changed a published month.
--
-- The partition and the key are now month_end_date, matching ppg_metrics_dtl,
-- ppg_metrics_monthly and ppg_metrics_summ_monthly. snapshot_date is retained
-- as an audit column -- when PDM was read -- and nothing keys or joins on it.
--
-- Backfill a month with:
--   dbt run -s ppg_stg_cnt_prd_mapping --vars '{report_month: "2026-07-31"}'
--
-- That is REFUSED while pdm_history_mode is 'current', because the PDM staging
-- models would return today's contracts to be stamped with July's month end.
-- See tests/assert_backfill_is_honest.sql.

with categorized as (
    select * from {{ ref('int_products__categorized') }}
),

dates as (
    select * from {{ ref('stg_pdm__dates') }}
)

select distinct
    dt.month_end_date,
    dt.snapshot_date,
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
