-- Replaces the `dates` CTE in cell 2 (ppg_metrics_dtl).
--
-- Cell 1 anchored on CURRENT_DATE and derived month end as mth_begin_dt - 1.
-- Cell 2 anchored on ADD_MONTHS(CURRENT_DATE, -1) and took mth_end_dt directly.
-- Two different computations of the same value. They agree today, but they are
-- independent, so a change to dim_date could silently split them. The test in
-- _staging.yml asserts month_end_date = ytd_end_dt on every run.
select distinct
    to_date(date_trunc('year', mth_end_dt))      as ytd_begin_dt,
    mth_end_dt                                   as ytd_end_dt,
    date_format(mth_end_dt, 'yyyyMMdd')          as ytd_end_dim_sqn
from {{ source('pdm', 'dim_date') }}
where clndr_dt = add_months({{ snapshot_date() }}, -1)
