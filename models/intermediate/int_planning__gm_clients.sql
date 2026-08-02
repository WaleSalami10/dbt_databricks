-- The sf_account -> gm plan dates join that the original pasted THREE times:
-- once inside clients_with_planning, and twice more inside
-- clients_with_planning_v2. Defined once here.
with gm_clients as (
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from {{ ref('stg_digital__gm_plan_dates') }} gm
inner join {{ ref('stg_crm__sf_account') }} acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
select * from gm_clients
