{{ config(materialized='table', file_format='delta') }}

{% if var('refresh_sim_force_build_failure', false) %}
  {{ exceptions.raise_compiler_error('SIMULATED_BUILD_FAILURE: confirm the final record command does not run.') }}
{% endif %}

select
    s.batch_id,
    s.row_id,
    s.payload,
    s.loaded_at,
    c.cloud_run_id,
    current_timestamp() as built_at
from {{ refresh_sim_relation('source_rows') }} s
inner join {{ refresh_sim_relation('run_claims') }} c
    on s.batch_id = c.batch_id
where c.cloud_run_id = '{{ refresh_sim_run_id() }}'
