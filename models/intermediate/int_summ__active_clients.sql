-- Original CTE: active_clients
-- A client is "active" for the month if they hold at least one contract whose
-- effective date falls in the trailing 60 months ending at month end.
with dates as (
    select * from {{ ref('stg_pdm__dates') }}
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from {{ ref('ppg_metrics_dtl') }} dtl
inner join dates dt
    on dtl.month_end_date = dt.month_end_date
where dtl.cnt_eff_dt between cast(add_months(dtl.month_end_date, -60) + 1 as date)
                         and dtl.month_end_date
