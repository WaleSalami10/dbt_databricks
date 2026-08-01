-- Original CTEs: clients_with_planning + clients_with_planning_v2
--
-- The original built the union, then LEFT JOINed back to two more copies of the
-- same subqueries purely to work out which side each client came from. That is
-- what a conditional aggregate is for. Four subqueries collapse to two refs.
with gm as (
    select
        client_id,
        completed_plan_dt,
        'GM' as plan_source
    from {{ ref('int_planning__gm_clients') }}
),

fp as (
    select
        client_id,
        completed_plan_dt,
        'FP' as plan_source
    from {{ ref('int_planning__fp_clients') }}
),

unioned as (
    select * from gm
    union all
    select * from fp
)

select
    client_id,
    max(case when plan_source = 'GM' then 'Y' else 'N' end)     as gm_flag,
    max(case when plan_source = 'FP' then 'Y' else 'N' end)     as fp_flag,
    -- Always 'Y' by construction: a client_id only reaches this model by
    -- appearing in the GM side, the FP side, or both. The original computed it
    -- as `gm.client_id is not null or fp.client_id is not null` against the
    -- union, which could likewise never be false. Kept as a column so the
    -- output contract is unchanged.
    'Y'                                                          as gm_or_fp_flag,
    min(completed_plan_dt)                                       as completed_plan_dt
from unioned
group by 1
