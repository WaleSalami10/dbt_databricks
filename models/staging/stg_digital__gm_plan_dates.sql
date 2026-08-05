-- Guided Meeting PPG plan dates.
--
-- ⚠ UNRESOLVED: does this need `where type <> 'FB'`? ⚠
-- The second copy of this project (ppg_hist/, now removed) carried that filter
-- and this copy does not. It is the only genuine logic difference between the
-- two -- everything else was formatting. Which one matches the notebook is not
-- recorded anywhere, and the two give different numbers.
--
-- It matters because this model is the GM side of the planning union while
-- ppg_feebased_fp_plans_by_agent is the FP side. If mt__gm_ppg_plan_dates
-- carries type = 'FB' rows, fee-based plans are counted on BOTH sides: those
-- clients get gm_flag = 'Y' as well as fp_flag = 'Y', and gm_plan_sales in
-- ppg_metrics_summ_monthly is overstated. gm_or_fp_flag and total_sales are
-- unaffected, since both are distinct client counts.
--
-- Settle it with:
--   select type, count(*), count(distinct salesforce_id)
--   from prod_execution_fieldexperience.digital.mt__gm_ppg_plan_dates
--   group by 1;
-- If no 'FB' rows exist the filter is a no-op and this note can go. If they do,
-- check the original notebook before adding it -- the fix changes published
-- gm_plan_sales figures.
with gm_plan_dates as (
select
    salesforce_id,
    completed_plan_dt,
    type
from {{ source('digital', 'mt__gm_ppg_plan_dates') }}
)

select * from gm_plan_dates
