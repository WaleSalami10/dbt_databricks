-- Replaces the `dates` CTE in cell 1 (ppg_stg_cnt_prd_mapping).
-- The original hard-coded CURRENT_DATE, which made backfilling impossible.
select distinct
    clndr_dt                    as snapshot_date,
    date_sub(mth_begin_dt, 1)   as month_end_date
from {{ source('pdm', 'dim_date') }}
where clndr_dt = {{ snapshot_date() }}
