-- created_at: 2026-08-01T17:29:28.376048+00:00
-- finished_at: 2026-08-01T17:29:30.002850+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_lob_producer_role_lob_nm.275148d784
-- query_id: 01f18dce-8c7b-1fc4-90a8-45091ca61434
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_lob_producer_role_lob_nm.275148d784", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select lob_nm
from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
where lob_nm is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:28.839408+00:00
-- finished_at: 2026-08-01T17:29:30.002846+00:00
-- elapsed: 1.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_product_category_map_product_grp_nm.28487958f0
-- query_id: 01f18dce-8cc3-16a5-bcb5-8fd2460b11cc
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_product_category_map_product_grp_nm.28487958f0", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_grp_nm
from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`product_category_map`
where product_grp_nm is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:27.950456+00:00
-- finished_at: 2026-08-01T17:29:30.096542+00:00
-- elapsed: 2.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__ytd_dates_ytd_end_dt.243df6f715
-- query_id: 01f18dce-8c3a-1e86-a6c0-ca09780e787a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__ytd_dates_ytd_end_dt.243df6f715", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ytd_end_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
where ytd_end_dt is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:28.291661+00:00
-- finished_at: 2026-08-01T17:29:30.151402+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_product_category_map_product_type.78278e6976
-- query_id: 01f18dce-8c6f-1063-8116-03779a239661
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_product_category_map_product_type.78278e6976", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_type
from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`product_category_map`
where product_type is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.089385+00:00
-- finished_at: 2026-08-01T17:29:30.230400+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__dates_month_end_date.3c4a5d713c
-- query_id: 01f18dce-8ce8-174b-901f-33ecc1bfc03c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__dates_month_end_date.3c4a5d713c", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__dates`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:28.183916+00:00
-- finished_at: 2026-08-01T17:29:30.239653+00:00
-- elapsed: 2.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_owners__by_invest_acct_cnt_acct_id_nk.85eb09e9a8
-- query_id: 01f18dce-8c5e-14d5-a64a-639deeb8d48b
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
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- created_at: 2026-08-01T17:29:28.595329+00:00
-- finished_at: 2026-08-01T17:29:30.259920+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_owners__by_contract_cnt_acct_id_nk.92805b3037
-- query_id: 01f18dce-8c9d-1415-bee3-37ac449bd5c5
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
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- created_at: 2026-08-01T17:29:28.490089+00:00
-- finished_at: 2026-08-01T17:29:30.518336+00:00
-- elapsed: 2.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_planning__fp_clients_client_id.b6adc1b83f
-- query_id: 01f18dce-8c8c-1d68-8f17-d1e298ae9118
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_planning__fp_clients_client_id.b6adc1b83f", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select client_id
from __dbt__cte__int_planning__fp_clients
where client_id is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.931634+00:00
-- finished_at: 2026-08-01T17:29:30.785092+00:00
-- elapsed: 853ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_owners__by_invest_acct_cnt_acct_id_nk.c3e608a7e8
-- query_id: 01f18dce-8d69-1273-ae1f-d098d5a76a3a
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
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- created_at: 2026-08-01T17:29:29.828775+00:00
-- finished_at: 2026-08-01T17:29:30.827419+00:00
-- elapsed: 998ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_int_contracts__scoped_cnt_id_nk__cnt_iss_cd_nk__plan_cd.de598a0224
-- query_id: 01f18dce-8d59-135d-834d-be355876c6d6
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
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
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
-- created_at: 2026-08-01T17:29:28.714710+00:00
-- finished_at: 2026-08-01T17:29:30.885447+00:00
-- elapsed: 2.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_lob_producer_role_lob_nm.5aec84cb89
-- query_id: 01f18dce-8caf-1a36-bf6b-500c7a5ce8b2
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_lob_producer_role_lob_nm.5aec84cb89", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    lob_nm as unique_field,
    count(*) as n_records

from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
where lob_nm is not null
group by lob_nm
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:28.067212+00:00
-- finished_at: 2026-08-01T17:29:30.925651+00:00
-- elapsed: 2.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.assert_depth_collapse_types_exist
-- query_id: 01f18dce-8c4c-174c-8c7a-a108160a0e1f
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
left join `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`product_category_map` m
    on m.product_type = e.product_type
where m.product_type is null
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:30.140149+00:00
-- finished_at: 2026-08-01T17:29:30.987964+00:00
-- elapsed: 847ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_stg_pdm__ytd_dates_ytd_end_dt.9b710b166e
-- query_id: 01f18dce-8d87-1f25-a96b-d366b1278e0f
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_stg_pdm__ytd_dates_ytd_end_dt.9b710b166e", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    ytd_end_dt as unique_field,
    count(*) as n_records

from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
where ytd_end_dt is not null
group by ytd_end_dt
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.366145+00:00
-- finished_at: 2026-08-01T17:29:31.105077+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.relationships_stg_pdm__ytd_dates_ytd_end_dt__month_end_date__ref_stg_pdm__dates_.69bdbe6489
-- query_id: 01f18dce-8d12-1716-a8ba-7cacfc7535a3
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.relationships_stg_pdm__ytd_dates_ytd_end_dt__month_end_date__ref_stg_pdm__dates_.69bdbe6489", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select ytd_end_dt as from_field
    from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
    where ytd_end_dt is not null
),

parent as (
    select month_end_date as to_field
    from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__dates`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:30.405514+00:00
-- finished_at: 2026-08-01T17:29:31.330699+00:00
-- elapsed: 925ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__ytd_dates_ytd_begin_dt.1d8481bd61
-- query_id: 01f18dce-8db1-15ab-9414-09b4f2d67a1d
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__ytd_dates_ytd_begin_dt.1d8481bd61", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ytd_begin_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
where ytd_begin_dt is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:30.047075+00:00
-- finished_at: 2026-08-01T17:29:31.367785+00:00
-- elapsed: 1.3s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_metrics__policy_owner_po_client_id_nk.1ba11d3319
-- query_id: 01f18dce-8d7b-12a4-8f97-3f78ea2a9f2a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_metrics__policy_owner_po_client_id_nk.1ba11d3319", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select po_client_id_nk
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_metrics__policy_owner`
where po_client_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.453224+00:00
-- finished_at: 2026-08-01T17:29:31.534299+00:00
-- elapsed: 2.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_crm__sf_account_case_cl_id.edfd4a31db
-- query_id: 01f18dce-8d1f-1858-ab5b-61982eb61b9c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_crm__sf_account_case_cl_id.edfd4a31db", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select case_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_crm__sf_account`
where case_cl_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.259038+00:00
-- finished_at: 2026-08-01T17:29:31.629510+00:00
-- elapsed: 2.4s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_contracts__scoped_cnt_id_nk.f41f183cdb
-- query_id: 01f18dce-8d01-16b0-87c4-23a36e9b938d
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
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select cnt_id_nk
from __dbt__cte__int_contracts__scoped
where cnt_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:30.328639+00:00
-- finished_at: 2026-08-01T17:29:31.968272+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__dates_snapshot_date.2d2296f657
-- query_id: 01f18dce-8da5-1473-ba3f-57350f9b1aed
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__dates_snapshot_date.2d2296f657", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select snapshot_date
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__dates`
where snapshot_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:30.247547+00:00
-- finished_at: 2026-08-01T17:29:31.986074+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_owners__by_contract_cnt_acct_id_nk.4af90caf14
-- query_id: 01f18dce-8d99-1881-9b5c-d19eebbc7bb4
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
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- created_at: 2026-08-01T17:29:29.626506+00:00
-- finished_at: 2026-08-01T17:29:32.327523+00:00
-- elapsed: 2.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_stg_pdm__ytd_dates_ytd_end_dim_sqn.8e8f8be4a5
-- query_id: 01f18dce-8d3a-17eb-8bb4-d0d67c77fe9c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_stg_pdm__ytd_dates_ytd_end_dim_sqn.8e8f8be4a5", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ytd_end_dim_sqn
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
where ytd_end_dim_sqn is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.173029+00:00
-- finished_at: 2026-08-01T17:29:32.358643+00:00
-- elapsed: 3.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_product_category_map_product_ln_cd.b776cfaa95
-- query_id: 01f18dce-8cf5-1049-ae33-0bd62c15fedb
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_product_category_map_product_ln_cd.b776cfaa95", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_ln_cd
from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`product_category_map`
where product_ln_cd is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.541134+00:00
-- finished_at: 2026-08-01T17:29:32.378138+00:00
-- elapsed: 2.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_stg_pdm__dates_snapshot_date.b8bd9f5cf7
-- query_id: 01f18dce-8d2d-10d1-8dbe-b3e8bbb21daa
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_stg_pdm__dates_snapshot_date.b8bd9f5cf7", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    snapshot_date as unique_field,
    count(*) as n_records

from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__dates`
where snapshot_date is not null
group by snapshot_date
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:29.707319+00:00
-- finished_at: 2026-08-01T17:29:32.479089+00:00
-- elapsed: 2.8s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_product_category_map_product_ln_cd__product_grp_nm__product_nm.2306d69278
-- query_id: 01f18dce-8d46-1458-ad73-4a048e26765b
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
    from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`product_category_map`
    group by product_ln_cd, product_grp_nm, product_nm
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:31.543728+00:00
-- finished_at: 2026-08-01T17:29:32.517596+00:00
-- elapsed: 973ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_planning__gm_clients_client_id.25e1949c66
-- query_id: 01f18dce-8e5e-184c-8da0-945b2e245234
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
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
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
-- created_at: 2026-08-01T17:29:31.543728+00:00
-- finished_at: 2026-08-01T17:29:32.631469+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_planning__gm_clients_client_id.67a0241c46
-- query_id: 01f18dce-8e5e-1da2-aa49-5c26420ff3e2
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
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select client_id
from __dbt__cte__int_planning__gm_clients
where client_id is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:32.331408+00:00
-- finished_at: 2026-08-01T17:29:32.968047+00:00
-- elapsed: 636ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_clients__active_eop_po_client_id_nk.f106377f37
-- query_id: 01f18dce-8ed6-185d-9050-3ffd12ea88a9
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
select distinct
    po.po_client_id_nk,
    dt.ytd_end_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_metrics__policy_owner` po
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates` dt
    on po.dt_key = dt.ytd_end_dim_sqn
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select po_client_id_nk
from __dbt__cte__int_clients__active_eop
where po_client_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:32.331470+00:00
-- finished_at: 2026-08-01T17:29:32.970081+00:00
-- elapsed: 638ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_clients__active_eop_po_client_id_nk.d33fe6dfaa
-- query_id: 01f18dce-8ed6-1431-9918-6eeb61c4d7d2
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
select distinct
    po.po_client_id_nk,
    dt.ytd_end_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_metrics__policy_owner` po
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates` dt
    on po.dt_key = dt.ytd_end_dim_sqn
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
-- created_at: 2026-08-01T17:29:30.497681+00:00
-- finished_at: 2026-08-01T17:29:33.135062+00:00
-- elapsed: 2.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_planning__fp_clients_client_id.335dc01a90
-- query_id: 01f18dce-8dbe-1b30-9f6f-432535fda434
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_planning__fp_clients_client_id.335dc01a90", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_fx__feebased_fp_plans`
group by 1
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
-- created_at: 2026-08-01T17:29:33.148262+00:00
-- finished_at: 2026-08-01T17:29:34.198923+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_clients__planning_flags_client_id.c0c995a5be
-- query_id: 01f18dce-8f53-1d61-afb9-238b13fda37e
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
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
), __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_fx__feebased_fp_plans`
group by 1
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
-- created_at: 2026-08-01T17:29:33.148265+00:00
-- finished_at: 2026-08-01T17:29:34.199972+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_clients__planning_flags_client_id.c05be35a43
-- query_id: 01f18dce-8f53-1308-ba83-ce38c31c8d88
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
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
), __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_fx__feebased_fp_plans`
group by 1
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
-- created_at: 2026-08-01T17:29:33.148026+00:00
-- finished_at: 2026-08-01T17:29:34.202195+00:00
-- elapsed: 1.1s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_clients__planning_flags_completed_plan_dt.c6239071ea
-- query_id: 01f18dce-8f53-123a-960d-f8016a960d26
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
select
    acct.case_cl_id                 as client_id,
    min(gm.completed_plan_dt)       as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_digital__gm_plan_dates` gm
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_crm__sf_account` acct
    on acct.acct_id_nk = gm.salesforce_id
group by 1
), __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_fx__feebased_fp_plans`
group by 1
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
-- created_at: 2026-08-01T17:29:32.011239+00:00
-- finished_at: 2026-08-01T17:29:34.729243+00:00
-- elapsed: 2.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_products__unified_cnt_id_nk.5323da792a
-- query_id: 01f18dce-8ea7-1466-8927-7061d22efbca
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
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- filter was commented out. One branch driven by a seed replaces all three.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contract_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        cp.producer_cnt_role_nm,
        rl.preferred_producer_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
    left join roles rl
        on  rl.lob_nm = cn.lob_nm
    




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
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- role filter. Seed-driven single branch here.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        rl.preferred_producer_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
    left join roles rl
        on rl.lob_nm = cn.product_nm
    group by 1, 2, 3, 4, 5, 6, 7, 8
    




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
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select cnt_id_nk
from __dbt__cte__int_products__unified
where cnt_id_nk is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:32.011233+00:00
-- finished_at: 2026-08-01T17:29:38.716867+00:00
-- elapsed: 6.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_products__unified_lob_nm.1c72e7adf1
-- query_id: 01f18dce-8ea5-1f9a-b9dc-572db7f265e3
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
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- filter was commented out. One branch driven by a seed replaces all three.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contract_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        cp.producer_cnt_role_nm,
        rl.preferred_producer_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
    left join roles rl
        on  rl.lob_nm = cn.lob_nm
    




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
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- role filter. Seed-driven single branch here.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        rl.preferred_producer_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
    left join roles rl
        on rl.lob_nm = cn.product_nm
    group by 1, 2, 3, 4, 5, 6, 7, 8
    




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
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select lob_nm
from __dbt__cte__int_products__unified
where lob_nm is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:32.011233+00:00
-- finished_at: 2026-08-01T17:29:39.936581+00:00
-- elapsed: 7.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_int_products__unified_cnt_id_nk__cnt_iss_cd_nk__plan_cd__producer_id_nk.65992b2589
-- query_id: 01f18dce-8ea6-1c1b-b693-4eb7c349f1cc
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
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- filter was commented out. One branch driven by a seed replaces all three.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contract_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        cp.producer_cnt_role_nm,
        rl.preferred_producer_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
    left join roles rl
        on  rl.lob_nm = cn.lob_nm
    




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
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- role filter. Seed-driven single branch here.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        rl.preferred_producer_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
    left join roles rl
        on rl.lob_nm = cn.product_nm
    group by 1, 2, 3, 4, 5, 6, 7, 8
    




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
-- created_at: 2026-08-01T17:29:39.947241+00:00
-- finished_at: 2026-08-01T17:29:40.476488+00:00
-- elapsed: 529ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_stg_cnt_prd_mapping_cnt_id_nk.e69ce8916d
-- query_id: 01f18dce-9361-10c3-8cb9-da21d28048ab
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_stg_cnt_prd_mapping_cnt_id_nk.e69ce8916d", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cnt_id_nk
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
where cnt_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:39.947386+00:00
-- finished_at: 2026-08-01T17:29:40.478730+00:00
-- elapsed: 531ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_stg_cnt_prd_mapping_product_type.737d47a660
-- query_id: 01f18dce-9361-1193-8b8c-99968ee1af35
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_stg_cnt_prd_mapping_product_type.737d47a660", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select product_type
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
where product_type is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:39.947175+00:00
-- finished_at: 2026-08-01T17:29:40.578856+00:00
-- elapsed: 631ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_stg_cnt_prd_mapping_lob_nm__LIFE_INSURANCE__ANNUITIES__LONG_TERM_CARE__IDI__EAGLE__NYLIFE_SEC__MAINSTAY__NP_MUTFNDS__NP529.70084f5ef8
-- query_id: 01f18dce-9360-1f01-8926-bcb4789eea7f
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

    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
    group by lob_nm

)

select *
from all_values
where value_field not in (
    'LIFE INSURANCE','ANNUITIES','LONG TERM CARE','IDI','EAGLE','NYLIFE SEC','MAINSTAY','NP MUTFNDS','NP529'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:39.947434+00:00
-- finished_at: 2026-08-01T17:29:40.603545+00:00
-- elapsed: 656ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_ppg_stg_cnt_prd_mapping_snapshot_date__cnt_id_nk__cnt_iss_cd_nk__producer_id_nk.b3cbb8e05e
-- query_id: 01f18dce-9361-19da-acba-7e7ad88bc58c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_ppg_stg_cnt_prd_mapping_snapshot_date__cnt_id_nk__cnt_iss_cd_nk__producer_id_nk.b3cbb8e05e", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        snapshot_date, cnt_id_nk, cnt_iss_cd_nk, producer_id_nk
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
    group by snapshot_date, cnt_id_nk, cnt_iss_cd_nk, producer_id_nk
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:39.947175+00:00
-- finished_at: 2026-08-01T17:29:40.621110+00:00
-- elapsed: 673ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_stg_cnt_prd_mapping_product_category_risk_wm__Risk_Management__Wealth_Management.c79001efa7
-- query_id: 01f18dce-9361-14ac-8fa7-e0e99368028c
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

    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
    group by product_category_risk_wm

)

select *
from all_values
where value_field not in (
    'Risk Management','Wealth Management'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:39.947380+00:00
-- finished_at: 2026-08-01T17:29:40.643132+00:00
-- elapsed: 695ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_stg_cnt_prd_mapping_snapshot_date.36b7ea03db
-- query_id: 01f18dce-9361-13fb-bcac-2f6af4ba9c2c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_stg_cnt_prd_mapping_snapshot_date.36b7ea03db", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select snapshot_date
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
where snapshot_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.647880+00:00
-- finished_at: 2026-08-01T17:29:41.350702+00:00
-- elapsed: 702ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_dtl_cnt_id_nk.105b43126c
-- query_id: 01f18dce-93cc-1a85-8f85-047a4f664391
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_dtl_cnt_id_nk.105b43126c", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cnt_id_nk
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
where cnt_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.649062+00:00
-- finished_at: 2026-08-01T17:29:41.416640+00:00
-- elapsed: 767ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_monthly_primry_ownr_cl_id.13f705ab85
-- query_id: 01f18dce-93cc-1a8b-ba4e-0f674937ba9b
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_monthly_primry_ownr_cl_id.13f705ab85", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_monthly`
where primry_ownr_cl_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648664+00:00
-- finished_at: 2026-08-01T17:29:41.422967+00:00
-- elapsed: 774ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_ppg_metrics_dtl_month_end_date__cnt_id_nk__cnt_iss_cd_nk__producer_id_nk.fc184e527d
-- query_id: 01f18dce-93cc-1c90-a8dd-bbf0ab47eaa6
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
    group by month_end_date, cnt_id_nk, cnt_iss_cd_nk, producer_id_nk
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648435+00:00
-- finished_at: 2026-08-01T17:29:41.441666+00:00
-- elapsed: 793ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_dtl_primry_ownr_cl_id.fcffb2d777
-- query_id: 01f18dce-93cc-17b4-88e5-4afdb1126788
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_dtl_primry_ownr_cl_id.fcffb2d777", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
where primry_ownr_cl_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648683+00:00
-- finished_at: 2026-08-01T17:29:41.442383+00:00
-- elapsed: 793ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_dtl_gm_or_fp_flag__Y__N.1a6d203954
-- query_id: 01f18dce-93cc-1985-b36c-5139931f5a5a
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

    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
    group by gm_or_fp_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.647836+00:00
-- finished_at: 2026-08-01T17:29:41.453178+00:00
-- elapsed: 805ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_dtl_month_end_date.412592d599
-- query_id: 01f18dce-93cc-18ef-81da-f0b619dfc555
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_dtl_month_end_date.412592d599", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648917+00:00
-- finished_at: 2026-08-01T17:29:41.464094+00:00
-- elapsed: 815ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_dtl_fp_flag__Y__N.fbbae0396d
-- query_id: 01f18dce-93cc-1f91-a879-687dcdb21375
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

    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
    group by fp_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648276+00:00
-- finished_at: 2026-08-01T17:29:41.475173+00:00
-- elapsed: 826ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_ppg_metrics_monthly_month_end_date__cnt_id_nk__producer_id_nk.17aec53a17
-- query_id: 01f18dce-93cc-19e0-a736-4c9c4b76b784
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_monthly`
    group by month_end_date, cnt_id_nk, producer_id_nk
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.647322+00:00
-- finished_at: 2026-08-01T17:29:41.515715+00:00
-- elapsed: 868ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_monthly_gm_or_fp_flag__Y__N.f9d5d38f1f
-- query_id: 01f18dce-93cc-15d3-a9b9-bf6641f84efb
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

    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_monthly`
    group by gm_or_fp_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648014+00:00
-- finished_at: 2026-08-01T17:29:42.273555+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.accepted_values_ppg_metrics_dtl_gm_flag__Y__N.150a00fd7d
-- query_id: 01f18dce-93cc-1ae2-af48-e311d247665c
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

    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
    group by gm_flag

)

select *
from all_values
where value_field not in (
    'Y','N'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648364+00:00
-- finished_at: 2026-08-01T17:29:42.326770+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_expression_is_true_ppg_metrics_dtl_not_risk_management_ind_N_and_wealth_management_ind_N_.8af42a2ee4
-- query_id: 01f18dce-93cc-1d7e-838c-99c6b836d1ad
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_expression_is_true_ppg_metrics_dtl_not_risk_management_ind_N_and_wealth_management_ind_N_.8af42a2ee4", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`

where not(not (risk_management_ind = 'N' and wealth_management_ind = 'N'))


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648649+00:00
-- finished_at: 2026-08-01T17:29:42.355336+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_monthly_cnt_id_nk.dce8f255af
-- query_id: 01f18dce-93cf-1801-9f2e-9e002be3a1d8
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_monthly_cnt_id_nk.dce8f255af", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select cnt_id_nk
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_monthly`
where cnt_id_nk is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.647481+00:00
-- finished_at: 2026-08-01T17:29:42.382769+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_monthly_month_end_date.b741eb0a07
-- query_id: 01f18dce-93d1-1950-8405-a348be89aa76
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_monthly_month_end_date.b741eb0a07", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_monthly`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.652855+00:00
-- finished_at: 2026-08-01T17:29:42.543386+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_metrics__base_all_month_end_date.573e70ccc7
-- query_id: 01f18dce-93cc-1dbf-ba7e-b4e6d399de5a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_metrics__base_all_month_end_date.573e70ccc7", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_metrics__base_all as (
-- Original CTE: base_all
--
-- ⚠ BEHAVIOUR CHANGE FORCED BY THE CELL 1 REFACTOR ⚠
-- The original read ppg_stg_cnt_prd_mapping unfiltered, which was safe only
-- because cell 1 did `create or replace` and the table held exactly one
-- snapshot. ppg_stg_cnt_prd_mapping is now incremental and retains history, so
-- reading it unfiltered would multiply every metric by the number of snapshots
-- retained. The snapshot_date filter below is mandatory, not optional.
with mapping as (
    select *
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
    where snapshot_date = current_date
),

dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    mapp.snapshot_date,
    dt.ytd_end_dt          as month_end_date,
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
    on mapp.cnt_eff_dt <= dt.ytd_end_dt
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select month_end_date
from __dbt__cte__int_metrics__base_all
where month_end_date is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.652854+00:00
-- finished_at: 2026-08-01T17:29:42.544081+00:00
-- elapsed: 1.9s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_metrics__base_all_primry_ownr_cl_id.9ebb91c56b
-- query_id: 01f18dce-93cc-1df0-8827-354317d4cdd6
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_metrics__base_all_primry_ownr_cl_id.9ebb91c56b", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  with __dbt__cte__int_metrics__base_all as (
-- Original CTE: base_all
--
-- ⚠ BEHAVIOUR CHANGE FORCED BY THE CELL 1 REFACTOR ⚠
-- The original read ppg_stg_cnt_prd_mapping unfiltered, which was safe only
-- because cell 1 did `create or replace` and the table held exactly one
-- snapshot. ppg_stg_cnt_prd_mapping is now incremental and retains history, so
-- reading it unfiltered would multiply every metric by the number of snapshots
-- retained. The snapshot_date filter below is mandatory, not optional.
with mapping as (
    select *
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_stg_cnt_prd_mapping`
    where snapshot_date = current_date
),

dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    mapp.snapshot_date,
    dt.ytd_end_dt          as month_end_date,
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
    on mapp.cnt_eff_dt <= dt.ytd_end_dt
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select primry_ownr_cl_id
from __dbt__cte__int_metrics__base_all
where primry_ownr_cl_id is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:40.648699+00:00
-- finished_at: 2026-08-01T17:29:42.678083+00:00
-- elapsed: 2.0s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_equal_rowcount_ppg_metrics_monthly_ref_ppg_metrics_dtl_.832da2b0ab
-- query_id: 01f18dce-93cc-1964-8ac6-def9f9a94813
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_monthly`
    group by id_dbtutils_test_equal_rowcount


),
b as (

    select 
      
      1 as id_dbtutils_test_equal_rowcount,
      count(*) as count_b 
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl`
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
-- created_at: 2026-08-01T17:29:42.334645+00:00
-- finished_at: 2026-08-01T17:29:43.225361+00:00
-- elapsed: 890ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_int_summ__active_clients_month_end_date__primry_ownr_cl_id.530e9ac596
-- query_id: 01f18dce-94cc-1e6f-add0-27b28c2e573c
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_int_summ__active_clients_month_end_date__primry_ownr_cl_id.530e9ac596", "profile_name": "ppg", "target_name": "dev"} */
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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.ytd_end_dt
where dtl.cnt_eff_dt between cast(add_months(dtl.month_end_date, -60) + 1 as date)
                         and dtl.month_end_date
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (






with validation_errors as (

    select
        month_end_date, primry_ownr_cl_id
    from __dbt__cte__int_summ__active_clients
    group by month_end_date, primry_ownr_cl_id
    having count(*) > 1

)

select *
from validation_errors



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:42.338649+00:00
-- finished_at: 2026-08-01T17:29:43.225366+00:00
-- elapsed: 886ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_summ__sales_total_sales.1cfa87c36e
-- query_id: 01f18dce-94cd-1b9a-8fe1-e68ad0c83c86
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_summ__sales_total_sales.1cfa87c36e", "profile_name": "ppg", "target_name": "dev"} */
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
-- which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and ytd_end_dt`
-- but wraps the column in YEAR(), so it cannot prune partitions. `ytd_begin_dt`
-- was already being computed in the dates CTE of all three cells and never used
-- anywhere -- presumably this is what it was for. Using the sargable form.
with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
),

ytd_sales as (
    select dtl.*
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
    inner join dates dt
        on dtl.month_end_date = dt.ytd_end_dt
    where dtl.cnt_eff_dt >= dt.ytd_begin_dt
      and dtl.cnt_eff_dt <= dt.ytd_end_dt
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

    
    



select total_sales
from __dbt__cte__int_summ__sales
where total_sales is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:42.338649+00:00
-- finished_at: 2026-08-01T17:29:43.249120+00:00
-- elapsed: 910ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_summ__sales_month_end_date.f99f7b0427
-- query_id: 01f18dce-94ce-11eb-879b-944a17c1ce6b
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_summ__sales_month_end_date.f99f7b0427", "profile_name": "ppg", "target_name": "dev"} */
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
-- which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and ytd_end_dt`
-- but wraps the column in YEAR(), so it cannot prune partitions. `ytd_begin_dt`
-- was already being computed in the dates CTE of all three cells and never used
-- anywhere -- presumably this is what it was for. Using the sargable form.
with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
),

ytd_sales as (
    select dtl.*
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
    inner join dates dt
        on dtl.month_end_date = dt.ytd_end_dt
    where dtl.cnt_eff_dt >= dt.ytd_begin_dt
      and dtl.cnt_eff_dt <= dt.ytd_end_dt
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

    
    



select month_end_date
from __dbt__cte__int_summ__sales
where month_end_date is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:42.338672+00:00
-- finished_at: 2026-08-01T17:29:43.256379+00:00
-- elapsed: 917ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_summ__sales_month_end_date.c5b6e2f47b
-- query_id: 01f18dce-94cd-1956-9e3e-48ca169e1313
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_summ__sales_month_end_date.c5b6e2f47b", "profile_name": "ppg", "target_name": "dev"} */
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
-- which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and ytd_end_dt`
-- but wraps the column in YEAR(), so it cannot prune partitions. `ytd_begin_dt`
-- was already being computed in the dates CTE of all three cells and never used
-- anywhere -- presumably this is what it was for. Using the sargable form.
with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
),

ytd_sales as (
    select dtl.*
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
    inner join dates dt
        on dtl.month_end_date = dt.ytd_end_dt
    where dtl.cnt_eff_dt >= dt.ytd_begin_dt
      and dtl.cnt_eff_dt <= dt.ytd_end_dt
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

    
    

select
    month_end_date as unique_field,
    count(*) as n_records

from __dbt__cte__int_summ__sales
where month_end_date is not null
group by month_end_date
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:43.238554+00:00
-- finished_at: 2026-08-01T17:29:43.816536+00:00
-- elapsed: 577ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_unique_combination_of_columns_int_summ__client_breadth_depth_month_end_date__primry_ownr_cl_id.87d988df21
-- query_id: 01f18dce-9557-1441-bdab-9b878cee537a
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_unique_combination_of_columns_int_summ__client_breadth_depth_month_end_date__primry_ownr_cl_id.87d988df21", "profile_name": "ppg", "target_name": "dev"} */
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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.ytd_end_dt
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
-- types that collapse are in var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.ytd_end_dt
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






with validation_errors as (

    select
        month_end_date, primry_ownr_cl_id
    from __dbt__cte__int_summ__client_breadth_depth
    group by month_end_date, primry_ownr_cl_id
    having count(*) > 1

)

select *
from validation_errors



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:39.957973+00:00
-- finished_at: 2026-08-01T17:29:44.157551+00:00
-- elapsed: 4.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_products__categorized_product_type.11079a5848
-- query_id: 01f18dce-9362-14d3-92ff-0dfd18f28100
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
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contracts`
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
), __dbt__cte__int_owners__by_contract as (
-- Original CTE: core_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- filter was commented out. One branch driven by a seed replaces all three.
with contracts as (
    select * from __dbt__cte__int_contracts__scoped
),

owners as (
    select * from __dbt__cte__int_owners__by_contract
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__contract_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        cp.producer_cnt_role_nm,
        rl.preferred_producer_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
    left join roles rl
        on  rl.lob_nm = cn.lob_nm
    




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
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__primary_owner_derv`
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
-- role filter. Seed-driven single branch here.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__invest_account_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`lob_producer_role`
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
        rl.preferred_producer_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
    left join roles rl
        on rl.lob_nm = cn.product_nm
    group by 1, 2, 3, 4, 5, 6, 7, 8
    




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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__products`
),

map as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_seeds`.`product_category_map`
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
-- created_at: 2026-08-01T17:29:42.338783+00:00
-- finished_at: 2026-08-01T17:29:44.531208+00:00
-- elapsed: 2.2s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_int_summ__sales_total_sales__True__1.73ccad30fc
-- query_id: 01f18dce-94ce-1110-8904-182af8d04f16
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
-- which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and ytd_end_dt`
-- but wraps the column in YEAR(), so it cannot prune partitions. `ytd_begin_dt`
-- was already being computed in the dates CTE of all three cells and never used
-- anywhere -- presumably this is what it was for. Using the sargable form.
with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
),

ytd_sales as (
    select dtl.*
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
    inner join dates dt
        on dtl.month_end_date = dt.ytd_end_dt
    where dtl.cnt_eff_dt >= dt.ytd_begin_dt
      and dtl.cnt_eff_dt <= dt.ytd_end_dt
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
-- created_at: 2026-08-01T17:29:43.238545+00:00
-- finished_at: 2026-08-01T17:29:44.947507+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_int_summ__client_breadth_depth_breadth_count__True__1.459009bbbb
-- query_id: 01f18dce-9557-1602-abf3-227d1e6cfc6d
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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.ytd_end_dt
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
-- types that collapse are in var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.ytd_end_dt
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
-- created_at: 2026-08-01T17:29:43.238559+00:00
-- finished_at: 2026-08-01T17:29:44.975757+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_int_summ__client_breadth_depth_depth_count__True__1.285881e4cf
-- query_id: 01f18dce-9557-121d-9710-1ae97ce233d0
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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.ytd_end_dt
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
-- types that collapse are in var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.ytd_end_dt
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
-- created_at: 2026-08-01T17:29:44.981680+00:00
-- finished_at: 2026-08-01T17:29:45.576915+00:00
-- elapsed: 595ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_fb_led_sales__True__100__0.f5d8537f89
-- query_id: 01f18dce-9662-17ce-b839-14f5d47e85d7
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_fb_led_sales__True__100__0.f5d8537f89", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
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
-- created_at: 2026-08-01T17:29:44.981515+00:00
-- finished_at: 2026-08-01T17:29:45.612059+00:00
-- elapsed: 630ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_depth__True__1.c6de04b8cc
-- query_id: 01f18dce-9661-1ce3-b39f-2bf5d8569e4f
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_depth__True__1.c6de04b8cc", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
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
-- created_at: 2026-08-01T17:29:44.983098+00:00
-- finished_at: 2026-08-01T17:29:45.639989+00:00
-- elapsed: 656ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_breadth__True__1.b6dded3a75
-- query_id: 01f18dce-9662-193e-bbb6-9da219ecf232
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_multi_product_breadth__True__1.b6dded3a75", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
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
-- created_at: 2026-08-01T17:29:44.982680+00:00
-- finished_at: 2026-08-01T17:29:45.653523+00:00
-- elapsed: 670ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_summ_monthly_month_end_date.305b9b6d30
-- query_id: 01f18dce-9662-168c-997b-2aebbd73b42d
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_summ_monthly_month_end_date.305b9b6d30", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select month_end_date
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
where month_end_date is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.980745+00:00
-- finished_at: 2026-08-01T17:29:45.680373+00:00
-- elapsed: 699ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_gm_led_sales__True__100__0.eb1d3d87eb
-- query_id: 01f18dce-9661-10eb-a160-db6c3a0613ac
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_gm_led_sales__True__100__0.eb1d3d87eb", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
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
-- created_at: 2026-08-01T17:29:44.981874+00:00
-- finished_at: 2026-08-01T17:29:45.727018+00:00
-- elapsed: 745ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_depth_val_breadth_val.6773b60a8f
-- query_id: 01f18dce-9662-118e-b9b4-f732a81f17fe
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_depth_val_breadth_val.6773b60a8f", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`

where not(depth_val >= breadth_val)


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.982644+00:00
-- finished_at: 2026-08-01T17:29:45.734918+00:00
-- elapsed: 752ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_plan_sales_total_sales.60d14dc3d1
-- query_id: 01f18dce-9662-139b-8a99-37176b059d14
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_expression_is_true_ppg_metrics_summ_monthly_plan_sales_total_sales.60d14dc3d1", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`

where not(plan_sales <= total_sales)


  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.983345+00:00
-- finished_at: 2026-08-01T17:29:45.801468+00:00
-- elapsed: 818ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_ppg_metrics_summ_monthly_month_end_date.f6d3aec00d
-- query_id: 01f18dce-9662-16f7-bb2c-01eddb3749b2
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

from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
where month_end_date is not null
group by month_end_date
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.987382+00:00
-- finished_at: 2026-08-01T17:29:45.833152+00:00
-- elapsed: 845ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.unique_int_summ__breadth_depth_month_end_date.1ecb95d38f
-- query_id: 01f18dce-9662-17e2-8399-15162f15bb70
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.unique_int_summ__breadth_depth_month_end_date.1ecb95d38f", "profile_name": "ppg", "target_name": "dev"} */
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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.ytd_end_dt
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
-- types that collapse are in var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.ytd_end_dt
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
select
    month_end_date,
    sum(breadth_count)                  as breadth_val,
    sum(depth_count)                    as depth_val,
    count(distinct primry_ownr_cl_id)   as denominator
from __dbt__cte__int_summ__client_breadth_depth
group by 1
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    

select
    month_end_date as unique_field,
    count(*) as n_records

from __dbt__cte__int_summ__breadth_depth
where month_end_date is not null
group by month_end_date
having count(*) > 1



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.985437+00:00
-- finished_at: 2026-08-01T17:29:45.861784+00:00
-- elapsed: 876ms
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_summ__breadth_depth_denominator.8931622c77
-- query_id: 01f18dce-9662-14e0-95b0-c4942b857130
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_summ__breadth_depth_denominator.8931622c77", "profile_name": "ppg", "target_name": "dev"} */
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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.ytd_end_dt
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
-- types that collapse are in var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.ytd_end_dt
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
select
    month_end_date,
    sum(breadth_count)                  as breadth_val,
    sum(depth_count)                    as depth_val,
    count(distinct primry_ownr_cl_id)   as denominator
from __dbt__cte__int_summ__client_breadth_depth
group by 1
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select denominator
from __dbt__cte__int_summ__breadth_depth
where denominator is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.980926+00:00
-- finished_at: 2026-08-01T17:29:46.545183+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_summ_monthly_total_sales.7c176c86bc
-- query_id: 01f18dce-9661-1d8d-8f79-cc557968ca70
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_summ_monthly_total_sales.7c176c86bc", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_sales
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
where total_sales is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.983484+00:00
-- finished_at: 2026-08-01T17:29:46.598662+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_ppg_metrics_summ_monthly_plan_sales.46ad626fd4
-- query_id: 01f18dce-9662-1e1a-9e69-10baf405a7df
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_ppg_metrics_summ_monthly_plan_sales.46ad626fd4", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select plan_sales
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
where plan_sales is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-08-01T17:29:44.983430+00:00
-- finished_at: 2026-08-01T17:29:46.610239+00:00
-- elapsed: 1.6s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_ppg_sales__True__100__0.b0e462b736
-- query_id: 01f18dce-9662-15fb-9b4c-b89845c572e3
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.dbt_utils_accepted_range_ppg_metrics_summ_monthly_ppg_sales__True__100__0.b0e462b736", "profile_name": "ppg", "target_name": "dev"} */
select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  

with meet_condition as(
  select *
  from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_summ_monthly`
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
-- created_at: 2026-08-01T17:29:44.986892+00:00
-- finished_at: 2026-08-01T17:29:46.675539+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: test.ppg.not_null_int_summ__breadth_depth_month_end_date.2be87410da
-- query_id: 01f18dce-9662-1836-90e9-34de6a9a1e71
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.ppg.not_null_int_summ__breadth_depth_month_end_date.2be87410da", "profile_name": "ppg", "target_name": "dev"} */
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
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` dtl
inner join dates dt
    on dtl.month_end_date = dt.ytd_end_dt
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
-- types that collapse are in var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.


with dates as (
    select * from `dbt-dev-catalog`.`dbt_silver_schema_staging`.`stg_pdm__ytd_dates`
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
    from `dbt-dev-catalog`.`dbt_silver_schema_ppg`.`ppg_metrics_dtl` ppg
    inner join dates dt
        on ppg.month_end_date = dt.ytd_end_dt
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
select
    month_end_date,
    sum(breadth_count)                  as breadth_val,
    sum(depth_count)                    as depth_val,
    count(distinct primry_ownr_cl_id)   as denominator
from __dbt__cte__int_summ__client_breadth_depth
group by 1
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (

    
    



select month_end_date
from __dbt__cte__int_summ__breadth_depth
where month_end_date is null



--EPHEMERAL-SELECT-WRAPPER-END
)
  
  
      
    ) dbt_internal_test;
