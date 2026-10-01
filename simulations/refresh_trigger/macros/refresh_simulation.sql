{% macro refresh_sim_relation(name) %}
  {% set allowed = ['source_rows', 'refresh_batches', 'run_claims', 'processed_batches', 'refresh_sim_output'] %}
  {% if target.database | lower != 'dbt_dev' or target.schema | lower != 'dbt_refresh_sim_20261001' %}
    {{ exceptions.raise_compiler_error('Simulation requires dbt_dev.dbt_refresh_sim_20261001; refusing another target.') }}
  {% endif %}
  {% if name not in allowed %}
    {{ exceptions.raise_compiler_error('Unexpected simulation relation: ' ~ name) }}
  {% endif %}
  {{ return(adapter.quote(target.database) ~ '.' ~ adapter.quote(target.schema) ~ '.' ~ adapter.quote(name)) }}
{% endmacro %}

{% macro refresh_sim_run_id() %}
  {% set run_id = env_var('DBT_CLOUD_RUN_ID', '') %}
  {% if not run_id or not run_id.isdigit() %}
    {{ exceptions.raise_compiler_error('Run this simulation in a dbt Cloud deployment job with DBT_CLOUD_RUN_ID.') }}
  {% endif %}
  {{ return(run_id) }}
{% endmacro %}

{% macro refresh_sim_initialize() %}
  {% if execute %}
    {% set batches = refresh_sim_relation('refresh_batches') %}
    {% set rows = refresh_sim_relation('source_rows') %}
    {% set claims = refresh_sim_relation('run_claims') %}
    {% set processed = refresh_sim_relation('processed_batches') %}
    {% do run_query('create schema if not exists ' ~ adapter.quote(target.database) ~ '.' ~ adapter.quote(target.schema)) %}
    {% do run_query('create table if not exists ' ~ batches ~ ' (batch_id bigint, status string, expected_rows bigint, completed_at timestamp) using delta') %}
    {% do run_query('create table if not exists ' ~ rows ~ ' (batch_id bigint, row_id bigint, payload string, loaded_at timestamp) using delta') %}
    {% do run_query('create table if not exists ' ~ claims ~ ' (cloud_run_id string, batch_id bigint, checked_at timestamp) using delta') %}
    {% do run_query('create table if not exists ' ~ processed ~ ' (batch_id bigint, cloud_run_id string, processed_at timestamp) using delta') %}
    {% set existing = run_query('select count(*) from ' ~ batches) %}
    {% if existing.rows[0][0] != 0 %}
      {{ exceptions.raise_compiler_error('Simulation already initialized; existing data was preserved.') }}
    {% endif %}
    {% do run_query("insert into " ~ batches ~ " values (1, 'LOADING', 2, null)") %}
    {% do run_query("insert into " ~ rows ~ " values (1, 1, 'synthetic first row', current_timestamp())") %}
    {{ log('SIMULATION_INITIALIZED: batch 1 is LOADING with only 1 of 2 rows.', info=true) }}
  {% endif %}
{% endmacro %}

{% macro refresh_sim_complete_load() %}
  {% if execute %}
    {% set batches = refresh_sim_relation('refresh_batches') %}
    {% set rows = refresh_sim_relation('source_rows') %}
    {% set batch = run_query('select status from ' ~ batches ~ ' where batch_id = 1') %}
    {% if batch.rows | length != 1 %}
      {{ exceptions.raise_compiler_error('Initialize the synthetic batch first.') }}
    {% endif %}
    {% do run_query("merge into " ~ rows ~ " t using (select cast(1 as bigint) batch_id, cast(2 as bigint) row_id, 'synthetic second row' payload, current_timestamp() loaded_at) s on t.batch_id = s.batch_id and t.row_id = s.row_id when not matched then insert *") %}
    {% do run_query("update " ~ batches ~ " set status = 'SUCCESS', completed_at = coalesce(completed_at, current_timestamp()) where batch_id = 1") %}
    {{ log('SIMULATION_REFRESH_COMPLETED: batch 1 now has its 2 rows and a SUCCESS completion record.', info=true) }}
  {% endif %}
{% endmacro %}

{% macro check_source_refresh() %}
  {% if execute %}
    {% set batches = refresh_sim_relation('refresh_batches') %}
    {% set rows = refresh_sim_relation('source_rows') %}
    {% set claims = refresh_sim_relation('run_claims') %}
    {% set processed = refresh_sim_relation('processed_batches') %}
    {% set run_id = refresh_sim_run_id() %}
    {% set batch = run_query('select batch_id, status, expected_rows, completed_at from ' ~ batches ~ ' order by batch_id desc limit 1') %}
    {% if batch.rows | length != 1 %}
      {{ exceptions.raise_compiler_error('SOURCE_NOT_READY: no refresh has been published.') }}
    {% endif %}
    {% set batch_id = batch.rows[0][0] | int %}
    {% if batch.rows[0][1] != 'SUCCESS' or batch.rows[0][3] is none %}
      {{ exceptions.raise_compiler_error('SOURCE_NOT_READY: latest refresh has not completed; dbt build is blocked.') }}
    {% endif %}
    {% set already_processed = run_query('select count(*) from ' ~ processed ~ ' where batch_id = ' ~ batch_id) %}
    {% if already_processed.rows[0][0] != 0 %}
      {{ exceptions.raise_compiler_error('NO_NEW_REFRESH: batch ' ~ batch_id ~ ' was already processed; dbt build is blocked.') }}
    {% endif %}
    {% set actual_rows = run_query('select count(*) from ' ~ rows ~ ' where batch_id = ' ~ batch_id) %}
    {% if actual_rows.rows[0][0] != batch.rows[0][2] %}
      {{ exceptions.raise_compiler_error('SOURCE_NOT_READY: completed batch row count does not match its audit record.') }}
    {% endif %}
    {% do run_query("merge into " ~ claims ~ " t using (select '" ~ run_id ~ "' cloud_run_id, cast(" ~ batch_id ~ " as bigint) batch_id, current_timestamp() checked_at) s on t.cloud_run_id = s.cloud_run_id when not matched then insert *") %}
    {% set claimed = run_query("select batch_id from " ~ claims ~ " where cloud_run_id = '" ~ run_id ~ "'") %}
    {% if claimed.rows | length != 1 or claimed.rows[0][0] != batch_id %}
      {{ exceptions.raise_compiler_error('REFRESH_CHANGED: this run must keep its originally checked batch.') }}
    {% endif %}
    {{ log('NEW_REFRESH_READY: batch ' ~ batch_id ~ ' captured for dbt Cloud run ' ~ run_id ~ '.', info=true) }}
  {% endif %}
{% endmacro %}

{% macro record_processed_refresh() %}
  {% if execute %}
    {% set run_id = refresh_sim_run_id() %}
    {% set claims = refresh_sim_relation('run_claims') %}
    {% set output = refresh_sim_relation('refresh_sim_output') %}
    {% set processed = refresh_sim_relation('processed_batches') %}
    {% set batches = refresh_sim_relation('refresh_batches') %}
    {% set validation = run_query("select c.batch_id, b.expected_rows, count(o.row_id) actual_rows from " ~ claims ~ " c join " ~ batches ~ " b on b.batch_id = c.batch_id left join " ~ output ~ " o on o.batch_id = c.batch_id and o.cloud_run_id = c.cloud_run_id where c.cloud_run_id = '" ~ run_id ~ "' group by c.batch_id, b.expected_rows") %}
    {% if validation.rows | length != 1 or validation.rows[0][1] != validation.rows[0][2] %}
      {{ exceptions.raise_compiler_error('Refusing to record success: output does not match the captured batch and run.') }}
    {% endif %}
    {% do run_query("merge into " ~ processed ~ " t using (select batch_id, cloud_run_id, current_timestamp() processed_at from " ~ claims ~ " where cloud_run_id = '" ~ run_id ~ "') s on t.batch_id = s.batch_id when not matched then insert *") %}
    {{ log('REFRESH_PROCESSED: recorded only the batch captured by this successful run.', info=true) }}
  {% endif %}
{% endmacro %}
