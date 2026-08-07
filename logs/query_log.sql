-- created_at: 2026-08-06T15:25:02.022118+00:00
-- finished_at: 2026-08-06T15:25:06.429445+00:00
-- elapsed: 4.4s
-- outcome: success
-- dialect: databricks
-- node_id: not available
-- query_id: 01f191aa-fe3b-13ba-a302-5c00fb0b47ba
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "ppg", "target_name": "dev"} */
SHOW SCHEMAS IN `dbt_dev`;
-- created_at: 2026-08-06T15:25:06.959304+00:00
-- finished_at: 2026-08-06T15:25:12.492006+00:00
-- elapsed: 5.5s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account
-- query_id: 01f191ab-012b-1df4-9dc3-98c087fc9e5c
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
-- created_at: 2026-08-06T15:25:07.053935+00:00
-- finished_at: 2026-08-06T15:25:13.281130+00:00
-- elapsed: 6.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contract_producer
-- query_id: 01f191ab-013a-1819-9b80-175fdc8edde9
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
-- created_at: 2026-08-06T15:25:07.534845+00:00
-- finished_at: 2026-08-06T15:25:14.325396+00:00
-- elapsed: 6.8s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_sub_account
-- query_id: 01f191ab-0184-17b9-828c-175a00e55546
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
-- created_at: 2026-08-06T15:25:06.758674+00:00
-- finished_at: 2026-08-06T15:25:16.213922+00:00
-- elapsed: 9.5s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_digital__gm_plan_dates
-- query_id: 01f191ab-010d-1982-a8d2-d013b8f1086c
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
-- created_at: 2026-08-06T15:25:06.839470+00:00
-- finished_at: 2026-08-06T15:25:16.247820+00:00
-- elapsed: 9.4s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__products
-- query_id: 01f191ab-011a-1055-b2b0-4c90e5861c4a
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
-- created_at: 2026-08-06T15:25:06.574178+00:00
-- finished_at: 2026-08-06T15:25:16.272984+00:00
-- elapsed: 9.7s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account_sub_account
-- query_id: 01f191ab-00f1-1652-b258-479f84e07b2b
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
-- created_at: 2026-08-06T15:25:14.326673+00:00
-- finished_at: 2026-08-06T15:25:16.403989+00:00
-- elapsed: 2.1s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_sub_account
-- query_id: 01f191ab-0590-1bec-ae7a-8b7632763b73
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_sub_account", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account` AS JSON;
-- created_at: 2026-08-06T15:25:07.134703+00:00
-- finished_at: 2026-08-06T15:25:16.416899+00:00
-- elapsed: 9.3s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_crm__sf_account
-- query_id: 01f191ab-0147-17ec-8da1-df5884cd077b
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
-- created_at: 2026-08-06T15:25:06.675644+00:00
-- finished_at: 2026-08-06T15:25:16.617109+00:00
-- elapsed: 9.9s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__primary_owner_derv
-- query_id: 01f191ab-0101-1a81-bae3-164885456379
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
-- created_at: 2026-08-06T15:25:13.281976+00:00
-- finished_at: 2026-08-06T15:25:17.994379+00:00
-- elapsed: 4.7s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contract_producer
-- query_id: 01f191ab-04f0-1f60-82ea-714a254ce4f8
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__contract_producer", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contract_producer` AS JSON;
-- created_at: 2026-08-06T15:25:07.777150+00:00
-- finished_at: 2026-08-06T15:25:18.106225+00:00
-- elapsed: 10.3s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__dates
-- query_id: 01f191ab-01a9-1241-b9a1-09c6e0d1a3f7
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
-- created_at: 2026-08-06T15:25:16.214655+00:00
-- finished_at: 2026-08-06T15:25:18.163356+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_digital__gm_plan_dates
-- query_id: 01f191ab-06af-1c3b-866a-b00179cf8f89
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_digital__gm_plan_dates", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates` AS JSON;
-- created_at: 2026-08-06T15:25:16.273521+00:00
-- finished_at: 2026-08-06T15:25:18.283956+00:00
-- elapsed: 2.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account_sub_account
-- query_id: 01f191ab-06b8-197a-8460-15944e7fe2c0
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_account_sub_account", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account` AS JSON;
-- created_at: 2026-08-06T15:25:07.297672+00:00
-- finished_at: 2026-08-06T15:25:18.328105+00:00
-- elapsed: 11.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_fx__feebased_fp_plans
-- query_id: 01f191ab-0160-11ef-9653-e1bc66a64fdc
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
-- created_at: 2026-08-06T15:25:12.492600+00:00
-- finished_at: 2026-08-06T15:25:18.376153+00:00
-- elapsed: 5.9s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account
-- query_id: 01f191ab-0478-1604-a4e9-f494cb277cd0
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_account", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account` AS JSON;
-- created_at: 2026-08-06T15:25:16.248353+00:00
-- finished_at: 2026-08-06T15:25:18.402134+00:00
-- elapsed: 2.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__products
-- query_id: 01f191ab-06b5-183c-b8f9-d55a8ba64bc9
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__products", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__products` AS JSON;
-- created_at: 2026-08-06T15:25:16.417447+00:00
-- finished_at: 2026-08-06T15:25:18.530062+00:00
-- elapsed: 2.1s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_crm__sf_account
-- query_id: 01f191ab-06ce-1bd9-8310-07f014e43e89
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_crm__sf_account", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account` AS JSON;
-- created_at: 2026-08-06T15:25:06.448662+00:00
-- finished_at: 2026-08-06T15:25:20.149315+00:00
-- elapsed: 13.7s
-- outcome: success
-- dialect: databricks
-- node_id: seed.ppg.product_category_map
-- query_id: 01f191ab-00de-128f-a9b4-48cca4d0f237
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
    AND table_schema = 'dbt_osalami_seeds';
-- created_at: 2026-08-06T15:25:18.107146+00:00
-- finished_at: 2026-08-06T15:25:20.349073+00:00
-- elapsed: 2.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__dates
-- query_id: 01f191ab-07d0-1ed8-8fb2-b44164d7ce57
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__dates", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates` AS JSON;
-- created_at: 2026-08-06T15:25:18.328596+00:00
-- finished_at: 2026-08-06T15:25:20.448936+00:00
-- elapsed: 2.1s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_fx__feebased_fp_plans
-- query_id: 01f191ab-07f2-1e4c-8fbe-5cca8bb1da71
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_fx__feebased_fp_plans", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans` AS JSON;
-- created_at: 2026-08-06T15:25:07.216688+00:00
-- finished_at: 2026-08-06T15:25:20.511620+00:00
-- elapsed: 13.3s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account_producer
-- query_id: 01f191ab-0154-149c-82b0-fa250028f329
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
-- created_at: 2026-08-06T15:25:16.618116+00:00
-- finished_at: 2026-08-06T15:25:20.561320+00:00
-- elapsed: 3.9s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__primary_owner_derv
-- query_id: 01f191ab-06ee-113b-a73f-454e0ae95645
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__primary_owner_derv", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv` AS JSON;
-- created_at: 2026-08-06T15:25:20.512229+00:00
-- finished_at: 2026-08-06T15:25:22.288408+00:00
-- elapsed: 1.8s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account_producer
-- query_id: 01f191ab-093f-1f2e-83c0-77e778cddb6b
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_account_producer", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer` AS JSON;
-- created_at: 2026-08-06T15:25:07.625890+00:00
-- finished_at: 2026-08-06T15:25:22.658787+00:00
-- elapsed: 15.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_metrics__policy_owner
-- query_id: 01f191ab-0192-1034-bb26-9b164867bc9c
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
-- created_at: 2026-08-06T15:25:07.375644+00:00
-- finished_at: 2026-08-06T15:25:23.360540+00:00
-- elapsed: 16.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.assert_pdm_retains_versions
-- query_id: 01f191ab-016b-1e50-9596-466a75c35805
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.assert_pdm_retains_versions", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



    select 1 as total_rows, 1 as distinct_keys, 1 as rows_per_key
    where false


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:07.453936+00:00
-- finished_at: 2026-08-06T15:25:23.512895+00:00
-- elapsed: 16.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.assert_backfill_is_honest
-- query_id: 01f191ab-0177-16d7-b177-32e7899cab24
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.assert_backfill_is_honest", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  






    




    select
        1 as requested_report_month, 1 as requested_month_end,
        1 as current_month_end, 1 as pdm_history_mode, 1 as failure_reason
    where false


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:22.659249+00:00
-- finished_at: 2026-08-06T15:25:26.797840+00:00
-- elapsed: 4.1s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_metrics__policy_owner
-- query_id: 01f191ab-0a87-19bc-b8a3-141f38fc8765
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_metrics__policy_owner", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_metrics__policy_owner` AS JSON;
-- created_at: 2026-08-06T15:25:16.410686+00:00
-- finished_at: 2026-08-06T15:25:27.407690+00:00
-- elapsed: 11.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_sub_account
-- query_id: 01f191ab-06ce-1aa5-a863-44ed8c7be98f
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_sub_account", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account`
  
  as (
    with invest_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_sub_acct_iss_cd_nk,
    invest_sub_acct_eff_dt,
    plan_cd,
    product_nm
from `prod_execution_rs`.`ext_pdm`.`dim_invest_sub_account`
where edh_record_status_in = 'A'
  and product_nm in ('EAGLE', 'NYLIFE SEC', 'NP MUTFNDS', 'NP529', 'MAINSTAY')
)
select * from invest_sub_account
  );
-- created_at: 2026-08-06T15:25:17.999111+00:00
-- finished_at: 2026-08-06T15:25:27.818492+00:00
-- elapsed: 9.8s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contract_producer
-- query_id: 01f191ab-07c0-1702-954c-35f9094c194a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__contract_producer", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contract_producer`
  
  as (
    with contract_producer as (
select
    cnt_id_nk,
    cnt_iss_cd_nk,
    producer_id_nk,
    trim(producer_cnt_role_nm) as producer_cnt_role_nm
from `prod_execution_rs`.`ext_pdm`.`fact_contract_cmpnt_producer`
where edh_record_status_in = 'A'
)

select*
from contract_producer
  );
-- created_at: 2026-08-06T15:25:18.379338+00:00
-- finished_at: 2026-08-06T15:25:27.924089+00:00
-- elapsed: 9.5s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account
-- query_id: 01f191ab-07fa-190a-a984-9b17c88d8642
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_account", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account`
  
  as (
    with invest_account as (
select
    invest_acct_id_nk,
    invest_acct_cd
from `prod_execution_rs`.`ext_pdm`.`dim_invest_account`
where edh_record_status_in = 'A'
)
select * from invest_account
  );
-- created_at: 2026-08-06T15:25:18.289434+00:00
-- finished_at: 2026-08-06T15:25:28.008333+00:00
-- elapsed: 9.7s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account_sub_account
-- query_id: 01f191ab-07ed-1417-9591-a1e1f7f3e4b6
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_account_sub_account", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account`
  
  as (
    with invest_account_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_acct_id
from `prod_execution_rs`.`ext_pdm`.`fact_invest_account_sub_account`
where edh_record_status_in = 'A'
)
select * from invest_account_sub_account
  );
-- created_at: 2026-08-06T15:25:18.169290+00:00
-- finished_at: 2026-08-06T15:25:28.454943+00:00
-- elapsed: 10.3s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_digital__gm_plan_dates
-- query_id: 01f191ab-07da-175e-97a2-aa074b6241d0
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_digital__gm_plan_dates", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates`
  
  as (
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
from `prod_execution_fieldexperience`.`digital`.`mt__gm_ppg_plan_dates`
)

select * from gm_plan_dates
  );
-- created_at: 2026-08-06T15:25:20.453419+00:00
-- finished_at: 2026-08-06T15:25:29.019334+00:00
-- elapsed: 8.6s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_fx__feebased_fp_plans
-- query_id: 01f191ab-0936-1a71-bc98-8df40ea1f05b
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_fx__feebased_fp_plans", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
  
  as (
    -- Fee-based financial planning plans by agent.
--
-- NOTE: this lives in prod_builder_fieldexperience.fx_test, the same schema the
-- PPG notebook writes to. It is treated as a source here because nothing in
-- this project builds it. If it is produced by another notebook, that notebook
-- should become a dbt model and this should become a ref().
with feebased_fp_plans as (
select
    client_id,
    completed_plan_dt
from `prod_builder_fieldexperience`.`fx_test`.`ppg_feebased_fp_plans_by_agent`
)
select * from feebased_fp_plans
  );
-- created_at: 2026-08-06T15:25:20.150994+00:00
-- finished_at: 2026-08-06T15:25:29.512898+00:00
-- elapsed: 9.4s
-- outcome: success
-- dialect: databricks
-- node_id: seed.ppg.product_category_map
-- query_id: 01f191ab-0909-100d-a326-cba380866a06
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "seed.ppg.product_category_map", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_seeds`.`product_category_map` AS JSON;
-- created_at: 2026-08-06T15:25:18.535919+00:00
-- finished_at: 2026-08-06T15:25:29.638107+00:00
-- elapsed: 11.1s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_crm__sf_account
-- query_id: 01f191ab-0812-1808-89e2-3fbabd9eff44
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_crm__sf_account", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account`
  
  as (
    -- Salesforce account -> CASE client id crosswalk.
-- The original applied `case_cl_id is not null and case_cl_id <> ''` inside the
-- ON clause of an inner join, which is a WHERE in disguise. Made explicit here
-- so it is applied once rather than in each of the three places the subquery
-- was pasted.

with sf_account as ( 
select distinct
    acct_id_nk,
    case_cl_id
from `prod_execution_datalake`.`lake_int_crm_salescentral`.`sf_account`
where case_cl_id is not null
  and case_cl_id <> ''
  )
  
select * from sf_account
  );
-- created_at: 2026-08-06T15:25:18.405598+00:00
-- finished_at: 2026-08-06T15:25:29.707060+00:00
-- elapsed: 11.3s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__products
-- query_id: 01f191ab-07fe-1695-87e2-2a067b0396ff
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__products", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__products`
  
  as (
    with products as (
select
    plan_cd_nk,
    product_ln_cd,
    product_grp_nm,
    product_nm
from `prod_execution_rs`.`ext_pdm`.`dim_product`
where edh_record_status_in = 'A'
)
select * from products
  );
-- created_at: 2026-08-06T15:25:07.703977+00:00
-- finished_at: 2026-08-06T15:25:29.900369+00:00
-- elapsed: 22.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.assert_pdm_status_matches_version
-- query_id: 01f191ab-019d-1bbb-a17f-be5bde2e38d6
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.assert_pdm_status_matches_version", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

select
    count(*)                                                        as mismatched_rows,
    sum(case when edh_record_status_in = 'A' then 1 else 0 end)     as active_but_closed,
    sum(case when edh_record_status_in <> 'A' then 1 else 0 end)    as inactive_but_open
from `prod_execution_rs`.`ext_pdm`.`dim_contract`
where (edh_record_status_in = 'A')
   <> (edh_record_end_ts >= timestamp'9999-01-01')
having count(*) > 0
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:26.804318+00:00
-- finished_at: 2026-08-06T15:25:30.625952+00:00
-- elapsed: 3.8s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_metrics__policy_owner
-- query_id: 01f191ab-0cff-1f7e-bdbe-71171e2a3ee0
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_metrics__policy_owner", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_metrics__policy_owner`
  
  as (
    -- Source for get_active_cl_eop.
--
-- The original carried a commented-out alternate source:
--   prod_builder_enterprise_silver.lake_oracle_orap18_esda01rpt.rpt_fct_mk_cnt_cmpnt_po_all
-- Preserved as a comment here so the lineage decision stays visible, but the
-- live table is the metrics marketplace one.
with policy_owner as (
select
    po_client_id    as po_client_id_nk,
    dt_key,
    dim_po_status_sk
from `prod_execution_metrics_marketplace`.`metrics359`.`rpt_fct_mk_cnt_cmpnt_po_all`
where dim_po_status_sk in (1, 2, 3)
)
select * from policy_owner
  );
-- created_at: 2026-08-06T15:25:29.904517+00:00
-- finished_at: 2026-08-06T15:25:31.058866+00:00
-- elapsed: 1.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contracts
-- query_id: 01f191ab-0ed9-1575-afdd-c2fbde475a52
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__contracts", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts` AS JSON;
-- created_at: 2026-08-06T15:25:22.294265+00:00
-- finished_at: 2026-08-06T15:25:31.134738+00:00
-- elapsed: 8.8s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__invest_account_producer
-- query_id: 01f191ab-0a50-11b4-85af-377c64596ab7
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__invest_account_producer", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer`
  
  as (
    -- NB: the source column really is spelled `prodcuer_role_cd_desc`.
-- Renamed here so the typo stops leaking into every downstream model.
with invest_account_producer as (
select
    invest_acct_id_nk,
    invest_acct_cd,
    producer_id_nk,
    trim(prodcuer_role_cd_desc) as producer_cnt_role_nm
from `prod_execution_rs`.`ext_pdm`.`fact_invest_account_producer_role`
where edh_record_status_in = 'A'
)
select * from invest_account_producer
  );
-- created_at: 2026-08-06T15:25:20.566200+00:00
-- finished_at: 2026-08-06T15:25:31.429783+00:00
-- elapsed: 10.9s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__primary_owner_derv
-- query_id: 01f191ab-0948-1b60-86fe-4654457aee12
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__primary_owner_derv", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
  
  as (
    with primary_owner_derv as (
select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id,
    primry_ownr_cl_role_eff_dt,
    rec_tp_cd
from `prod_execution_rs`.`ext_pdm`.`fact_primary_owner_derv`
where edh_record_status_in = 'A'
)
select * from primary_owner_derv
  );
-- created_at: 2026-08-06T15:25:20.354145+00:00
-- finished_at: 2026-08-06T15:25:31.596702+00:00
-- elapsed: 11.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__dates
-- query_id: 01f191ab-0928-11a6-a5e9-33dbb3f5f610
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.stg_pdm__dates", "profile_name": "ppg", "target_name": "dev"} */
create or replace view `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
  
  as (
    -- THE DATE SPINE. Exactly one row, and every other model derives its dates
-- from here.
--
-- WHAT CHANGED AND WHY
-- This is a MONTHLY report, but the pipeline used to be anchored on a day.
-- The original `dates` CTE in cell 1 filtered dim_date to CURRENT_DATE and
-- cell 2 filtered it independently to ADD_MONTHS(CURRENT_DATE, -1). Both
-- always collapsed to the same previous month end no matter which day you ran
-- them, so the daily anchor carried no information -- it only made
-- ppg_stg_cnt_prd_mapping write one partition per day, and made a rerun on a
-- different day silently change an already-published month.
--
-- The reporting month is now an explicit input, ppg_var('report_month'), and it
-- accepts any day inside the target month. month_end_date is resolved from
-- dim_date, so it is a real calendar date rather than an arithmetic guess.
--
-- snapshot_date is NOT a key. It records when PDM was observed, so that a
-- month captured four days late is distinguishable from one captured on time.
-- See macros/report_dates.sql for why the two dates are separate.
with dates as (
    select distinct
        current_date                       as snapshot_date,
        mth_end_dt                                   as month_end_date,
        to_date(date_trunc('year', mth_end_dt))      as ytd_begin_dt,
        date_format(mth_end_dt, 'yyyyMMdd')          as month_end_dim_sqn
    from `prod_execution_rs`.`ext_pdm`.`dim_date`
    where clndr_dt = add_months(current_date, -1)
)
select * from dates
  );
-- created_at: 2026-08-06T15:25:29.035333+00:00
-- finished_at: 2026-08-06T15:25:33.175031+00:00
-- elapsed: 4.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_planning__fp_clients_client_id.b6adc1b83f
-- query_id: 01f191ab-0e54-1b2c-bc99-eb6f0df4ff0d
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_planning__fp_clients_client_id.b6adc1b83f", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select client_id
from __dbt__cte__int_planning__fp_clients
where client_id is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:29.035333+00:00
-- finished_at: 2026-08-06T15:25:33.586313+00:00
-- elapsed: 4.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_planning__fp_clients_client_id.335dc01a90
-- query_id: 01f191ab-0e54-151a-aaa7-1c74d731603a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_planning__fp_clients_client_id.335dc01a90", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    

select
    client_id as unique_field,
    count(*) as n_records

from __dbt__cte__int_planning__fp_clients
where client_id is not null
group by client_id
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:30.640758+00:00
-- finished_at: 2026-08-06T15:25:33.930877+00:00
-- elapsed: 3.3s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_metrics__policy_owner_po_client_id_nk.1ba11d3319
-- query_id: 01f191ab-0f49-1eca-bbc1-79e70cff181f
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_metrics__policy_owner_po_client_id_nk.1ba11d3319", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select po_client_id_nk
from `dbt_dev`.`dbt_osalami_staging`.`stg_metrics__policy_owner`
where po_client_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:29.648126+00:00
-- finished_at: 2026-08-06T15:25:34.047971+00:00
-- elapsed: 4.4s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_crm__sf_account_case_cl_id.edfd4a31db
-- query_id: 01f191ab-0eb1-1c71-80d5-fd250a055fdd
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_crm__sf_account_case_cl_id.edfd4a31db", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select case_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account`
where case_cl_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.451148+00:00
-- finished_at: 2026-08-06T15:25:35.013230+00:00
-- elapsed: 3.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_owners__by_invest_acct_cnt_acct_id_nk.c3e608a7e8
-- query_id: 01f191ab-0fc4-1f8f-a774-acfae859576e
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_owners__by_invest_acct_cnt_acct_id_nk.c3e608a7e8", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    

select
    cnt_acct_id_nk as unique_field,
    count(*) as n_records

from __dbt__cte__int_owners__by_invest_acct
where cnt_acct_id_nk is not null
group by cnt_acct_id_nk
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.451130+00:00
-- finished_at: 2026-08-06T15:25:35.184631+00:00
-- elapsed: 3.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_owners__by_contract_cnt_acct_id_nk.4af90caf14
-- query_id: 01f191ab-0fc4-1e68-a903-54a5ab3f0eae
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_owners__by_contract_cnt_acct_id_nk.4af90caf14", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'CONTRACT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    

select
    cnt_acct_id_nk as unique_field,
    count(*) as n_records

from __dbt__cte__int_owners__by_contract
where cnt_acct_id_nk is not null
group by cnt_acct_id_nk
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.451050+00:00
-- finished_at: 2026-08-06T15:25:35.226450+00:00
-- elapsed: 3.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_owners__by_invest_acct_cnt_acct_id_nk.85eb09e9a8
-- query_id: 01f191ab-0fc5-19c9-ad18-0c451e1d6154
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_owners__by_invest_acct_cnt_acct_id_nk.85eb09e9a8", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select cnt_acct_id_nk
from __dbt__cte__int_owners__by_invest_acct
where cnt_acct_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.064299+00:00
-- finished_at: 2026-08-06T15:25:35.275059+00:00
-- elapsed: 4.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.stg_pdm__contracts
-- query_id: 01f191ab-0f89-1d70-9365-af6886a2475a
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
where edh_record_status_in = 'A'
)
select * from contracts
  );
-- created_at: 2026-08-06T15:25:31.451129+00:00
-- finished_at: 2026-08-06T15:25:35.392689+00:00
-- elapsed: 3.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_owners__by_contract_cnt_acct_id_nk.92805b3037
-- query_id: 01f191ab-0fc5-1594-973b-7425f228f636
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_owners__by_contract_cnt_acct_id_nk.92805b3037", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'CONTRACT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select cnt_acct_id_nk
from __dbt__cte__int_owners__by_contract
where cnt_acct_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:35.286447+00:00
-- finished_at: 2026-08-06T15:25:38.766102+00:00
-- elapsed: 3.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_stg_pdm__contracts_cnt_id_nk__cnt_iss_cd_nk.84f9ceaf8d
-- query_id: 01f191ab-120e-158c-bfd5-adf6764f3695
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_stg_pdm__contracts_cnt_id_nk__cnt_iss_cd_nk.84f9ceaf8d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        cnt_id_nk, cnt_iss_cd_nk
    from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
    group by cnt_id_nk, cnt_iss_cd_nk
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.609515+00:00
-- finished_at: 2026-08-06T15:25:39.106543+00:00
-- elapsed: 7.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__dates_month_end_date.3c4a5d713c
-- query_id: 01f191ab-0fdd-109a-9949-a3d064882ddd
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__dates_month_end_date.3c4a5d713c", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.610002+00:00
-- finished_at: 2026-08-06T15:25:39.165337+00:00
-- elapsed: 7.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__dates_snapshot_date.2d2296f657
-- query_id: 01f191ab-0fdd-1ad5-8b18-0375549e3919
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__dates_snapshot_date.2d2296f657", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select snapshot_date
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
where snapshot_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:34.054479+00:00
-- finished_at: 2026-08-06T15:25:39.604548+00:00
-- elapsed: 5.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_planning__gm_clients_client_id.25e1949c66
-- query_id: 01f191ab-1152-14c9-9a96-f5dbc200a10e
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_planning__gm_clients_client_id.25e1949c66", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__gm_clients as (
-- The sf_account -> gm plan dates join that the original pasted THREE times:
-- once inside clients_with_planning, and twice more inside
-- clients_with_planning_v2. Defined once here.
with gm_clients as (
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
select * from gm_clients
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    

select
    client_id as unique_field,
    count(*) as n_records

from __dbt__cte__int_planning__gm_clients
where client_id is not null
group by client_id
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:34.055775+00:00
-- finished_at: 2026-08-06T15:25:39.795422+00:00
-- elapsed: 5.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_planning__gm_clients_client_id.67a0241c46
-- query_id: 01f191ab-1152-1a4e-b5ce-9d35216e2b56
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_planning__gm_clients_client_id.67a0241c46", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__gm_clients as (
-- The sf_account -> gm plan dates join that the original pasted THREE times:
-- once inside clients_with_planning, and twice more inside
-- clients_with_planning_v2. Defined once here.
with gm_clients as (
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
select * from gm_clients
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select client_id
from __dbt__cte__int_planning__gm_clients
where client_id is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:38.781877+00:00
-- finished_at: 2026-08-06T15:25:40.675385+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_int_contracts__scoped_cnt_id_nk__cnt_iss_cd_nk__plan_cd.de598a0224
-- query_id: 01f191ab-1423-1485-89d2-b485ced603e4
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_int_contracts__scoped_cnt_id_nk__cnt_iss_cd_nk__plan_cd.de598a0224", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_contracts__scoped as (
-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (






with validation_errors as (

    select
        cnt_id_nk, cnt_iss_cd_nk, plan_cd
    from __dbt__cte__int_contracts__scoped
    group by cnt_id_nk, cnt_iss_cd_nk, plan_cd
    having count(*) > 1

)

select *
from validation_errors



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:38.781117+00:00
-- finished_at: 2026-08-06T15:25:40.820350+00:00
-- elapsed: 2.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_contracts__scoped_cnt_id_nk.f41f183cdb
-- query_id: 01f191ab-1423-1764-9c35-a3165fe2369e
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_contracts__scoped_cnt_id_nk.f41f183cdb", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_contracts__scoped as (
-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select cnt_id_nk
from __dbt__cte__int_contracts__scoped
where cnt_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:39.810017+00:00
-- finished_at: 2026-08-06T15:25:43.451722+00:00
-- elapsed: 3.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_clients__planning_flags_client_id.c05be35a43
-- query_id: 01f191ab-14bf-1eb3-ae5d-8c2d54c609e8
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_clients__planning_flags_client_id.c05be35a43", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__gm_clients as (
-- The sf_account -> gm plan dates join that the original pasted THREE times:
-- once inside clients_with_planning, and twice more inside
-- clients_with_planning_v2. Defined once here.
with gm_clients as (
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
select * from gm_clients
), __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
), __dbt__cte__int_clients__planning_flags as (
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
    from __dbt__cte__int_planning__gm_clients
),

fp as (
    select
        client_id,
        completed_plan_dt,
        'FP' as plan_source
    from __dbt__cte__int_planning__fp_clients
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
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select client_id
from __dbt__cte__int_clients__planning_flags
where client_id is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:39.810237+00:00
-- finished_at: 2026-08-06T15:25:43.453892+00:00
-- elapsed: 3.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_clients__planning_flags_completed_plan_dt.c6239071ea
-- query_id: 01f191ab-14c0-1a2e-b85b-9a0447fb746b
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_clients__planning_flags_completed_plan_dt.c6239071ea", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__gm_clients as (
-- The sf_account -> gm plan dates join that the original pasted THREE times:
-- once inside clients_with_planning, and twice more inside
-- clients_with_planning_v2. Defined once here.
with gm_clients as (
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
select * from gm_clients
), __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
), __dbt__cte__int_clients__planning_flags as (
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
    from __dbt__cte__int_planning__gm_clients
),

fp as (
    select
        client_id,
        completed_plan_dt,
        'FP' as plan_source
    from __dbt__cte__int_planning__fp_clients
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
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select completed_plan_dt
from __dbt__cte__int_clients__planning_flags
where completed_plan_dt is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:39.810276+00:00
-- finished_at: 2026-08-06T15:25:43.657001+00:00
-- elapsed: 3.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_clients__planning_flags_client_id.c0c995a5be
-- query_id: 01f191ab-14c1-12e8-932f-a1ab7ac1eeaf
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_clients__planning_flags_client_id.c0c995a5be", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__gm_clients as (
-- The sf_account -> gm plan dates join that the original pasted THREE times:
-- once inside clients_with_planning, and twice more inside
-- clients_with_planning_v2. Defined once here.
with gm_clients as (
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
select * from gm_clients
), __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
), __dbt__cte__int_clients__planning_flags as (
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
    from __dbt__cte__int_planning__gm_clients
),

fp as (
    select
        client_id,
        completed_plan_dt,
        'FP' as plan_source
    from __dbt__cte__int_planning__fp_clients
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
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    

select
    client_id as unique_field,
    count(*) as n_records

from __dbt__cte__int_clients__planning_flags
where client_id is not null
group by client_id
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:29.526555+00:00
-- finished_at: 2026-08-06T15:25:43.913553+00:00
-- elapsed: 14.4s
-- outcome: success
-- dialect: databricks
-- node_id: seed.ppg.product_category_map
-- query_id: 01f191ab-0ea0-129b-8268-47e730a04022
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "seed.ppg.product_category_map", "profile_name": "ppg", "target_name": "dev"} */
create or replace table `dbt_dev`.`dbt_osalami_seeds`.`product_category_map` (`product_ln_cd` string ,`product_grp_nm` string ,`product_nm` string ,`product_category_risk_wm` string ,`product_category_protection_accumulation_alternate` string ,`product_category_need_based_by_product` string ,`product_type` string )
    
    
      using delta;
-- created_at: 2026-08-06T15:25:31.610210+00:00
-- finished_at: 2026-08-06T15:25:44.065690+00:00
-- elapsed: 12.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_stg_pdm__dates_month_end_date.8f349a8d9d
-- query_id: 01f191ab-0fdd-1795-a73b-0a550689a1d1
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_stg_pdm__dates_month_end_date.8f349a8d9d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    month_end_date as unique_field,
    count(*) as n_records

from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
where month_end_date is not null
group by month_end_date
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.608368+00:00
-- finished_at: 2026-08-06T15:25:44.164459+00:00
-- elapsed: 12.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.assert_month_end_is_calendar
-- query_id: 01f191ab-0fdc-1ceb-9b0c-5bdbd6d7623c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.assert_month_end_is_calendar", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

select
    month_end_date,
    last_day(month_end_date)    as calendar_month_end
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
where month_end_date <> last_day(month_end_date)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.608947+00:00
-- finished_at: 2026-08-06T15:25:44.174543+00:00
-- elapsed: 12.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__dates_ytd_begin_dt.a418130627
-- query_id: 01f191ab-0fdd-131c-b61a-907c07ff20e1
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__dates_ytd_begin_dt.a418130627", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ytd_begin_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
where ytd_begin_dt is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:31.609548+00:00
-- finished_at: 2026-08-06T15:25:44.468499+00:00
-- elapsed: 12.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__dates_month_end_dim_sqn.5582ed92f7
-- query_id: 01f191ab-0fdd-1d21-b703-d42d053d9b25
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__dates_month_end_dim_sqn.5582ed92f7", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_dim_sqn
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
where month_end_dim_sqn is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:44.479751+00:00
-- finished_at: 2026-08-06T15:25:47.820100+00:00
-- elapsed: 3.3s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_clients__active_eop_po_client_id_nk.f106377f37
-- query_id: 01f191ab-1789-186a-81b2-a25dfe7d4543
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_clients__active_eop_po_client_id_nk.f106377f37", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_clients__active_eop as (
-- Original CTE: get_active_cl_eop
-- Clients with an active policy-owner record as of the reporting month end.

with active_cl_eop as (
select distinct
    po.po_client_id_nk,
    dt.month_end_date
from `dbt_dev`.`dbt_osalami_staging`.`stg_metrics__policy_owner` po
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates` dt
    on po.dt_key = dt.month_end_dim_sqn
)
select * from active_cl_eop
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select po_client_id_nk
from __dbt__cte__int_clients__active_eop
where po_client_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:40.850273+00:00
-- finished_at: 2026-08-06T15:25:48.274943+00:00
-- elapsed: 7.4s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_products__unified_cnt_id_nk.5323da792a
-- query_id: 01f191ab-155f-1da0-adc6-b9cc79788f05
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_products__unified_cnt_id_nk.5323da792a", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_contracts__scoped as (
-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'CONTRACT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_contracts__with_producer as (
-- Original CTE: core
--
-- The original wrote this as three near-identical UNION ALL branches that
-- differed only by (a) which LOBs they let through and (b) which producer-role
-- filter was commented out. The LOB split is handled upstream in
-- int_contracts__scoped, so one branch covers all three.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Every `and cp.producer_cnt_role_nm = '...'` line below is commented out,
-- verbatim from the notebook. With them off, a contract carrying three
-- producers in three roles produces THREE ROWS, and `select distinct` does not
-- collapse them because the producer columns differ. That fan-out reaches
-- ppg_metrics_dtl and ppg_metrics_monthly, so contract counts there are
-- inflated wherever a contract has more than one producer.
--
-- It does NOT reach ppg_metrics_summ_monthly -- every figure there is a
-- count(distinct client) or count(distinct contract), so duplicate producer
-- rows collapse. The summary is safe; the two detail tables are the ones to
-- check.
--
-- Uncomment the line for a LOB to restore that filter. Note they are per-LOB
-- because the original applied a different role to each branch, so switching
-- one on does not imply the others.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contract_producer`
),

joined as (
    select
        cn.lob_nm,
        cn.plan_cd,
        cn.cnt_id_nk,
        cn.cnt_iss_cd_nk,
        cn.cnt_eff_dt,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
        -- LIFE INSURANCE  branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- ANNUITIES       branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- LONG TERM CARE  branch:
        -- and cp.producer_cnt_role_nm = 'PERMANENT SERVICING PRODUCER'
        -- IDI             branch:
        -- and cp.producer_cnt_role_nm = 'UNKNOWN'
)

select distinct
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_wm_accounts as (
-- Original CTE: wm_accounts

with wm_accounts as (
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
)
select * from wm_accounts
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_wm_accounts__with_producer as (
-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. The product_nm split is handled upstream in
-- stg_pdm__invest_sub_account, so one branch covers both.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Same fan-out caveat as int_contracts__with_producer -- see the header there.
-- The two branches used DIFFERENT roles, so uncommenting is per product family,
-- not all-or-nothing.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer`
),

joined as (
    select
        cn.product_nm                       as lob_nm,
        cn.plan_cd,
        cn.invest_acct_id                   as cnt_id_nk,
        cn.invest_acct_cd                   as cnt_iss_cd_nk,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
        -- EAGLE / NYLIFE SEC / MAINSTAY branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- NP MUTFNDS / NP529           branch:
        -- and cp.producer_cnt_role_nm = 'PRODUCER OF RECORD'
    -- Was `group by 1..8`; column 8 was the seed's preferred_producer_role_nm.
    -- Dropping it does not change the grouping -- it was functionally dependent
    -- on lob_nm, which is still column 1.
    group by 1, 2, 3, 4, 5, 6, 7
)

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_products__unified as (
-- Original CTE: core_wm
--
-- This is the contract between the insurance side and the wealth side. Any
-- column added to one branch must be added to the other. Grain and tests are
-- declared in _intermediate.yml -- test here, not only at the mart.
with unified_products as (
select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'CONTRACT' as source_domain
from __dbt__cte__int_contracts__with_producer

union all

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'INVEST_ACCT' as source_domain
from __dbt__cte__int_wm_accounts__with_producer
)
select * from unified_products
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select cnt_id_nk
from __dbt__cte__int_products__unified
where cnt_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:40.850284+00:00
-- finished_at: 2026-08-06T15:25:48.420070+00:00
-- elapsed: 7.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_products__unified_lob_nm.1c72e7adf1
-- query_id: 01f191ab-1561-1840-a311-cb0a4abaab62
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_products__unified_lob_nm.1c72e7adf1", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_contracts__scoped as (
-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'CONTRACT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_contracts__with_producer as (
-- Original CTE: core
--
-- The original wrote this as three near-identical UNION ALL branches that
-- differed only by (a) which LOBs they let through and (b) which producer-role
-- filter was commented out. The LOB split is handled upstream in
-- int_contracts__scoped, so one branch covers all three.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Every `and cp.producer_cnt_role_nm = '...'` line below is commented out,
-- verbatim from the notebook. With them off, a contract carrying three
-- producers in three roles produces THREE ROWS, and `select distinct` does not
-- collapse them because the producer columns differ. That fan-out reaches
-- ppg_metrics_dtl and ppg_metrics_monthly, so contract counts there are
-- inflated wherever a contract has more than one producer.
--
-- It does NOT reach ppg_metrics_summ_monthly -- every figure there is a
-- count(distinct client) or count(distinct contract), so duplicate producer
-- rows collapse. The summary is safe; the two detail tables are the ones to
-- check.
--
-- Uncomment the line for a LOB to restore that filter. Note they are per-LOB
-- because the original applied a different role to each branch, so switching
-- one on does not imply the others.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contract_producer`
),

joined as (
    select
        cn.lob_nm,
        cn.plan_cd,
        cn.cnt_id_nk,
        cn.cnt_iss_cd_nk,
        cn.cnt_eff_dt,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
        -- LIFE INSURANCE  branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- ANNUITIES       branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- LONG TERM CARE  branch:
        -- and cp.producer_cnt_role_nm = 'PERMANENT SERVICING PRODUCER'
        -- IDI             branch:
        -- and cp.producer_cnt_role_nm = 'UNKNOWN'
)

select distinct
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_wm_accounts as (
-- Original CTE: wm_accounts

with wm_accounts as (
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
)
select * from wm_accounts
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_wm_accounts__with_producer as (
-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. The product_nm split is handled upstream in
-- stg_pdm__invest_sub_account, so one branch covers both.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Same fan-out caveat as int_contracts__with_producer -- see the header there.
-- The two branches used DIFFERENT roles, so uncommenting is per product family,
-- not all-or-nothing.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer`
),

joined as (
    select
        cn.product_nm                       as lob_nm,
        cn.plan_cd,
        cn.invest_acct_id                   as cnt_id_nk,
        cn.invest_acct_cd                   as cnt_iss_cd_nk,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
        -- EAGLE / NYLIFE SEC / MAINSTAY branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- NP MUTFNDS / NP529           branch:
        -- and cp.producer_cnt_role_nm = 'PRODUCER OF RECORD'
    -- Was `group by 1..8`; column 8 was the seed's preferred_producer_role_nm.
    -- Dropping it does not change the grouping -- it was functionally dependent
    -- on lob_nm, which is still column 1.
    group by 1, 2, 3, 4, 5, 6, 7
)

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_products__unified as (
-- Original CTE: core_wm
--
-- This is the contract between the insurance side and the wealth side. Any
-- column added to one branch must be added to the other. Grain and tests are
-- declared in _intermediate.yml -- test here, not only at the mart.
with unified_products as (
select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'CONTRACT' as source_domain
from __dbt__cte__int_contracts__with_producer

union all

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'INVEST_ACCT' as source_domain
from __dbt__cte__int_wm_accounts__with_producer
)
select * from unified_products
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select lob_nm
from __dbt__cte__int_products__unified
where lob_nm is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:40.850276+00:00
-- finished_at: 2026-08-06T15:25:48.425022+00:00
-- elapsed: 7.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_int_products__unified_cnt_id_nk__cnt_iss_cd_nk__plan_cd__producer_id_nk.65992b2589
-- query_id: 01f191ab-1562-12e9-96a5-8a1f5508eb87
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_int_products__unified_cnt_id_nk__cnt_iss_cd_nk__plan_cd__producer_id_nk.65992b2589", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_contracts__scoped as (
-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'CONTRACT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_contracts__with_producer as (
-- Original CTE: core
--
-- The original wrote this as three near-identical UNION ALL branches that
-- differed only by (a) which LOBs they let through and (b) which producer-role
-- filter was commented out. The LOB split is handled upstream in
-- int_contracts__scoped, so one branch covers all three.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Every `and cp.producer_cnt_role_nm = '...'` line below is commented out,
-- verbatim from the notebook. With them off, a contract carrying three
-- producers in three roles produces THREE ROWS, and `select distinct` does not
-- collapse them because the producer columns differ. That fan-out reaches
-- ppg_metrics_dtl and ppg_metrics_monthly, so contract counts there are
-- inflated wherever a contract has more than one producer.
--
-- It does NOT reach ppg_metrics_summ_monthly -- every figure there is a
-- count(distinct client) or count(distinct contract), so duplicate producer
-- rows collapse. The summary is safe; the two detail tables are the ones to
-- check.
--
-- Uncomment the line for a LOB to restore that filter. Note they are per-LOB
-- because the original applied a different role to each branch, so switching
-- one on does not imply the others.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contract_producer`
),

joined as (
    select
        cn.lob_nm,
        cn.plan_cd,
        cn.cnt_id_nk,
        cn.cnt_iss_cd_nk,
        cn.cnt_eff_dt,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
        -- LIFE INSURANCE  branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- ANNUITIES       branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- LONG TERM CARE  branch:
        -- and cp.producer_cnt_role_nm = 'PERMANENT SERVICING PRODUCER'
        -- IDI             branch:
        -- and cp.producer_cnt_role_nm = 'UNKNOWN'
)

select distinct
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_wm_accounts as (
-- Original CTE: wm_accounts

with wm_accounts as (
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
)
select * from wm_accounts
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_wm_accounts__with_producer as (
-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. The product_nm split is handled upstream in
-- stg_pdm__invest_sub_account, so one branch covers both.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Same fan-out caveat as int_contracts__with_producer -- see the header there.
-- The two branches used DIFFERENT roles, so uncommenting is per product family,
-- not all-or-nothing.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer`
),

joined as (
    select
        cn.product_nm                       as lob_nm,
        cn.plan_cd,
        cn.invest_acct_id                   as cnt_id_nk,
        cn.invest_acct_cd                   as cnt_iss_cd_nk,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
        -- EAGLE / NYLIFE SEC / MAINSTAY branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- NP MUTFNDS / NP529           branch:
        -- and cp.producer_cnt_role_nm = 'PRODUCER OF RECORD'
    -- Was `group by 1..8`; column 8 was the seed's preferred_producer_role_nm.
    -- Dropping it does not change the grouping -- it was functionally dependent
    -- on lob_nm, which is still column 1.
    group by 1, 2, 3, 4, 5, 6, 7
)

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_products__unified as (
-- Original CTE: core_wm
--
-- This is the contract between the insurance side and the wealth side. Any
-- column added to one branch must be added to the other. Grain and tests are
-- declared in _intermediate.yml -- test here, not only at the mart.
with unified_products as (
select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'CONTRACT' as source_domain
from __dbt__cte__int_contracts__with_producer

union all

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'INVEST_ACCT' as source_domain
from __dbt__cte__int_wm_accounts__with_producer
)
select * from unified_products
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (






with validation_errors as (

    select
        cnt_id_nk, cnt_iss_cd_nk, plan_cd, producer_id_nk
    from __dbt__cte__int_products__unified
    group by cnt_id_nk, cnt_iss_cd_nk, plan_cd, producer_id_nk
    having count(*) > 1

)

select *
from validation_errors



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:44.479906+00:00
-- finished_at: 2026-08-06T15:25:49.845537+00:00
-- elapsed: 5.4s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_clients__active_eop_po_client_id_nk.d33fe6dfaa
-- query_id: 01f191ab-1789-12fc-adda-5dcbd49e32e9
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_clients__active_eop_po_client_id_nk.d33fe6dfaa", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_clients__active_eop as (
-- Original CTE: get_active_cl_eop
-- Clients with an active policy-owner record as of the reporting month end.

with active_cl_eop as (
select distinct
    po.po_client_id_nk,
    dt.month_end_date
from `dbt_dev`.`dbt_osalami_staging`.`stg_metrics__policy_owner` po
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates` dt
    on po.dt_key = dt.month_end_dim_sqn
)
select * from active_cl_eop
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    

select
    po_client_id_nk as unique_field,
    count(*) as n_records

from __dbt__cte__int_clients__active_eop
where po_client_id_nk is not null
group by po_client_id_nk
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:43.974918+00:00
-- finished_at: 2026-08-06T15:25:51.710716+00:00
-- elapsed: 7.7s
-- outcome: success
-- dialect: databricks
-- node_id: seed.ppg.product_category_map
-- query_id: 01f191ab-173c-16cc-93f4-499ea0b5545e
-- desc: add_query adapter call
insert overwrite `dbt_dev`.`dbt_osalami_seeds`.`product_category_map` values
          ('LIFE','CUSTOM SURVIVORSHIP WHOLE LIFE','*','Risk Management','Life Insurance','Accumulation Life','Custom Whole Life'),('LIFE','CUSTOM WHOLE LIFE','*','Risk Management','Life Insurance','Accumulation Life','Custom Whole Life'),('LIFE','VARIABLE LIFE','*','Risk Management','Life Insurance','Accumulation Life','Variable Life'),('LIFE','VARIABLE LIFE','NEW YORK LIFE MARKET WEALTH PLUS','Risk Management','Life Insurance','Accumulation Life','Market Wealth Plus'),('LIFE','SURVIVORSHIP VARIABLE LIFE','*','Risk Management','Life Insurance','Accumulation Life','Variable Life'),('LIFE','SINGLE PREMIUM VARIABLE LIFE','*','Risk Management','Life Insurance','Accumulation Life','Variable Life'),('LIFE','SECURE WEALTH PLUS','*','Risk Management','Life Insurance','Accumulation Life','Secure Wealth Plus'),('LIFE','LEVEL TERM','*','Risk Management','Life Insurance','Protection Life','Level Term and Level Convertible_Renewable Term'),('LIFE','LEVEL CONVERTIBLE TERM','*','Risk Management','Life Insurance','Protection Life','Level Term and Level Convertible_Renewable Term'),('LIFE','LEVEL RENEWABLE TERM','*','Risk Management','Life Insurance','Protection Life','Level Term and Level Convertible_Renewable Term'),('LIFE','YEARLY RENEWABLE TERM','*','Risk Management','Life Insurance','Protection Life','Yearly Convertible_Renewable Term'),('LIFE','YEARLY CONVERTIBLE TERM','*','Risk Management','Life Insurance','Protection Life','Yearly Convertible_Renewable Term'),('LIFE','EMPLOYEE WHOLE LIFE','*','Risk Management','Life Insurance','Protection Life','Employee Whole Life'),('LIFE','WHOLE LIFE','*','Risk Management','Life Insurance','Protection Life','Whole Life'),('LIFE','VALUE WHOLE LIFE','*','Risk Management','Life Insurance','Protection Life','Whole Life'),('LIFE','SINGLE PREMIUM LIFE','*','Risk Management','Life Insurance','Protection Life','Whole Life'),('LIFE','SURVIVORSHIP WHOLE LIFE','*','Risk Management','Life Insurance','Protection Life','Whole Life'),('LIFE','SINGLE PREMIUM WHOLE LIFE','*','Risk Management','Life Insurance','Protection Life','Whole Life'),('LIFE','UNIVERSAL LIFE','*','Risk Management','Life Insurance','Protection Life','Universal Life'),('LIFE','EMPLOYEE ADJUSTABLE LIFE','*','Risk Management','Life Insurance','Protection Life','Universal Life'),('LIFE','CUSTOM UNIVERSAL LIFE','*','Risk Management','Life Insurance','Protection Life','Universal Life'),('LIFE','SURVIVORSHIP UNIVERSAL LIFE','*','Risk Management','Life Insurance','Protection Life','Universal Life'),('LIFE','CUSTOM SURVIVORSHIP UNIVERSAL LIFE','*','Risk Management','Life Insurance','Protection Life','Universal Life'),('LIFE','SINGLE PREMIUM UNIVERSAL LIFE','*','Risk Management','Life Insurance','Protection Life','Asset Flex_Preserver'),('LIFE','FLEX PREMIUM UNIVERSAL LIFE','*','Risk Management','Life Insurance','Protection Life','Asset Flex_Preserver'),('ANNUITY','VARIABLE DEFERRED','*','Risk Management','Non-GIA Annuities','Accumulation Annuities','Variable Deferred Annuities'),('ANNUITY','VARIABLE DEFERRED','NEW YORK LIFE INDEXFLEX VARIABLE ANNUITY','Risk Management','Non-GIA Annuities','Accumulation Annuities','Index Flex Annuities'),('ANNUITY','VARIABLE DEFERRED','NEW YORK LIFE PREMIER ADVISORY VARIABLE ANNUITY','Wealth Management','Non-GIA Annuities','Accumulation Annuities','Premier Advisory Variable Annuities'),('ANNUITY','FIXED DEFERRED','*','Risk Management','Non-GIA Annuities','Accumulation Annuities','Fixed Deferred Annuities'),('ANNUITY','GUARANTEED INCOME ANNUITY','*','Risk Management','GIA Annuities','Protection Annuities','Guaranteed Income Annuities'),('ANNUITY','CLEAR INCOME','*','Risk Management','GIA Annuities','Protection Annuities','Guaranteed Income Annuities'),('LTC','LTC 5.5 AND OLDER','*','Risk Management','Long Term Care','Long Term Care','Long Term Care'),('LTC','LTC 6.0','*','Risk Management','Long Term Care','Long Term Care','Long Term Care'),('LTC','NYL MY CARE','*','Risk Management','Long Term Care','Long Term Care','Long Term Care'),('IDI','MY INCOME PROTECTOR','*','Risk Management','Individual Disability Insurance','Individual Disability Insurance','Individual Disability Insurance'),('INVESTMENT','EAGLE','*','Wealth Management','Investment','Investment','Eagle'),('INVESTMENT','SECURITIES','*','Wealth Management','Investment','Investment','Brokerage Account_NYLSEC'),('INVESTMENT','MUTUAL FUNDS','*','Wealth Management','Investment','Investment','Direct Mutual Funds_Mainstay_NPMF_NP529');
-- created_at: 2026-08-06T15:25:51.722823+00:00
-- finished_at: 2026-08-06T15:25:52.998691+00:00
-- elapsed: 1.3s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_product_category_map_product_ln_cd.b776cfaa95
-- query_id: 01f191ab-1bda-1c32-92da-4e3b39da833e
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_product_category_map_product_ln_cd.b776cfaa95", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_ln_cd
from `dbt_dev`.`dbt_osalami_seeds`.`product_category_map`
where product_ln_cd is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:51.722624+00:00
-- finished_at: 2026-08-06T15:25:53.121969+00:00
-- elapsed: 1.4s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_product_category_map_product_type.78278e6976
-- query_id: 01f191ab-1bda-147e-8506-f1b83d88dffb
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_product_category_map_product_type.78278e6976", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_type
from `dbt_dev`.`dbt_osalami_seeds`.`product_category_map`
where product_type is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:51.722860+00:00
-- finished_at: 2026-08-06T15:25:53.255697+00:00
-- elapsed: 1.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_product_category_map_product_grp_nm.28487958f0
-- query_id: 01f191ab-1bda-1cc0-a39c-4b1d180d966d
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_product_category_map_product_grp_nm.28487958f0", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_grp_nm
from `dbt_dev`.`dbt_osalami_seeds`.`product_category_map`
where product_grp_nm is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:51.723016+00:00
-- finished_at: 2026-08-06T15:25:53.493513+00:00
-- elapsed: 1.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_product_category_map_product_ln_cd__product_grp_nm__product_nm.2306d69278
-- query_id: 01f191ab-1bda-1715-a0e4-0789eb9aaf34
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_product_category_map_product_ln_cd__product_grp_nm__product_nm.2306d69278", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        product_ln_cd, product_grp_nm, product_nm
    from `dbt_dev`.`dbt_osalami_seeds`.`product_category_map`
    group by product_ln_cd, product_grp_nm, product_nm
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:51.723003+00:00
-- finished_at: 2026-08-06T15:25:54.419870+00:00
-- elapsed: 2.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.assert_depth_collapse_types_exist
-- query_id: 01f191ab-1bdb-1468-b0e0-36d27866889f
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.assert_depth_collapse_types_exist", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- int_summ__client_breadth_depth collapses a hard-coded set of product_type
-- values into a single 'TERM' unit when computing depth. Those strings are
-- produced by seeds/product_category_map.csv. If somebody renames a product
-- type in the seed, the depth rule silently stops collapsing and every client
-- with term policies gets a higher depth, with no error anywhere.
--
-- This test fails if any configured value no longer exists in the seed.


with expected as (
    
    select 'Level Term and Level Convertible_Renewable Term' as product_type
    union all
    
    select 'Yearly Convertible_Renewable Term' as product_type
    
    
)

select e.product_type
from expected e
left join `dbt_dev`.`dbt_osalami_seeds`.`product_category_map` m
    on m.product_type = e.product_type
where m.product_type is null
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:25:54.438063+00:00
-- finished_at: 2026-08-06T15:26:02.516998+00:00
-- elapsed: 8.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_products__categorized_product_type.11079a5848
-- query_id: 01f191ab-1d78-1e63-b478-1785afd31cd4
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_products__categorized_product_type.11079a5848", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_contracts__scoped as (
-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'CONTRACT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_contracts__with_producer as (
-- Original CTE: core
--
-- The original wrote this as three near-identical UNION ALL branches that
-- differed only by (a) which LOBs they let through and (b) which producer-role
-- filter was commented out. The LOB split is handled upstream in
-- int_contracts__scoped, so one branch covers all three.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Every `and cp.producer_cnt_role_nm = '...'` line below is commented out,
-- verbatim from the notebook. With them off, a contract carrying three
-- producers in three roles produces THREE ROWS, and `select distinct` does not
-- collapse them because the producer columns differ. That fan-out reaches
-- ppg_metrics_dtl and ppg_metrics_monthly, so contract counts there are
-- inflated wherever a contract has more than one producer.
--
-- It does NOT reach ppg_metrics_summ_monthly -- every figure there is a
-- count(distinct client) or count(distinct contract), so duplicate producer
-- rows collapse. The summary is safe; the two detail tables are the ones to
-- check.
--
-- Uncomment the line for a LOB to restore that filter. Note they are per-LOB
-- because the original applied a different role to each branch, so switching
-- one on does not imply the others.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contract_producer`
),

joined as (
    select
        cn.lob_nm,
        cn.plan_cd,
        cn.cnt_id_nk,
        cn.cnt_iss_cd_nk,
        cn.cnt_eff_dt,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
        -- LIFE INSURANCE  branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- ANNUITIES       branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- LONG TERM CARE  branch:
        -- and cp.producer_cnt_role_nm = 'PERMANENT SERVICING PRODUCER'
        -- IDI             branch:
        -- and cp.producer_cnt_role_nm = 'UNKNOWN'
)

select distinct
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_wm_accounts as (
-- Original CTE: wm_accounts

with wm_accounts as (
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
)
select * from wm_accounts
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_wm_accounts__with_producer as (
-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. The product_nm split is handled upstream in
-- stg_pdm__invest_sub_account, so one branch covers both.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Same fan-out caveat as int_contracts__with_producer -- see the header there.
-- The two branches used DIFFERENT roles, so uncommenting is per product family,
-- not all-or-nothing.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer`
),

joined as (
    select
        cn.product_nm                       as lob_nm,
        cn.plan_cd,
        cn.invest_acct_id                   as cnt_id_nk,
        cn.invest_acct_cd                   as cnt_iss_cd_nk,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
        -- EAGLE / NYLIFE SEC / MAINSTAY branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- NP MUTFNDS / NP529           branch:
        -- and cp.producer_cnt_role_nm = 'PRODUCER OF RECORD'
    -- Was `group by 1..8`; column 8 was the seed's preferred_producer_role_nm.
    -- Dropping it does not change the grouping -- it was functionally dependent
    -- on lob_nm, which is still column 1.
    group by 1, 2, 3, 4, 5, 6, 7
)

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_products__unified as (
-- Original CTE: core_wm
--
-- This is the contract between the insurance side and the wealth side. Any
-- column added to one branch must be added to the other. Grain and tests are
-- declared in _intermediate.yml -- test here, not only at the mart.
with unified_products as (
select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'CONTRACT' as source_domain
from __dbt__cte__int_contracts__with_producer

union all

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'INVEST_ACCT' as source_domain
from __dbt__cte__int_wm_accounts__with_producer
)
select * from unified_products
), __dbt__cte__int_products__categorized as (
-- Original CTE: core_wm_client_product
--
-- The four CASE expressions are now a seed lookup. Match on the specific
-- product_nm first; fall back to the '*' wildcard row for that
-- product_ln_cd + product_grp_nm.
with base as (
    select * from __dbt__cte__int_products__unified
),

products as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__products`
),

map as (
    select * from `dbt_dev`.`dbt_osalami_seeds`.`product_category_map`
),

with_product as (
    select
        base.*,
        prd.product_ln_cd,
        prd.product_grp_nm,
        prd.product_nm
    from base
    left join products prd
        on prd.plan_cd_nk = base.plan_cd
),

categorized as (
    select
        wp.lob_nm,
        wp.cnt_id_nk,
        wp.cnt_iss_cd_nk,
        wp.cnt_eff_dt,
        wp.plan_cd,
        wp.primry_ownr_cl_id,
        wp.producer_id_nk,
        wp.producer_cnt_role_nm,
        wp.source_domain,

        coalesce(exact.product_category_risk_wm,
                 wild.product_category_risk_wm)
            as product_category_risk_wm,

        coalesce(exact.product_category_protection_accumulation_alternate,
                 wild.product_category_protection_accumulation_alternate)
            as product_category_protection_accumulation_alternate,

        coalesce(exact.product_category_need_based_by_product,
                 wild.product_category_need_based_by_product)
            as product_category_need_based_by_product,

        coalesce(exact.product_type, wild.product_type)
            as product_type

    from with_product wp
    left join map exact
        on  exact.product_ln_cd  = wp.product_ln_cd
        and exact.product_grp_nm = wp.product_grp_nm
        and exact.product_nm     = wp.product_nm
    left join map wild
        on  wild.product_ln_cd  = wp.product_ln_cd
        and wild.product_grp_nm = wp.product_grp_nm
        and wild.product_nm     = '*'
)

select * from categorized
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select product_type
from __dbt__cte__int_products__categorized
where product_type is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:02.518970+00:00
-- finished_at: 2026-08-06T15:26:03.265265+00:00
-- elapsed: 746ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-224a-1184-9ddf-19efba3b325e
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
    AND table_schema = 'dbt_osalami_marts';
-- created_at: 2026-08-06T15:26:03.266150+00:00
-- finished_at: 2026-08-06T15:26:04.284353+00:00
-- elapsed: 1.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-22bb-1d43-8eab-066ce631bc14
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping` AS JSON;
-- created_at: 2026-08-06T15:26:04.290566+00:00
-- finished_at: 2026-08-06T15:26:05.014290+00:00
-- elapsed: 723ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-2359-1027-8367-b1fe4d734a70
-- desc: Fetch tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
SELECT tag_name, tag_value
            FROM `system`.`information_schema`.`table_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_stg_cnt_prd_mapping';
-- created_at: 2026-08-06T15:26:05.015039+00:00
-- finished_at: 2026-08-06T15:26:05.724031+00:00
-- elapsed: 708ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-23c7-11b4-ae96-9154a52615c9
-- desc: Fetch column tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name, tag_name, tag_value
            FROM `system`.`information_schema`.`column_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_stg_cnt_prd_mapping';
-- created_at: 2026-08-06T15:26:05.725883+00:00
-- finished_at: 2026-08-06T15:26:06.508129+00:00
-- elapsed: 782ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-2433-1563-9d11-02dc0ee68b1a
-- desc: Fetch non null constraint columns
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name
            FROM `dbt_dev`.`information_schema`.`columns`
            WHERE table_catalog = 'dbt_dev' 
              AND table_schema = 'dbt_osalami_marts'
              AND table_name = 'ppg_stg_cnt_prd_mapping'
              AND is_nullable = 'NO';
-- created_at: 2026-08-06T15:26:06.511959+00:00
-- finished_at: 2026-08-06T15:26:07.723573+00:00
-- elapsed: 1.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-24ab-1e64-b294-a8505c896a32
-- desc: Fetch PK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
SELECT kcu.constraint_name, kcu.column_name
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            WHERE kcu.table_catalog = 'dbt_dev' 
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_stg_cnt_prd_mapping' 
                AND kcu.constraint_name = (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_stg_cnt_prd_mapping' 
                    AND constraint_type = 'PRIMARY KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:26:07.724606+00:00
-- finished_at: 2026-08-06T15:26:09.331172+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-2563-1f34-a89b-b382b3a945c5
-- desc: Fetch FK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
SELECT
                kcu.constraint_name,
                kcu.column_name AS from_column,
                ukcu.table_catalog AS to_catalog,
                ukcu.table_schema AS to_schema,
                ukcu.table_name AS to_table,
                ukcu.column_name AS to_column
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            JOIN `dbt_dev`.information_schema.referential_constraints rc
                ON kcu.constraint_name = rc.constraint_name
            JOIN `dbt_dev`.information_schema.key_column_usage ukcu
                ON rc.unique_constraint_name = ukcu.constraint_name
                AND kcu.ordinal_position = ukcu.ordinal_position
            WHERE kcu.table_catalog = 'dbt_dev'
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_stg_cnt_prd_mapping'
                AND kcu.constraint_name IN (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_stg_cnt_prd_mapping'
                    AND constraint_type = 'FOREIGN KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:26:09.332267+00:00
-- finished_at: 2026-08-06T15:26:09.801167+00:00
-- elapsed: 468ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-2659-1b38-86fc-46e4856ca121
-- desc: Fetch column masks
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
SELECT 
                column_name,
                mask_name,
                using_columns
            FROM `system`.`information_schema`.`column_masks`
            WHERE table_catalog = 'dbt_dev'
                AND table_schema = 'dbt_osalami_marts'
                AND table_name = 'ppg_stg_cnt_prd_mapping';
-- created_at: 2026-08-06T15:26:09.803548+00:00
-- finished_at: 2026-08-06T15:26:10.241610+00:00
-- elapsed: 438ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-26a2-130d-976d-ccf00be68cee
-- desc: Show table properties
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
SHOW TBLPROPERTIES `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`;
-- created_at: 2026-08-06T15:26:10.242725+00:00
-- finished_at: 2026-08-06T15:26:10.752772+00:00
-- elapsed: 510ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-26e6-1808-ad72-661e11e532ad
-- desc: Describe table extended
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
describe extended `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`;
-- created_at: 2026-08-06T15:26:10.758070+00:00
-- finished_at: 2026-08-06T15:26:13.667239+00:00
-- elapsed: 2.9s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-2732-1ccf-adb7-9f6491857aca
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
create or replace temporary view `ppg_stg_cnt_prd_mapping__dbt_tmp` as
      with __dbt__cte__int_contracts__scoped as (
-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'CONTRACT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_contracts__with_producer as (
-- Original CTE: core
--
-- The original wrote this as three near-identical UNION ALL branches that
-- differed only by (a) which LOBs they let through and (b) which producer-role
-- filter was commented out. The LOB split is handled upstream in
-- int_contracts__scoped, so one branch covers all three.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Every `and cp.producer_cnt_role_nm = '...'` line below is commented out,
-- verbatim from the notebook. With them off, a contract carrying three
-- producers in three roles produces THREE ROWS, and `select distinct` does not
-- collapse them because the producer columns differ. That fan-out reaches
-- ppg_metrics_dtl and ppg_metrics_monthly, so contract counts there are
-- inflated wherever a contract has more than one producer.
--
-- It does NOT reach ppg_metrics_summ_monthly -- every figure there is a
-- count(distinct client) or count(distinct contract), so duplicate producer
-- rows collapse. The summary is safe; the two detail tables are the ones to
-- check.
--
-- Uncomment the line for a LOB to restore that filter. Note they are per-LOB
-- because the original applied a different role to each branch, so switching
-- one on does not imply the others.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__contract_producer`
),

joined as (
    select
        cn.lob_nm,
        cn.plan_cd,
        cn.cnt_id_nk,
        cn.cnt_iss_cd_nk,
        cn.cnt_eff_dt,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
        -- LIFE INSURANCE  branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- ANNUITIES       branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- LONG TERM CARE  branch:
        -- and cp.producer_cnt_role_nm = 'PERMANENT SERVICING PRODUCER'
        -- IDI             branch:
        -- and cp.producer_cnt_role_nm = 'UNKNOWN'
)

select distinct
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_wm_accounts as (
-- Original CTE: wm_accounts

with wm_accounts as (
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
)
select * from wm_accounts
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


), __dbt__cte__int_wm_accounts__with_producer as (
-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. The product_nm split is handled upstream in
-- stg_pdm__invest_sub_account, so one branch covers both.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Same fan-out caveat as int_contracts__with_producer -- see the header there.
-- The two branches used DIFFERENT roles, so uncommenting is per product family,
-- not all-or-nothing.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer`
),

joined as (
    select
        cn.product_nm                       as lob_nm,
        cn.plan_cd,
        cn.invest_acct_id                   as cnt_id_nk,
        cn.invest_acct_cd                   as cnt_iss_cd_nk,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
        -- EAGLE / NYLIFE SEC / MAINSTAY branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- NP MUTFNDS / NP529           branch:
        -- and cp.producer_cnt_role_nm = 'PRODUCER OF RECORD'
    -- Was `group by 1..8`; column 8 was the seed's preferred_producer_role_nm.
    -- Dropping it does not change the grouping -- it was functionally dependent
    -- on lob_nm, which is still column 1.
    group by 1, 2, 3, 4, 5, 6, 7
)

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
), __dbt__cte__int_products__unified as (
-- Original CTE: core_wm
--
-- This is the contract between the insurance side and the wealth side. Any
-- column added to one branch must be added to the other. Grain and tests are
-- declared in _intermediate.yml -- test here, not only at the mart.
with unified_products as (
select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'CONTRACT' as source_domain
from __dbt__cte__int_contracts__with_producer

union all

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'INVEST_ACCT' as source_domain
from __dbt__cte__int_wm_accounts__with_producer
)
select * from unified_products
), __dbt__cte__int_products__categorized as (
-- Original CTE: core_wm_client_product
--
-- The four CASE expressions are now a seed lookup. Match on the specific
-- product_nm first; fall back to the '*' wildcard row for that
-- product_ln_cd + product_grp_nm.
with base as (
    select * from __dbt__cte__int_products__unified
),

products as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__products`
),

map as (
    select * from `dbt_dev`.`dbt_osalami_seeds`.`product_category_map`
),

with_product as (
    select
        base.*,
        prd.product_ln_cd,
        prd.product_grp_nm,
        prd.product_nm
    from base
    left join products prd
        on prd.plan_cd_nk = base.plan_cd
),

categorized as (
    select
        wp.lob_nm,
        wp.cnt_id_nk,
        wp.cnt_iss_cd_nk,
        wp.cnt_eff_dt,
        wp.plan_cd,
        wp.primry_ownr_cl_id,
        wp.producer_id_nk,
        wp.producer_cnt_role_nm,
        wp.source_domain,

        coalesce(exact.product_category_risk_wm,
                 wild.product_category_risk_wm)
            as product_category_risk_wm,

        coalesce(exact.product_category_protection_accumulation_alternate,
                 wild.product_category_protection_accumulation_alternate)
            as product_category_protection_accumulation_alternate,

        coalesce(exact.product_category_need_based_by_product,
                 wild.product_category_need_based_by_product)
            as product_category_need_based_by_product,

        coalesce(exact.product_type, wild.product_type)
            as product_type

    from with_product wp
    left join map exact
        on  exact.product_ln_cd  = wp.product_ln_cd
        and exact.product_grp_nm = wp.product_grp_nm
        and exact.product_nm     = wp.product_nm
    left join map wild
        on  wild.product_ln_cd  = wp.product_ln_cd
        and wild.product_grp_nm = wp.product_grp_nm
        and wild.product_nm     = '*'
)

select * from categorized
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (


-- Original: create or replace table
--   prod_builder_fieldexperience.fx_test.ppg_stg_cnt_prd_mapping
--
-- WHAT CHANGED
-- Was a full rebuild pinned to CURRENT_DATE. It then became incremental
-- partitioned by a DAILY snapshot_date, which did not match the report: every
-- table downstream of this one is keyed by month_end_date, so a daily grain
-- here meant ~30 partitions per reporting month that all described the same
-- month, and a rerun on a different day quietly changed a published month.
--
-- The partition and the key are now month_end_date, matching ppg_metrics_dtl,
-- ppg_metrics_monthly and ppg_metrics_summ_monthly. snapshot_date is retained
-- as an audit column -- when PDM was read -- and nothing keys or joins on it.
--
-- Backfill a month with:
--   dbt run -s ppg_stg_cnt_prd_mapping --vars '{report_month: "2026-07-31"}'
--
-- That is REFUSED while pdm_history_mode is 'current', because the PDM staging
-- models would return today's contracts to be stamped with July's month end.
-- See tests/assert_backfill_is_honest.sql.

with categorized as (
    select * from __dbt__cte__int_products__categorized
),

dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
)

select distinct
    dt.month_end_date,
    dt.snapshot_date,
    prd.lob_nm,
    prd.cnt_id_nk,
    prd.cnt_iss_cd_nk,
    prd.cnt_eff_dt,
    prd.primry_ownr_cl_id,
    prd.producer_id_nk,
    prd.producer_cnt_role_nm,
    prd.product_category_need_based_by_product,
    prd.product_type,
    prd.product_category_risk_wm,
    prd.product_category_protection_accumulation_alternate
from categorized prd
cross join dates dt
where prd.product_type is not null
--EPHEMERAL-SELECT-WRAPPER-END
);
-- created_at: 2026-08-06T15:26:13.672903+00:00
-- finished_at: 2026-08-06T15:26:13.955294+00:00
-- elapsed: 282ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-28f0-1b3b-a02c-b0ad4c986004
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `ppg_stg_cnt_prd_mapping__dbt_tmp` AS JSON;
-- created_at: 2026-08-06T15:26:13.956818+00:00
-- finished_at: 2026-08-06T15:26:14.386832+00:00
-- elapsed: 430ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-291b-103a-8f5a-af4cdae79f8b
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping` AS JSON;
-- created_at: 2026-08-06T15:26:14.391046+00:00
-- finished_at: 2026-08-06T15:26:27.125616+00:00
-- elapsed: 12.7s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_stg_cnt_prd_mapping
-- query_id: 01f191ab-2961-113e-be28-9d5feb579c44
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_stg_cnt_prd_mapping", "profile_name": "ppg", "target_name": "dev"} */
insert into table `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping` AS t
        replace on (t.month_end_date <=> s.month_end_date)
        (select snapshot_date, month_end_date, lob_nm, cnt_id_nk, cnt_iss_cd_nk, cnt_eff_dt, primry_ownr_cl_id, producer_id_nk, producer_cnt_role_nm, product_category_need_based_by_product, product_type, product_category_risk_wm, product_category_protection_accumulation_alternate from `ppg_stg_cnt_prd_mapping__dbt_tmp`) AS s;
-- created_at: 2026-08-06T15:26:27.135053+00:00
-- finished_at: 2026-08-06T15:26:28.503657+00:00
-- elapsed: 1.4s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_stg_cnt_prd_mapping_cnt_id_nk.e69ce8916d
-- query_id: 01f191ab-30f6-19e2-9f6e-f524ba65fa07
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_stg_cnt_prd_mapping_cnt_id_nk.e69ce8916d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cnt_id_nk
from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
where cnt_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:27.134677+00:00
-- finished_at: 2026-08-06T15:26:29.885317+00:00
-- elapsed: 2.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_stg_cnt_prd_mapping_month_end_date.4f9d7b7938
-- query_id: 01f191ab-30f6-1910-be16-f2bb1b1a3d65
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_stg_cnt_prd_mapping_month_end_date.4f9d7b7938", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:27.135395+00:00
-- finished_at: 2026-08-06T15:26:29.903186+00:00
-- elapsed: 2.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_stg_cnt_prd_mapping_snapshot_date.36b7ea03db
-- query_id: 01f191ab-30f6-1974-bf8d-47d63bb15bbd
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_stg_cnt_prd_mapping_snapshot_date.36b7ea03db", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select snapshot_date
from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
where snapshot_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:27.135071+00:00
-- finished_at: 2026-08-06T15:26:30.148792+00:00
-- elapsed: 3.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_stg_cnt_prd_mapping_product_type.737d47a660
-- query_id: 01f191ab-30f6-1783-9495-388e1f3965b6
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_stg_cnt_prd_mapping_product_type.737d47a660", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_type
from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
where product_type is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:27.135428+00:00
-- finished_at: 2026-08-06T15:26:30.217837+00:00
-- elapsed: 3.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_ppg_stg_cnt_prd_mapping_month_end_date__cnt_id_nk__cnt_iss_cd_nk__producer_id_nk.b219b729da
-- query_id: 01f191ab-30f6-16d5-8cc5-1e5ede1398e1
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_ppg_stg_cnt_prd_mapping_month_end_date__cnt_id_nk__cnt_iss_cd_nk__producer_id_nk.b219b729da", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        month_end_date, cnt_id_nk, cnt_iss_cd_nk, producer_id_nk
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
    group by month_end_date, cnt_id_nk, cnt_iss_cd_nk, producer_id_nk
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:27.136139+00:00
-- finished_at: 2026-08-06T15:26:30.218729+00:00
-- elapsed: 3.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_stg_cnt_prd_mapping_lob_nm__LIFE_INSURANCE__ANNUITIES__LONG_TERM_CARE__IDI__EAGLE__NYLIFE_SEC__MAINSTAY__NP_MUTFNDS__NP529.70084f5ef8
-- query_id: 01f191ab-30f6-152c-9d0b-def213ba04ed
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.accepted_values_ppg_stg_cnt_prd_mapping_lob_nm__LIFE_INSURANCE__ANNUITIES__LONG_TERM_CARE__IDI__EAGLE__NYLIFE_SEC__MAINSTAY__NP_MUTFNDS__NP529.70084f5ef8", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        lob_nm as value_field,
        count(*) as n_records

    from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
    group by lob_nm

)

select *
from all_values
where value_field not in (
    'LIFE INSURANCE','ANNUITIES','LONG TERM CARE','IDI','EAGLE','NYLIFE SEC','MAINSTAY','NP MUTFNDS','NP529'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:27.136754+00:00
-- finished_at: 2026-08-06T15:26:30.394552+00:00
-- elapsed: 3.3s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.assert_snapshot_is_month_end
-- query_id: 01f191ab-30f6-199f-983b-d1a418617f61
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.assert_snapshot_is_month_end", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    month_end_date,
    max(snapshot_date)                              as observed_at,
    datediff(max(snapshot_date), month_end_date)    as days_of_drift
from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
group by month_end_date
having max(snapshot_date) > month_end_date
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:27.136138+00:00
-- finished_at: 2026-08-06T15:26:30.499889+00:00
-- elapsed: 3.4s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_stg_cnt_prd_mapping_product_category_risk_wm__Risk_Management__Wealth_Management.c79001efa7
-- query_id: 01f191ab-30f6-19bc-a794-391ce75cf739
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.accepted_values_ppg_stg_cnt_prd_mapping_product_category_risk_wm__Risk_Management__Wealth_Management.c79001efa7", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        product_category_risk_wm as value_field,
        count(*) as n_records

    from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
    group by product_category_risk_wm

)

select *
from all_values
where value_field not in (
    'Risk Management','Wealth Management'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:30.519936+00:00
-- finished_at: 2026-08-06T15:26:31.970625+00:00
-- elapsed: 1.5s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-32fa-16c5-9f20-ec40f5c053fd
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` AS JSON;
-- created_at: 2026-08-06T15:26:31.976111+00:00
-- finished_at: 2026-08-06T15:26:32.345787+00:00
-- elapsed: 369ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-33d8-1dd1-9951-9d5e07e0f5ee
-- desc: Fetch tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
SELECT tag_name, tag_value
            FROM `system`.`information_schema`.`table_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_dtl';
-- created_at: 2026-08-06T15:26:32.346750+00:00
-- finished_at: 2026-08-06T15:26:32.903363+00:00
-- elapsed: 556ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-3411-19ca-a215-d76198642310
-- desc: Fetch column tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name, tag_name, tag_value
            FROM `system`.`information_schema`.`column_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_dtl';
-- created_at: 2026-08-06T15:26:32.904628+00:00
-- finished_at: 2026-08-06T15:26:33.542338+00:00
-- elapsed: 637ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-3466-16d6-99f9-2eab4340a426
-- desc: Fetch non null constraint columns
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name
            FROM `dbt_dev`.`information_schema`.`columns`
            WHERE table_catalog = 'dbt_dev' 
              AND table_schema = 'dbt_osalami_marts'
              AND table_name = 'ppg_metrics_dtl'
              AND is_nullable = 'NO';
-- created_at: 2026-08-06T15:26:33.544723+00:00
-- finished_at: 2026-08-06T15:26:34.635384+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-34c7-1eda-ac93-874b8b1fd1a3
-- desc: Fetch PK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
SELECT kcu.constraint_name, kcu.column_name
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            WHERE kcu.table_catalog = 'dbt_dev' 
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_metrics_dtl' 
                AND kcu.constraint_name = (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_metrics_dtl' 
                    AND constraint_type = 'PRIMARY KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:26:34.636851+00:00
-- finished_at: 2026-08-06T15:26:36.171429+00:00
-- elapsed: 1.5s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-356e-1766-9702-2deb325add63
-- desc: Fetch FK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
SELECT
                kcu.constraint_name,
                kcu.column_name AS from_column,
                ukcu.table_catalog AS to_catalog,
                ukcu.table_schema AS to_schema,
                ukcu.table_name AS to_table,
                ukcu.column_name AS to_column
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            JOIN `dbt_dev`.information_schema.referential_constraints rc
                ON kcu.constraint_name = rc.constraint_name
            JOIN `dbt_dev`.information_schema.key_column_usage ukcu
                ON rc.unique_constraint_name = ukcu.constraint_name
                AND kcu.ordinal_position = ukcu.ordinal_position
            WHERE kcu.table_catalog = 'dbt_dev'
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_metrics_dtl'
                AND kcu.constraint_name IN (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_metrics_dtl'
                    AND constraint_type = 'FOREIGN KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:26:36.172338+00:00
-- finished_at: 2026-08-06T15:26:36.725134+00:00
-- elapsed: 552ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-3659-11b8-8cda-8bff8635d817
-- desc: Fetch column masks
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
SELECT 
                column_name,
                mask_name,
                using_columns
            FROM `system`.`information_schema`.`column_masks`
            WHERE table_catalog = 'dbt_dev'
                AND table_schema = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_dtl';
-- created_at: 2026-08-06T15:26:36.726585+00:00
-- finished_at: 2026-08-06T15:26:37.178612+00:00
-- elapsed: 452ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-36ae-1de8-a46a-b369de8c1113
-- desc: Show table properties
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
SHOW TBLPROPERTIES `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`;
-- created_at: 2026-08-06T15:26:37.179881+00:00
-- finished_at: 2026-08-06T15:26:37.838063+00:00
-- elapsed: 658ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-36f2-166b-a775-de931e65cfc4
-- desc: Describe table extended
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
describe extended `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`;
-- created_at: 2026-08-06T15:26:37.842606+00:00
-- finished_at: 2026-08-06T15:26:39.210251+00:00
-- elapsed: 1.4s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-3757-1cb8-a18c-1ba28f049bb2
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
create or replace temporary view `ppg_metrics_dtl__dbt_tmp` as
      with __dbt__cte__int_metrics__base_all as (
-- Original CTE: base_all
--
-- ⚠ BEHAVIOUR CHANGE FORCED BY THE CELL 1 REFACTOR ⚠
-- The original read ppg_stg_cnt_prd_mapping unfiltered, which was safe only
-- because cell 1 did `create or replace` and the table held exactly one
-- snapshot. ppg_stg_cnt_prd_mapping is now incremental and retains history, so
-- reading it unfiltered would multiply every metric by the number of months
-- retained. The month filter below is mandatory, not optional.
--
-- It used to filter on `snapshot_date = current_date`, which coupled this
-- model to the mapping model having run TODAY: if mapping ran at 23:55 and
-- this ran at 00:05, the filter matched nothing and the month came out empty
-- with no error. Filtering on the reporting month removes that coupling and
-- prunes the same partition.
with mapping as (
    select *
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_stg_cnt_prd_mapping`
    where month_end_date = (select month_end_date from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`)
),

dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
)

select distinct
    mapp.snapshot_date,
    dt.month_end_date,
    mapp.lob_nm,
    mapp.cnt_id_nk,
    mapp.cnt_iss_cd_nk,
    mapp.cnt_eff_dt,
    mapp.primry_ownr_cl_id,
    mapp.producer_id_nk,
    mapp.producer_cnt_role_nm,
    mapp.product_category_protection_accumulation_alternate,
    mapp.product_category_need_based_by_product,
    mapp.product_category_risk_wm,
    mapp.product_type
from mapping mapp
inner join dates dt
    on mapp.cnt_eff_dt <= dt.month_end_date
), __dbt__cte__int_clients__active_eop as (
-- Original CTE: get_active_cl_eop
-- Clients with an active policy-owner record as of the reporting month end.

with active_cl_eop as (
select distinct
    po.po_client_id_nk,
    dt.month_end_date
from `dbt_dev`.`dbt_osalami_staging`.`stg_metrics__policy_owner` po
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates` dt
    on po.dt_key = dt.month_end_dim_sqn
)
select * from active_cl_eop
), __dbt__cte__int_planning__gm_clients as (
-- The sf_account -> gm plan dates join that the original pasted THREE times:
-- once inside clients_with_planning, and twice more inside
-- clients_with_planning_v2. Defined once here.
with gm_clients as (
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt_dev`.`dbt_osalami_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
select * from gm_clients
), __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
), __dbt__cte__int_clients__planning_flags as (
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
    from __dbt__cte__int_planning__gm_clients
),

fp as (
    select
        client_id,
        completed_plan_dt,
        'FP' as plan_source
    from __dbt__cte__int_planning__fp_clients
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
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (


-- Original: cell 2, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_dtl
--
-- Contract-level detail for the reporting month, restricted to contracts whose
-- primary owner was an active policy owner at month end, with planning flags
-- attached.

with base as (
    select * from __dbt__cte__int_metrics__base_all
),

active_clients as (
    select * from __dbt__cte__int_clients__active_eop
),

planning as (
    select * from __dbt__cte__int_clients__planning_flags
)

select distinct
    base.snapshot_date,
    base.month_end_date,
    base.lob_nm,
    base.primry_ownr_cl_id,
    base.cnt_id_nk,
    base.cnt_iss_cd_nk,
    base.cnt_eff_dt,
    base.producer_id_nk,
    base.producer_cnt_role_nm,
    base.product_category_protection_accumulation_alternate,
    base.product_category_need_based_by_product,
    base.product_category_risk_wm,
    base.product_type,

    case when base.product_category_risk_wm = 'Risk Management'
         then 'Y' else 'N' end                          as risk_management_ind,
    case when base.product_category_risk_wm = 'Wealth Management'
         then 'Y' else 'N' end                          as wealth_management_ind,

    -- The original left these NULL for a client whose plan completed AFTER the
    -- reporting month, because the date predicate sits in the LEFT JOIN's ON
    -- clause. That reads as "unknown" when the business meaning is "had not
    -- planned yet as of month end" -- i.e. 'N'. Set coalesce_planning_flags to
    -- false to reproduce the original NULLs exactly.
    
    coalesce(pln.gm_flag, 'N')                          as gm_flag,
    coalesce(pln.fp_flag, 'N')                          as fp_flag,
    coalesce(pln.gm_or_fp_flag, 'N')                    as gm_or_fp_flag
    

from base
inner join active_clients actcl
    on  actcl.po_client_id_nk = base.primry_ownr_cl_id
    -- Redundant while dates yields one row, but it is the predicate that keeps
    -- this correct if the window is ever widened to several months.
    and actcl.month_end_date  = base.month_end_date
left join planning pln
    on  pln.client_id         = base.primry_ownr_cl_id
    and pln.completed_plan_dt <= base.month_end_date
--EPHEMERAL-SELECT-WRAPPER-END
);
-- created_at: 2026-08-06T15:26:39.214697+00:00
-- finished_at: 2026-08-06T15:26:39.498959+00:00
-- elapsed: 284ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-3829-1a44-b7d1-b88770c5d243
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `ppg_metrics_dtl__dbt_tmp` AS JSON;
-- created_at: 2026-08-06T15:26:39.501782+00:00
-- finished_at: 2026-08-06T15:26:40.063415+00:00
-- elapsed: 561ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-3855-1867-95c5-00de202a3145
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` AS JSON;
-- created_at: 2026-08-06T15:26:40.068122+00:00
-- finished_at: 2026-08-06T15:26:47.329030+00:00
-- elapsed: 7.3s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_dtl
-- query_id: 01f191ab-38ab-1280-bac8-43802804946a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_dtl", "profile_name": "ppg", "target_name": "dev"} */
insert into table `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` AS t
        replace on (t.month_end_date <=> s.month_end_date)
        (select snapshot_date, month_end_date, lob_nm, primry_ownr_cl_id, cnt_id_nk, cnt_iss_cd_nk, cnt_eff_dt, producer_id_nk, producer_cnt_role_nm, product_category_protection_accumulation_alternate, product_category_need_based_by_product, product_category_risk_wm, product_type, risk_management_ind, wealth_management_ind, gm_flag, fp_flag, gm_or_fp_flag from `ppg_metrics_dtl__dbt_tmp`) AS s;
-- created_at: 2026-08-06T15:26:47.349645+00:00
-- finished_at: 2026-08-06T15:26:49.295275+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_dtl_cnt_id_nk.105b43126c
-- query_id: 01f191ab-3d02-16e9-938e-dc3b4e0fb259
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_dtl_cnt_id_nk.105b43126c", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cnt_id_nk
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
where cnt_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:47.349594+00:00
-- finished_at: 2026-08-06T15:26:49.814568+00:00
-- elapsed: 2.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_dtl_primry_ownr_cl_id.fcffb2d777
-- query_id: 01f191ab-3d02-1d5c-8200-699593bff793
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_dtl_primry_ownr_cl_id.fcffb2d777", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
where primry_ownr_cl_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:47.349451+00:00
-- finished_at: 2026-08-06T15:26:50.053962+00:00
-- elapsed: 2.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_dtl_gm_or_fp_flag__Y__N.1a6d203954
-- query_id: 01f191ab-3d03-116b-acbe-83f584c04334
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.accepted_values_ppg_metrics_dtl_gm_or_fp_flag__Y__N.1a6d203954", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        gm_or_fp_flag as value_field,
        count(*) as n_records

    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
    group by gm_or_fp_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:47.348908+00:00
-- finished_at: 2026-08-06T15:26:50.110298+00:00
-- elapsed: 2.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_dtl_month_end_date.412592d599
-- query_id: 01f191ab-3d02-178e-a298-194e1fb99c4a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_dtl_month_end_date.412592d599", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:47.349699+00:00
-- finished_at: 2026-08-06T15:26:50.240148+00:00
-- elapsed: 2.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_ppg_metrics_dtl_month_end_date__cnt_id_nk__cnt_iss_cd_nk__producer_id_nk.fc184e527d
-- query_id: 01f191ab-3d02-1c1a-9f13-432b26c253de
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_ppg_metrics_dtl_month_end_date__cnt_id_nk__cnt_iss_cd_nk__producer_id_nk.fc184e527d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        month_end_date, cnt_id_nk, cnt_iss_cd_nk, producer_id_nk
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
    group by month_end_date, cnt_id_nk, cnt_iss_cd_nk, producer_id_nk
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:47.349752+00:00
-- finished_at: 2026-08-06T15:26:50.314084+00:00
-- elapsed: 3.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_dtl_gm_flag__Y__N.150a00fd7d
-- query_id: 01f191ab-3d02-1d4d-b23c-a5933a9bd628
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.accepted_values_ppg_metrics_dtl_gm_flag__Y__N.150a00fd7d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        gm_flag as value_field,
        count(*) as n_records

    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
    group by gm_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:47.356185+00:00
-- finished_at: 2026-08-06T15:26:50.838543+00:00
-- elapsed: 3.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_expression_is_true_ppg_metrics_dtl_not_risk_management_ind_N_and_wealth_management_ind_N_.8af42a2ee4
-- query_id: 01f191ab-3d03-1ce1-9c72-7a8495185543
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_expression_is_true_ppg_metrics_dtl_not_risk_management_ind_N_and_wealth_management_ind_N_.8af42a2ee4", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`

where not(not (risk_management_ind = 'N' and wealth_management_ind = 'N'))


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:47.348950+00:00
-- finished_at: 2026-08-06T15:26:51.082043+00:00
-- elapsed: 3.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_dtl_fp_flag__Y__N.fbbae0396d
-- query_id: 01f191ab-3d03-11c6-a295-caee80047b74
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.accepted_values_ppg_metrics_dtl_fp_flag__Y__N.fbbae0396d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        fp_flag as value_field,
        count(*) as n_records

    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
    group by fp_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:51.086159+00:00
-- finished_at: 2026-08-06T15:26:53.117239+00:00
-- elapsed: 2.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-3f3d-12f8-a887-8db391138b9a
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly` AS JSON;
-- created_at: 2026-08-06T15:26:53.120789+00:00
-- finished_at: 2026-08-06T15:26:53.914509+00:00
-- elapsed: 793ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-4073-1d4e-9386-fa624388d6f7
-- desc: Fetch tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT tag_name, tag_value
            FROM `system`.`information_schema`.`table_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_monthly';
-- created_at: 2026-08-06T15:26:53.915702+00:00
-- finished_at: 2026-08-06T15:26:54.541154+00:00
-- elapsed: 625ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-40ec-1849-b2b8-4e433bf5d357
-- desc: Fetch column tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name, tag_name, tag_value
            FROM `system`.`information_schema`.`column_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_monthly';
-- created_at: 2026-08-06T15:26:54.542320+00:00
-- finished_at: 2026-08-06T15:26:55.656818+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-414b-1de4-a9f2-9d23208365de
-- desc: Fetch non null constraint columns
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name
            FROM `dbt_dev`.`information_schema`.`columns`
            WHERE table_catalog = 'dbt_dev' 
              AND table_schema = 'dbt_osalami_marts'
              AND table_name = 'ppg_metrics_monthly'
              AND is_nullable = 'NO';
-- created_at: 2026-08-06T15:26:51.104040+00:00
-- finished_at: 2026-08-06T15:26:56.444365+00:00
-- elapsed: 5.3s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_int_summ__sales_total_sales__True__1.73ccad30fc
-- query_id: 01f191ab-3f3f-1385-96c4-8cc0cc56c71a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_int_summ__sales_total_sales__True__1.73ccad30fc", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_summ__sales as (
-- Original CTE: sales
-- Year-to-date new business for the reporting month: one row per month.
--
-- NOTE ON THE YTD FILTER
-- The original wrote it as
--     WHERE YEAR(cnt_eff_dt) = YEAR(month_end_date) AND cnt_eff_dt <= month_end_date
-- which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and month_end_date`
-- but wraps the column in YEAR(), so it cannot prune partitions. `ytd_begin_dt`
-- was already being computed in the dates CTE of all three cells and never used
-- anywhere -- presumably this is what it was for. Using the sargable form.
--
-- ytd_begin_dt is the one genuinely YTD-specific date: 1 January of the
-- reporting year. The other end of the window is just the reporting month end,
-- which is why it is named month_end_date rather than ytd_end_dt.
with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
),

ytd_sales as (
    select dtl.*
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` dtl
    inner join dates dt
        on dtl.month_end_date = dt.month_end_date
    where dtl.cnt_eff_dt >= dt.ytd_begin_dt
      and dtl.cnt_eff_dt <= dt.month_end_date
)

select
    month_end_date,

    count(distinct case when gm_flag = 'Y' then primry_ownr_cl_id end)
        as gm_plan_sales,
    count(distinct case when fp_flag = 'Y' then primry_ownr_cl_id end)
        as fp_plan_sales,
    count(distinct case when gm_flag = 'Y' or fp_flag = 'Y' then primry_ownr_cl_id end)
        as overall_ppg_sales,
    count(distinct primry_ownr_cl_id)
        as total_sales,

    -- nullif guards a divide-by-zero the original left open. It can only fire
    -- if every primry_ownr_cl_id in the month is null, which the not_null test
    -- on ppg_metrics_dtl should already prevent -- belt and braces.
    round(
        count(distinct case when gm_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales_gm,
    round(
        count(distinct case when fp_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales_fp,
    round(
        count(distinct case when gm_flag = 'Y' or fp_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales

from ytd_sales
group by 1
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (


with meet_condition as(
  select *
  from __dbt__cte__int_summ__sales
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not total_sales >= 1
)

select *
from validation_errors


--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:55.658229+00:00
-- finished_at: 2026-08-06T15:26:57.869867+00:00
-- elapsed: 2.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-41f5-1d87-aee3-61e880035c59
-- desc: Fetch PK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT kcu.constraint_name, kcu.column_name
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            WHERE kcu.table_catalog = 'dbt_dev' 
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_metrics_monthly' 
                AND kcu.constraint_name = (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_metrics_monthly' 
                    AND constraint_type = 'PRIMARY KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:26:51.110198+00:00
-- finished_at: 2026-08-06T15:26:58.254372+00:00
-- elapsed: 7.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_int_summ__client_breadth_depth_depth_count__True__1.285881e4cf
-- query_id: 01f191ab-3f40-1324-9d3a-10e848d10e85
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_int_summ__client_breadth_depth_depth_count__True__1.285881e4cf", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_summ__active_clients as (
-- Original CTE: active_clients
-- A client is "active" for the month if they hold at least one contract whose
-- effective date falls in the trailing 60 months ending at month end.
with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.month_end_date
where dtl.cnt_eff_dt between cast(add_months(dtl.month_end_date, -60) + 1 as date)
                         and dtl.month_end_date
), __dbt__cte__int_summ__client_breadth_depth as (
-- Original CTE: base
-- Breadth and depth per client per month. Kept as its own model because
-- client-level breadth/depth is useful on its own, not only as an input to the
-- monthly rollup.
--
-- DEPTH RULE: all term products collapse to a single unit. A client with five
-- term policies and two whole life contracts has depth 3, not 7. The product
-- types that collapse are in ppg_var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
),

active_clients as (
    select * from __dbt__cte__int_summ__active_clients
),

scoped as (
    -- The original read ppg_metrics_dtl here with no month predicate at all and
    -- relied on the join to active_clients to constrain it. That worked, but
    -- only by accident: it scans every retained month before filtering. The
    -- explicit month filter lets the partition prune.
    select ppg.*
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.month_end_date
)

select
    ppg.month_end_date,
    ppg.primry_ownr_cl_id,

    count(distinct ppg.product_category_need_based_by_product)
        as breadth_count,

    count(distinct
        case
            when ppg.product_type in (
                'Level Term and Level Convertible_Renewable Term',
                'Yearly Convertible_Renewable Term'
            )
            then 'TERM'
            else ppg.cnt_id_nk
        end
    ) as depth_count

from scoped ppg
inner join active_clients ac
    on  ppg.primry_ownr_cl_id = ac.primry_ownr_cl_id
    and ppg.month_end_date    = ac.month_end_date
group by 1, 2
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (


with meet_condition as(
  select *
  from __dbt__cte__int_summ__client_breadth_depth
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not depth_count >= 1
)

select *
from validation_errors


--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:51.109825+00:00
-- finished_at: 2026-08-06T15:26:58.293002+00:00
-- elapsed: 7.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_int_summ__client_breadth_depth_breadth_count__True__1.459009bbbb
-- query_id: 01f191ab-3f40-104d-80f9-aba5e648a650
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_int_summ__client_breadth_depth_breadth_count__True__1.459009bbbb", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_summ__active_clients as (
-- Original CTE: active_clients
-- A client is "active" for the month if they hold at least one contract whose
-- effective date falls in the trailing 60 months ending at month end.
with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.month_end_date
where dtl.cnt_eff_dt between cast(add_months(dtl.month_end_date, -60) + 1 as date)
                         and dtl.month_end_date
), __dbt__cte__int_summ__client_breadth_depth as (
-- Original CTE: base
-- Breadth and depth per client per month. Kept as its own model because
-- client-level breadth/depth is useful on its own, not only as an input to the
-- monthly rollup.
--
-- DEPTH RULE: all term products collapse to a single unit. A client with five
-- term policies and two whole life contracts has depth 3, not 7. The product
-- types that collapse are in ppg_var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
),

active_clients as (
    select * from __dbt__cte__int_summ__active_clients
),

scoped as (
    -- The original read ppg_metrics_dtl here with no month predicate at all and
    -- relied on the join to active_clients to constrain it. That worked, but
    -- only by accident: it scans every retained month before filtering. The
    -- explicit month filter lets the partition prune.
    select ppg.*
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.month_end_date
)

select
    ppg.month_end_date,
    ppg.primry_ownr_cl_id,

    count(distinct ppg.product_category_need_based_by_product)
        as breadth_count,

    count(distinct
        case
            when ppg.product_type in (
                'Level Term and Level Convertible_Renewable Term',
                'Yearly Convertible_Renewable Term'
            )
            then 'TERM'
            else ppg.cnt_id_nk
        end
    ) as depth_count

from scoped ppg
inner join active_clients ac
    on  ppg.primry_ownr_cl_id = ac.primry_ownr_cl_id
    and ppg.month_end_date    = ac.month_end_date
group by 1, 2
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (


with meet_condition as(
  select *
  from __dbt__cte__int_summ__client_breadth_depth
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not breadth_count >= 1
)

select *
from validation_errors


--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:26:58.307975+00:00
-- finished_at: 2026-08-06T15:26:59.311564+00:00
-- elapsed: 1.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-438a-10c1-8c77-db59d94e943f
-- desc: get_relation adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly` AS JSON;
-- created_at: 2026-08-06T15:26:57.871310+00:00
-- finished_at: 2026-08-06T15:26:59.862688+00:00
-- elapsed: 2.0s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-4347-1f3c-a9df-086b4b7f2baa
-- desc: Fetch FK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT
                kcu.constraint_name,
                kcu.column_name AS from_column,
                ukcu.table_catalog AS to_catalog,
                ukcu.table_schema AS to_schema,
                ukcu.table_name AS to_table,
                ukcu.column_name AS to_column
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            JOIN `dbt_dev`.information_schema.referential_constraints rc
                ON kcu.constraint_name = rc.constraint_name
            JOIN `dbt_dev`.information_schema.key_column_usage ukcu
                ON rc.unique_constraint_name = ukcu.constraint_name
                AND kcu.ordinal_position = ukcu.ordinal_position
            WHERE kcu.table_catalog = 'dbt_dev'
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_metrics_monthly'
                AND kcu.constraint_name IN (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_metrics_monthly'
                    AND constraint_type = 'FOREIGN KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:26:59.315559+00:00
-- finished_at: 2026-08-06T15:27:00.042693+00:00
-- elapsed: 727ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-4424-1835-b29d-b9f50135d6e6
-- desc: Fetch tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT tag_name, tag_value
            FROM `system`.`information_schema`.`table_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_summ_monthly';
-- created_at: 2026-08-06T15:26:59.863644+00:00
-- finished_at: 2026-08-06T15:27:00.297082+00:00
-- elapsed: 433ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-4477-14fe-ae76-f2bf215b81e6
-- desc: Fetch column masks
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT 
                column_name,
                mask_name,
                using_columns
            FROM `system`.`information_schema`.`column_masks`
            WHERE table_catalog = 'dbt_dev'
                AND table_schema = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_monthly';
-- created_at: 2026-08-06T15:27:00.043417+00:00
-- finished_at: 2026-08-06T15:27:00.662961+00:00
-- elapsed: 619ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-4493-1cae-8575-36e18296d698
-- desc: Fetch column tags
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name, tag_name, tag_value
            FROM `system`.`information_schema`.`column_tags`
            WHERE catalog_name = 'dbt_dev' 
                AND schema_name = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_summ_monthly';
-- created_at: 2026-08-06T15:27:00.298188+00:00
-- finished_at: 2026-08-06T15:27:00.963884+00:00
-- elapsed: 665ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-44b9-1974-a262-216e93e51689
-- desc: Show table properties
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
SHOW TBLPROPERTIES `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`;
-- created_at: 2026-08-06T15:27:00.965417+00:00
-- finished_at: 2026-08-06T15:27:01.595064+00:00
-- elapsed: 629ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-451f-13f6-b779-f2bde9c5f187
-- desc: Describe table extended
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
describe extended `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`;
-- created_at: 2026-08-06T15:27:00.664340+00:00
-- finished_at: 2026-08-06T15:27:01.603482+00:00
-- elapsed: 939ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-44f2-1600-95ae-7ba17404928c
-- desc: Fetch non null constraint columns
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT column_name
            FROM `dbt_dev`.`information_schema`.`columns`
            WHERE table_catalog = 'dbt_dev' 
              AND table_schema = 'dbt_osalami_marts'
              AND table_name = 'ppg_metrics_summ_monthly'
              AND is_nullable = 'NO';
-- created_at: 2026-08-06T15:27:01.599196+00:00
-- finished_at: 2026-08-06T15:27:02.242915+00:00
-- elapsed: 643ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-4580-1bd7-a46e-4b7e9492716d
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
create or replace temporary view `ppg_metrics_monthly__dbt_tmp` as
      

-- Original: cell 3, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_monthly
--
-- WHAT THIS MODEL ACTUALLY DOES
-- It is ppg_metrics_dtl with two columns removed -- cnt_iss_cd_nk and
-- producer_cnt_role_nm -- and a `distinct` on top. That is not a cosmetic
-- projection: it is a deliberate grain reduction. See the note in the README.
--
-- The original's `INNER JOIN dates dt ON dt.ytd_end_dt = month_end_date` was
-- doing the job dbt's incremental config now does: pick the one month to
-- append. Kept as an explicit filter so a run is idempotent for a given
-- report_month and `--vars` backfill still works.

with dtl as (

    select * from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`

    
    -- Restrict to the reporting month, exactly as the original did.
    where month_end_date = (select month_end_date from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`)
    

),

current_load as (

    select distinct
        snapshot_date,
        month_end_date,
        lob_nm,
        primry_ownr_cl_id,
        cnt_id_nk,
        cnt_eff_dt,
        producer_id_nk,
        product_category_protection_accumulation_alternate,
        product_category_need_based_by_product,
        product_category_risk_wm,
        product_type,
        risk_management_ind,
        wealth_management_ind,
        gm_flag,
        fp_flag,
        gm_or_fp_flag
    from dtl

)



select * from current_load;
-- created_at: 2026-08-06T15:27:01.604304+00:00
-- finished_at: 2026-08-06T15:27:02.342642+00:00
-- elapsed: 738ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-4581-17a9-87cb-4fcaa339b7e6
-- desc: Fetch PK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT kcu.constraint_name, kcu.column_name
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            WHERE kcu.table_catalog = 'dbt_dev' 
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_metrics_summ_monthly' 
                AND kcu.constraint_name = (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_metrics_summ_monthly' 
                    AND constraint_type = 'PRIMARY KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:27:02.247034+00:00
-- finished_at: 2026-08-06T15:27:02.540158+00:00
-- elapsed: 293ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-45e3-189c-a172-876c0e248c78
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `ppg_metrics_monthly__dbt_tmp` AS JSON;
-- created_at: 2026-08-06T15:27:02.541047+00:00
-- finished_at: 2026-08-06T15:27:03.385958+00:00
-- elapsed: 844ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-4611-133e-84ab-3bef4329d924
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly` AS JSON;
-- created_at: 2026-08-06T15:27:02.344452+00:00
-- finished_at: 2026-08-06T15:27:04.224457+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-45f2-1658-9452-4fdd994ff9d6
-- desc: Fetch FK constraints
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT
                kcu.constraint_name,
                kcu.column_name AS from_column,
                ukcu.table_catalog AS to_catalog,
                ukcu.table_schema AS to_schema,
                ukcu.table_name AS to_table,
                ukcu.column_name AS to_column
            FROM `dbt_dev`.information_schema.key_column_usage kcu
            JOIN `dbt_dev`.information_schema.referential_constraints rc
                ON kcu.constraint_name = rc.constraint_name
            JOIN `dbt_dev`.information_schema.key_column_usage ukcu
                ON rc.unique_constraint_name = ukcu.constraint_name
                AND kcu.ordinal_position = ukcu.ordinal_position
            WHERE kcu.table_catalog = 'dbt_dev'
                AND kcu.table_schema = 'dbt_osalami_marts'
                AND kcu.table_name = 'ppg_metrics_summ_monthly'
                AND kcu.constraint_name IN (
                SELECT constraint_name
                FROM `dbt_dev`.information_schema.table_constraints
                WHERE table_catalog = 'dbt_dev'
                    AND table_schema = 'dbt_osalami_marts'
                    AND table_name = 'ppg_metrics_summ_monthly'
                    AND constraint_type = 'FOREIGN KEY'
                )
            ORDER BY kcu.ordinal_position;
-- created_at: 2026-08-06T15:27:04.225281+00:00
-- finished_at: 2026-08-06T15:27:04.848714+00:00
-- elapsed: 623ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-4712-17ff-855b-7ff6d01c92b2
-- desc: Fetch column masks
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
SELECT 
                column_name,
                mask_name,
                using_columns
            FROM `system`.`information_schema`.`column_masks`
            WHERE table_catalog = 'dbt_dev'
                AND table_schema = 'dbt_osalami_marts'
                AND table_name = 'ppg_metrics_summ_monthly';
-- created_at: 2026-08-06T15:27:04.850052+00:00
-- finished_at: 2026-08-06T15:27:05.456362+00:00
-- elapsed: 606ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-4770-14d8-aed7-275ba2cadb69
-- desc: Show table properties
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
SHOW TBLPROPERTIES `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`;
-- created_at: 2026-08-06T15:27:05.457504+00:00
-- finished_at: 2026-08-06T15:27:06.136082+00:00
-- elapsed: 678ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-47cd-13a6-8075-e7031e04ad98
-- desc: Describe table extended
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
describe extended `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`;
-- created_at: 2026-08-06T15:27:06.140927+00:00
-- finished_at: 2026-08-06T15:27:07.107177+00:00
-- elapsed: 966ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-4836-1039-8930-07d795fb2b05
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
create or replace temporary view `ppg_metrics_summ_monthly__dbt_tmp` as
      with __dbt__cte__int_summ__sales as (
-- Original CTE: sales
-- Year-to-date new business for the reporting month: one row per month.
--
-- NOTE ON THE YTD FILTER
-- The original wrote it as
--     WHERE YEAR(cnt_eff_dt) = YEAR(month_end_date) AND cnt_eff_dt <= month_end_date
-- which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and month_end_date`
-- but wraps the column in YEAR(), so it cannot prune partitions. `ytd_begin_dt`
-- was already being computed in the dates CTE of all three cells and never used
-- anywhere -- presumably this is what it was for. Using the sargable form.
--
-- ytd_begin_dt is the one genuinely YTD-specific date: 1 January of the
-- reporting year. The other end of the window is just the reporting month end,
-- which is why it is named month_end_date rather than ytd_end_dt.
with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
),

ytd_sales as (
    select dtl.*
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` dtl
    inner join dates dt
        on dtl.month_end_date = dt.month_end_date
    where dtl.cnt_eff_dt >= dt.ytd_begin_dt
      and dtl.cnt_eff_dt <= dt.month_end_date
)

select
    month_end_date,

    count(distinct case when gm_flag = 'Y' then primry_ownr_cl_id end)
        as gm_plan_sales,
    count(distinct case when fp_flag = 'Y' then primry_ownr_cl_id end)
        as fp_plan_sales,
    count(distinct case when gm_flag = 'Y' or fp_flag = 'Y' then primry_ownr_cl_id end)
        as overall_ppg_sales,
    count(distinct primry_ownr_cl_id)
        as total_sales,

    -- nullif guards a divide-by-zero the original left open. It can only fire
    -- if every primry_ownr_cl_id in the month is null, which the not_null test
    -- on ppg_metrics_dtl should already prevent -- belt and braces.
    round(
        count(distinct case when gm_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales_gm,
    round(
        count(distinct case when fp_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales_fp,
    round(
        count(distinct case when gm_flag = 'Y' or fp_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales

from ytd_sales
group by 1
), __dbt__cte__int_summ__active_clients as (
-- Original CTE: active_clients
-- A client is "active" for the month if they hold at least one contract whose
-- effective date falls in the trailing 60 months ending at month end.
with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.month_end_date
where dtl.cnt_eff_dt between cast(add_months(dtl.month_end_date, -60) + 1 as date)
                         and dtl.month_end_date
), __dbt__cte__int_summ__client_breadth_depth as (
-- Original CTE: base
-- Breadth and depth per client per month. Kept as its own model because
-- client-level breadth/depth is useful on its own, not only as an input to the
-- monthly rollup.
--
-- DEPTH RULE: all term products collapse to a single unit. A client with five
-- term policies and two whole life contracts has depth 3, not 7. The product
-- types that collapse are in ppg_var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt_dev`.`dbt_osalami_staging`.`stg_pdm__dates`
),

active_clients as (
    select * from __dbt__cte__int_summ__active_clients
),

scoped as (
    -- The original read ppg_metrics_dtl here with no month predicate at all and
    -- relied on the join to active_clients to constrain it. That worked, but
    -- only by accident: it scans every retained month before filtering. The
    -- explicit month filter lets the partition prune.
    select ppg.*
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.month_end_date
)

select
    ppg.month_end_date,
    ppg.primry_ownr_cl_id,

    count(distinct ppg.product_category_need_based_by_product)
        as breadth_count,

    count(distinct
        case
            when ppg.product_type in (
                'Level Term and Level Convertible_Renewable Term',
                'Yearly Convertible_Renewable Term'
            )
            then 'TERM'
            else ppg.cnt_id_nk
        end
    ) as depth_count

from scoped ppg
inner join active_clients ac
    on  ppg.primry_ownr_cl_id = ac.primry_ownr_cl_id
    and ppg.month_end_date    = ac.month_end_date
group by 1, 2
), __dbt__cte__int_summ__breadth_depth as (
-- Original CTE: breadth_depth
-- Rolls the per-client figures up to one row per month.
with breadth_depth as (
select
    month_end_date,
    sum(breadth_count)                  as breadth_val,
    sum(depth_count)                    as depth_val,
    count(distinct primry_ownr_cl_id)   as denominator
from __dbt__cte__int_summ__client_breadth_depth
group by 1
)
select * from breadth_depth
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (


-- Original: cell 4, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_summ_monthly
--
-- One row per reporting month. Two independent halves joined on the month:
--   sales        -- YTD new business counts and penetration rates
--   breadth_depth-- multi-product breadth and depth across active clients
--
-- The original's ORDER BY is dropped. Ordering an insert into a Delta table
-- does nothing for the stored result and costs a shuffle.

with sales as (
    select * from __dbt__cte__int_summ__sales
),

breadth_depth as (
    select * from __dbt__cte__int_summ__breadth_depth
)

select
    s.month_end_date,

    s.gm_plan_sales,
    s.fp_plan_sales,
    s.overall_ppg_sales          as plan_sales,
    s.total_sales,
    s.ppg_sales_gm               as gm_led_sales,
    s.ppg_sales_fp               as fb_led_sales,
    s.ppg_sales,

    bd.breadth_val,
    bd.depth_val,
    bd.denominator,

    round(bd.breadth_val / nullif(bd.denominator, 0), 2)  as multi_product_breadth,
    round(bd.depth_val   / nullif(bd.denominator, 0), 2)  as multi_product_depth

from sales s
left join breadth_depth bd
    on s.month_end_date = bd.month_end_date
--EPHEMERAL-SELECT-WRAPPER-END
);
-- created_at: 2026-08-06T15:27:07.111868+00:00
-- finished_at: 2026-08-06T15:27:07.399016+00:00
-- elapsed: 287ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-48ca-127c-bfe7-72afa3de8583
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `ppg_metrics_summ_monthly__dbt_tmp` AS JSON;
-- created_at: 2026-08-06T15:27:03.391692+00:00
-- finished_at: 2026-08-06T15:27:07.974211+00:00
-- elapsed: 4.6s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_monthly
-- query_id: 01f191ab-4692-18bb-aab4-b883e7b10403
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_monthly", "profile_name": "ppg", "target_name": "dev"} */
insert into table `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly` AS t
        replace on (t.month_end_date <=> s.month_end_date)
        (select snapshot_date, month_end_date, lob_nm, primry_ownr_cl_id, cnt_id_nk, cnt_eff_dt, producer_id_nk, product_category_protection_accumulation_alternate, product_category_need_based_by_product, product_category_risk_wm, product_type, risk_management_ind, wealth_management_ind, gm_flag, fp_flag, gm_or_fp_flag from `ppg_metrics_monthly__dbt_tmp`) AS s;
-- created_at: 2026-08-06T15:27:07.401434+00:00
-- finished_at: 2026-08-06T15:27:08.103991+00:00
-- elapsed: 702ms
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-48f6-10cb-ae32-b87f8cbc666c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
DESCRIBE TABLE EXTENDED `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly` AS JSON;
-- created_at: 2026-08-06T15:27:07.988427+00:00
-- finished_at: 2026-08-06T15:27:09.678416+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_monthly_cnt_id_nk.dce8f255af
-- query_id: 01f191ab-4950-12cd-bfef-896e6e62e4c5
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_monthly_cnt_id_nk.dce8f255af", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cnt_id_nk
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`
where cnt_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:07.987893+00:00
-- finished_at: 2026-08-06T15:27:09.955923+00:00
-- elapsed: 2.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_monthly_primry_ownr_cl_id.13f705ab85
-- query_id: 01f191ab-494f-1f26-bf3d-3bbe78164a67
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_monthly_primry_ownr_cl_id.13f705ab85", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select primry_ownr_cl_id
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`
where primry_ownr_cl_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:07.988556+00:00
-- finished_at: 2026-08-06T15:27:10.220304+00:00
-- elapsed: 2.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_monthly_month_end_date.b741eb0a07
-- query_id: 01f191ab-494f-1ec9-92f7-79636fd81f90
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_monthly_month_end_date.b741eb0a07", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:07.988556+00:00
-- finished_at: 2026-08-06T15:27:10.802335+00:00
-- elapsed: 2.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_monthly_gm_or_fp_flag__Y__N.f9d5d38f1f
-- query_id: 01f191ab-494f-1ff9-a1ab-94c555c45302
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.accepted_values_ppg_metrics_monthly_gm_or_fp_flag__Y__N.f9d5d38f1f", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        gm_or_fp_flag as value_field,
        count(*) as n_records

    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`
    group by gm_or_fp_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:07.988040+00:00
-- finished_at: 2026-08-06T15:27:10.928176+00:00
-- elapsed: 2.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_ppg_metrics_monthly_month_end_date__cnt_id_nk__producer_id_nk.17aec53a17
-- query_id: 01f191ab-4950-10c7-a3f4-f8e483cbbfc0
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_ppg_metrics_monthly_month_end_date__cnt_id_nk__producer_id_nk.17aec53a17", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        month_end_date, cnt_id_nk, producer_id_nk
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`
    group by month_end_date, cnt_id_nk, producer_id_nk
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:07.992196+00:00
-- finished_at: 2026-08-06T15:27:11.966973+00:00
-- elapsed: 4.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_equal_rowcount_ppg_metrics_monthly_ref_ppg_metrics_dtl_.832da2b0ab
-- query_id: 01f191ab-494f-1e24-8a69-ae8d9e4b5822
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_equal_rowcount_ppg_metrics_monthly_ref_ppg_metrics_dtl_.832da2b0ab", "profile_name": "ppg", "target_name": "dev"} */
select
      sum(coalesce(diff_count, 0)) as failures,
      sum(coalesce(diff_count, 0)) != 0 as should_warn,
      sum(coalesce(diff_count, 0)) != 0 as should_error
    from (
      
    
  




with a as (

    select 
      
      1 as id_dbtutils_test_equal_rowcount,
      count(*) as count_a 
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_monthly`
    group by id_dbtutils_test_equal_rowcount


),
b as (

    select 
      
      1 as id_dbtutils_test_equal_rowcount,
      count(*) as count_b 
    from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_dtl`
    group by id_dbtutils_test_equal_rowcount

),
final as (

    select
    
        a.id_dbtutils_test_equal_rowcount as id_dbtutils_test_equal_rowcount_a,
          b.id_dbtutils_test_equal_rowcount as id_dbtutils_test_equal_rowcount_b,
        

        count_a,
        count_b,
        abs(count_a - count_b) as diff_count

    from a
    full join b
    on
    a.id_dbtutils_test_equal_rowcount = b.id_dbtutils_test_equal_rowcount
    


)

select * from final


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:08.106246+00:00
-- finished_at: 2026-08-06T15:27:17.351549+00:00
-- elapsed: 9.2s
-- outcome: success
-- dialect: databricks
-- node_id: model.ppg.ppg_metrics_summ_monthly
-- query_id: 01f191ab-4961-1d21-965e-dc4135099638
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.ppg.ppg_metrics_summ_monthly", "profile_name": "ppg", "target_name": "dev"} */
insert into table `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly` AS t
        replace on (t.month_end_date <=> s.month_end_date)
        (select month_end_date, gm_plan_sales, fp_plan_sales, plan_sales, total_sales, gm_led_sales, fb_led_sales, ppg_sales, breadth_val, depth_val, denominator, multi_product_breadth, multi_product_depth from `ppg_metrics_summ_monthly__dbt_tmp`) AS s;
-- created_at: 2026-08-06T15:27:17.372023+00:00
-- finished_at: 2026-08-06T15:27:20.139333+00:00
-- elapsed: 2.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_depth__True__1.c6de04b8cc
-- query_id: 01f191ab-4ee8-113f-839b-f5514c430ba2
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_depth__True__1.c6de04b8cc", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not multi_product_depth >= 1
)

select *
from validation_errors


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.371742+00:00
-- finished_at: 2026-08-06T15:27:20.331982+00:00
-- elapsed: 3.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_ppg_sales__True__100__0.b0e462b736
-- query_id: 01f191ab-4ee7-1aea-af2f-8884990bac73
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_ppg_sales__True__100__0.b0e462b736", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not ppg_sales >= 0
    -- records with a value <= max_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not ppg_sales <= 100
)

select *
from validation_errors


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.370497+00:00
-- finished_at: 2026-08-06T15:27:20.593688+00:00
-- elapsed: 3.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_summ_monthly_plan_sales.46ad626fd4
-- query_id: 01f191ab-4ee6-1e39-b01a-8c494a4d7f1c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_summ_monthly_plan_sales.46ad626fd4", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select plan_sales
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
where plan_sales is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.372112+00:00
-- finished_at: 2026-08-06T15:27:20.826646+00:00
-- elapsed: 3.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_summ_monthly_total_sales.7c176c86bc
-- query_id: 01f191ab-4ee7-1b14-ac9c-c11a7737788b
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_summ_monthly_total_sales.7c176c86bc", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_sales
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
where total_sales is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.372199+00:00
-- finished_at: 2026-08-06T15:27:21.028775+00:00
-- elapsed: 3.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_summ_monthly_month_end_date.305b9b6d30
-- query_id: 01f191ab-4ee8-1966-853a-7191fd4f4f73
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_summ_monthly_month_end_date.305b9b6d30", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.371291+00:00
-- finished_at: 2026-08-06T15:27:21.077725+00:00
-- elapsed: 3.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_gm_led_sales__True__100__0.eb1d3d87eb
-- query_id: 01f191ab-4ee7-1b8f-954d-5d96ca16209a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_gm_led_sales__True__100__0.eb1d3d87eb", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not gm_led_sales >= 0
    -- records with a value <= max_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not gm_led_sales <= 100
)

select *
from validation_errors


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.372151+00:00
-- finished_at: 2026-08-06T15:27:21.169399+00:00
-- elapsed: 3.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_fb_led_sales__True__100__0.f5d8537f89
-- query_id: 01f191ab-4ee8-110e-b514-760ea9d82e43
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_fb_led_sales__True__100__0.f5d8537f89", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not fb_led_sales >= 0
    -- records with a value <= max_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not fb_led_sales <= 100
)

select *
from validation_errors


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.372426+00:00
-- finished_at: 2026-08-06T15:27:21.234567+00:00
-- elapsed: 3.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_plan_sales_total_sales.60d14dc3d1
-- query_id: 01f191ab-4ee8-1732-9d1f-438ae866b3d1
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_plan_sales_total_sales.60d14dc3d1", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`

where not(plan_sales <= total_sales)


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.371667+00:00
-- finished_at: 2026-08-06T15:27:21.314452+00:00
-- elapsed: 3.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_depth_val_breadth_val.6773b60a8f
-- query_id: 01f191ab-4ee8-16fd-af80-0e1144a64e14
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_depth_val_breadth_val.6773b60a8f", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`

where not(depth_val >= breadth_val)


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.371623+00:00
-- finished_at: 2026-08-06T15:27:21.455123+00:00
-- elapsed: 4.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_ppg_metrics_summ_monthly_month_end_date.f6d3aec00d
-- query_id: 01f191ab-4ee6-1f63-929d-4018b08a535a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_ppg_metrics_summ_monthly_month_end_date.f6d3aec00d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    month_end_date as unique_field,
    count(*) as n_records

from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
where month_end_date is not null
group by month_end_date
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-06T15:27:17.371782+00:00
-- finished_at: 2026-08-06T15:27:22.841404+00:00
-- elapsed: 5.5s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_breadth__True__1.b6dded3a75
-- query_id: 01f191ab-4ee8-1634-b574-6032f4846566
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_breadth__True__1.b6dded3a75", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt_dev`.`dbt_osalami_marts`.`ppg_metrics_summ_monthly`
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not multi_product_breadth >= 1
)

select *
from validation_errors


  
  
      
    ) dbt_internal_test;
