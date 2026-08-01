{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        unique_key = ['month_end_date', 'cnt_id_nk', 'producer_id_nk'],
        file_format = 'delta'
    )
}}

-- Original: cell 3, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_monthly
--
-- WHAT THIS MODEL ACTUALLY DOES
-- It is ppg_metrics_dtl with two columns removed -- cnt_iss_cd_nk and
-- producer_cnt_role_nm -- and a `distinct` on top. That is not a cosmetic
-- projection: it is a deliberate grain reduction. See the note in the README.
--
-- The original's `INNER JOIN dates dt ON dt.ytd_end_dt = month_end_date` was
-- doing the job dbt's incremental config now does: pick the one month to
-- append. Kept as an explicit filter so a run is idempotent for a given
-- snapshot_date and `--vars` backfill still works.

with dtl as (

    select * from {{ ref('ppg_metrics_dtl') }}

    {% if not flags.FULL_REFRESH %}
    -- Restrict to the reporting month, exactly as the original did.
    where month_end_date = (select ytd_end_dt from {{ ref('stg_pdm__ytd_dates') }})
    {% endif %}

),

current_load as (

    select distinct
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

{% if var('include_historical_load', false) %}

-- The original carried this branch commented out, together with a
-- double-commented `--WHERE month_end_date -->= ('2025-01-01')`. Enable with:
--   dbt run -s ppg_metrics_monthly --full-refresh \
--     --vars '{include_historical_load: true, historical_load_from: "2025-01-01"}'
--
-- ppg_metrics_dtl_hist is pre-migration history that nothing in this project
-- builds, so it is declared as a source. Once it has been folded in once and
-- the partitions exist, turn this back off -- leaving it on makes every run
-- rescan the legacy table.
, historical as (

    select distinct
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
    from {{ source('ppg_legacy', 'ppg_metrics_dtl_hist') }}
    {% if var('historical_load_from', none) %}
    where month_end_date >= date'{{ var('historical_load_from') }}'
    {% endif %}

)

select * from current_load
union all
select * from historical

{% else %}

select * from current_load

{% endif %}
