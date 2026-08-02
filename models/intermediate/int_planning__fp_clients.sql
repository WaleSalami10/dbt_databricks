-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from {{ ref('stg_fx__feebased_fp_plans') }}
group by 1
)
select * from feebased_fp_clients
