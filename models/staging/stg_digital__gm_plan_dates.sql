-- Guided Meeting PPG plan dates.
select
    salesforce_id,
    completed_plan_dt,
    type
from {{ source('digital', 'mt__gm_ppg_plan_dates') }}
where type <> 'FB'
