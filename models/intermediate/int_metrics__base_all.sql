-- Original CTE: base_all
--
-- ⚠ BEHAVIOUR CHANGE FORCED BY THE CELL 1 REFACTOR ⚠
-- The original read ppg_stg_cnt_prd_mapping unfiltered, which was safe only
-- because cell 1 did `create or replace` and the table held exactly one
-- snapshot. ppg_stg_cnt_prd_mapping is now incremental and retains history, so
-- reading it unfiltered would multiply every metric by the number of snapshots
-- retained. The snapshot_date filter below is mandatory, not optional.
with mapping as (
    select *
    from {{ ref('ppg_stg_cnt_prd_mapping') }}
    where snapshot_date = {{ snapshot_date() }}
),

dates as (
    select * from {{ ref('stg_pdm__ytd_dates') }}
)

select distinct
    mapp.snapshot_date,
    dt.ytd_end_dt          as month_end_date,
    mapp.lob_nm,
    mapp.cnt_id_nk,
    mapp.cnt_iss_cd_nk,
    mapp.cnt_eff_dt,
    mapp.primry_ownr_cl_id,
    mapp.producer_id_nk,
    mapp.producer_cnt_role_nm,
    mapp.product_category_protection_accumulation_alternate,
    mapp.product_category_need_based_by_product,
    mapp.product_category_risk_wm,
    mapp.product_type
from mapping mapp
inner join dates dt
    on mapp.cnt_eff_dt <= dt.ytd_end_dt
