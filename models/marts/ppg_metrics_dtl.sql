{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        unique_key = ['month_end_date', 'cnt_id_nk', 'cnt_iss_cd_nk', 'producer_id_nk'],
        file_format = 'delta'
    )
}}

-- Original: cell 2, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_dtl
--
-- Contract-level detail for the reporting month, restricted to contracts whose
-- primary owner was an active policy owner at month end, with planning flags
-- attached.

with base as (
    select * from {{ ref('int_metrics__base_all') }}
),

active_clients as (
    select * from {{ ref('int_clients__active_eop') }}
),

planning as (
    select * from {{ ref('int_clients__planning_flags') }}
)

select distinct
    base.snapshot_date,
    base.month_end_date,
    base.lob_nm,
    base.primry_ownr_cl_id,
    base.cnt_id_nk,
    base.cnt_iss_cd_nk,
    base.cnt_eff_dt,
    base.producer_id_nk,
    base.producer_cnt_role_nm,
    base.product_category_protection_accumulation_alternate,
    base.product_category_need_based_by_product,
    base.product_category_risk_wm,
    base.product_type,

    case when base.product_category_risk_wm = 'Risk Management'
         then 'Y' else 'N' end                          as risk_management_ind,
    case when base.product_category_risk_wm = 'Wealth Management'
         then 'Y' else 'N' end                          as wealth_management_ind,

    -- The original left these NULL for a client whose plan completed AFTER the
    -- reporting month, because the date predicate sits in the LEFT JOIN's ON
    -- clause. That reads as "unknown" when the business meaning is "had not
    -- planned yet as of month end" -- i.e. 'N'. Set coalesce_planning_flags to
    -- false to reproduce the original NULLs exactly.
    {% if var('coalesce_planning_flags', true) %}
    coalesce(pln.gm_flag, 'N')                          as gm_flag,
    coalesce(pln.fp_flag, 'N')                          as fp_flag,
    coalesce(pln.gm_or_fp_flag, 'N')                    as gm_or_fp_flag
    {% else %}
    pln.gm_flag,
    pln.fp_flag,
    pln.gm_or_fp_flag
    {% endif %}

from base
inner join active_clients actcl
    on  actcl.po_client_id_nk = base.primry_ownr_cl_id
    -- Redundant while dates yields one row, but it is the predicate that keeps
    -- this correct if the window is ever widened to several months.
    and actcl.ytd_end_dt      = base.month_end_date
left join planning pln
    on  pln.client_id         = base.primry_ownr_cl_id
    and pln.completed_plan_dt <= base.month_end_date
