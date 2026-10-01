with expected as (
    select c.batch_id, c.cloud_run_id, b.expected_rows
    from {{ refresh_sim_relation('run_claims') }} c
    join {{ refresh_sim_relation('refresh_batches') }} b
        on c.batch_id = b.batch_id
    where c.cloud_run_id = '{{ refresh_sim_run_id() }}'
), actual as (
    select batch_id, cloud_run_id, count(*) as actual_rows
    from {{ ref('refresh_sim_output') }}
    group by batch_id, cloud_run_id
)
select e.*
from expected e
left join actual a
    on e.batch_id = a.batch_id and e.cloud_run_id = a.cloud_run_id
where coalesce(a.actual_rows, 0) != e.expected_rows
union all
select a.batch_id, a.cloud_run_id, a.actual_rows
from actual a
left join expected e
    on e.batch_id = a.batch_id and e.cloud_run_id = a.cloud_run_id
where e.batch_id is null
