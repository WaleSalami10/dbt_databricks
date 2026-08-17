{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        file_format = 'delta'
    )
}}

-- Original: cell 3, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_monthly
--
-- WHAT THIS MODEL ACTUALLY DOES
-- It is ppg_metrics_dtl with two columns removed -- cnt_iss_cd_nk and
-- producer_cnt_role_nm -- and NOTHING ELSE. A pure projection.
--
-- ⚠ THERE IS NO `distinct` HERE, AND THAT IS DELIBERATE ⚠
-- This model briefly carried one, on the assumption that the original applied
-- it. It does not: removing the `distinct` is what makes this model's output
-- match the notebook's row for row. Verified by diffing against the legacy
-- table.
--
-- The consequence is that DUPLICATE ROWS ARE EXPECTED. Any two dtl rows that
-- differed only in cnt_iss_cd_nk or producer_cnt_role_nm are byte-identical
-- once those columns are dropped, and both are kept. So:
--
--   * this table has NO unique key -- `unique_key` was removed from the config
--     above rather than left there asserting a grain that does not hold;
--   * row count here equals row count in ppg_metrics_dtl for the same month,
--     because a projection does not change cardinality;
--   * counting rows to count contracts overstates. Use count(distinct
--     cnt_id_nk), which is what ppg_metrics_summ_monthly already does.
--
-- Adding a `distinct` back would be a real improvement, but it changes
-- published figures and it hides the two underlying questions rather than
-- answering them:
--   1. producer fan-out -- the role filters in int_contracts__with_producer
--      are commented out, so one contract can carry several producer roles.
--   2. whether cnt_id_nk is unique without cnt_iss_cd_nk.
-- Resolve those and the duplicates disappear at source, which is the correct
-- fix. See README items 4 and the Grain section.
--
-- The original's `INNER JOIN dates dt ON dt.ytd_end_dt = month_end_date` was
-- doing the job dbt's incremental config now does: pick the one month to
-- append. Kept as an explicit filter so a run is idempotent for a given
-- report_month and `--vars` backfill still works.

with dtl as (

    select * from {{ ref('ppg_metrics_dtl') }}
    -- Restrict to the reporting month, exactly as the original did.
    where month_end_date = (select month_end_date from {{ ref('stg_pdm__dates') }})

),

current_load as (

    select
        snapshot_date,
        month_end_date,
        lob_nm,
        primry_ownr_cl_id,
        cnt_id_nk,
        cnt_eff_dt,
        producer_id_nk,
        product_category_protection_accumulation_alternate,
        product_category_need_based_by_product,
        product_category_risk_wm,
        product_type,
        risk_management_ind,
        wealth_management_ind,
        gm_flag,
        fp_flag,
        gm_or_fp_flag
    from dtl

)

select * from current_load


