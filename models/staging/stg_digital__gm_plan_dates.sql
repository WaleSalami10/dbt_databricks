-- Guided Meeting PPG plan dates.
with gm_plan_dates as (
select
    salesforce_id,
    completed_plan_dt,
    type
from {{ source('digital', 'mt__gm_ppg_plan_dates') }}
)

select * from gm_plan_dates
