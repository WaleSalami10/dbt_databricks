-- Fee-based financial planning plans by agent.
--
-- NOTE: this lives in prod_builder_fieldexperience.fx_test, the same schema the
-- PPG notebook writes to. It is treated as a source here because nothing in
-- this project builds it. If it is produced by another notebook, that notebook
-- should become a dbt model and this should become a ref().
select
    client_id,
    completed_plan_dt
from {{ source('fx_test', 'ppg_feebased_fp_plans_by_agent') }}
