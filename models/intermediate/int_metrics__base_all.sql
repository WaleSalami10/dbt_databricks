-- Original CTE: base_all
--
-- ⚠ BEHAVIOUR CHANGE FORCED BY THE CELL 1 REFACTOR ⚠
-- The original read ppg_stg_cnt_prd_mapping unfiltered, which was safe only
-- because cell 1 did `create or replace` and the table held exactly one
-- snapshot. ppg_stg_cnt_prd_mapping is now incremental and retains history, so
-- reading it unfiltered would multiply every metric by the number of months
-- retained. The month filter below is mandatory, not optional.
--
-- It used to filter on `snapshot_date = current_date`, which coupled this
-- model to the mapping model having run TODAY: if mapping ran at 23:55 and
-- this ran at 00:05, the filter matched nothing and the month came out empty
-- with no error. Filtering on the reporting month removes that coupling and
-- prunes the same partition.
with mapping as (
    select *
    from {{ ref('ppg_stg_cnt_prd_mapping') }}
    where month_end_date = (select month_end_date from {{ ref('stg_pdm__dates') }})
),

dates as (
    select * from {{ ref('stg_pdm__dates') }}
)

select distinct
    mapp.snapshot_date,
    dt.month_end_date,
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
    on mapp.cnt_eff_dt <= dt.month_end_date
