# dbt Cloud refresh gate simulation

This is a separate dbt project using only synthetic data. Its macros refuse to
run outside `dbt_dev.dbt_refresh_sim_20261001`.

The normal dbt Cloud deployment job commands are:

```text
dbt run-operation check_source_refresh
dbt build --select refresh_sim_output
dbt run-operation record_processed_refresh
```

The project uses four small Delta tables: `source_rows`, `refresh_batches`,
`run_claims`, and `processed_batches`. A successful load is published in
`refresh_batches`. The gate captures its batch ID under `DBT_CLOUD_RUN_ID`;
the build and recording step use that captured batch, rather than querying
the newest timestamp again after the build.

## Scenarios

1. Initialize a partially loaded batch, then run the normal commands. Expect
   `SOURCE_NOT_READY`, no output table, and no processed record.
2. Complete that batch, then force a build failure with
   `--vars '{refresh_sim_force_build_failure: true}'`. Expect no processed
   record, so the same batch remains eligible for retry.
3. Run the normal commands. Expect a two-row output, passing tests, and one
   processed record.
4. Run the normal commands again without changing the source. Expect
   `NO_NEW_REFRESH`; the output and processed record must remain unchanged.

The initialization/completion macros imitate a separate loader for this demo.
They are not part of the normal three-command job.

## Behavior and limits

- The normal job is manually triggered during this simulation. No recurring
  schedule is enabled, and no Databricks job is created.
- The gate deliberately fails an attempt when no completed new batch exists.
  This does not pause the job or produce a clean skipped status.
- The recording step is reached only after a successful build and tests.
- Batch IDs must identify immutable completed payloads.
- This demo assumes one gate/build run at a time. It is not a distributed lock;
  avoid overlapping/manual concurrent runs before adapting it for production.
- This demo covers refresh gating. A business-calendar/reporting-month check
  is a separate addition and is not silently applied to these synthetic rows.
- Preserve the control tables across attempts. Resetting them loses the record
  of processed batches.

See `results.json` and `RESULTS.md` for live evidence once the account runs
have been completed.
