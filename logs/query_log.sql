-- created_at: 2026-08-05T17:36:43.163228+00:00
-- finished_at: 2026-08-05T17:36:43.952073+00:00
-- elapsed: 788ms
-- outcome: success
-- dialect: databricks
-- node_id: not available
-- query_id: 01f190f4-394d-17e2-972f-1f464db9385c
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "ppg", "target_name": "dev"} */
SHOW SCHEMAS IN `dbt_dev`;
-- created_at: 2026-08-05T17:36:43.995577+00:00
-- finished_at: 2026-08-05T17:36:44.942954+00:00
-- elapsed: 947ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contracts
-- query_id: 01f190f4-39cc-1b5a-ac4f-e65fca13e8ea
-- desc: get_relation > list_relations call

SELECT
    table_name,
    if(table_type IN ('EXTERNAL', 'MANAGED', 'MANAGED_SHALLOW_CLONE', 'EXTERNAL_SHALLOW_CLONE'), 'table', lower(table_type)) AS table_type,
    lower(data_source_format) AS file_format,
    table_schema,
    table_owner,
    table_catalog,
    if(
    table_type IN (
        'EXTERNAL',
        'MANAGED',
        'MANAGED_SHALLOW_CLONE',
        'EXTERNAL_SHALLOW_CLONE'
    ),
    lower(table_type),
    NULL
    ) AS databricks_table_type
FROM `system`.`information_schema`.`tables`
WHERE table_catalog = 'dbt_dev'
    AND table_schema = 'dbt_osalami_staging';
-- created_at: 2026-08-05T17:36:44.944645+00:00
-- finished_at: 2026-08-05T17:36:45.361443+00:00
-- elapsed: 416ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contracts
-- query_id: 01f190f4-3a5c-1bfd-978a-0cb2f422cf5c
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__contracts", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts` AS JSON;
-- created_at: 2026-08-05T17:36:45.373132+00:00
-- finished_at: 2026-08-05T17:36:46.628378+00:00
-- elapsed: 1.3s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contracts
-- query_id: 01f190f4-3a9e-15a3-9f5f-8b2ec4b947a0
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__contracts", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
  
  as (
    with contracts as (
select
    cnt_id_nk,
    cnt_iss_cd_nk,
    plan_cd,
    lob_nm,
    cnt_eff_dt
from `prod_execution_rs`.`ext_pdm`.`dim_contract`
where edh_record_start_ts <= 
    cast(date_add(last_day(date'2026-06-30'), 1) as timestamp) - interval 1 second

        and coalesce(edh_record_end_ts, timestamp'9999-12-31') >= 
    cast(date_add(last_day(date'2026-06-30'), 1) as timestamp) - interval 1 second

)
select * from contracts
  );
