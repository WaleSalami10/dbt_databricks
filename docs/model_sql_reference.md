# dbt Model SQL Reference

_Generated 2026-08-11 from `dbt compile` (dbt 1.11.12, dbt-databricks 1.12.2, target `dev`)._

For every model in this project this document shows two things:

- **Model SQL** — the source file as written in [models/](../models/), Jinja and all.
- **Compiled SQL** — what dbt renders after resolving `ref()`, `source()`, macros, and vars. This is the SQL actually sent to Databricks.

Ephemeral models have no object in the warehouse; their compiled SQL is inlined as a CTE into every downstream model that references them.

## Model index

| Model | Layer | Materialization | Depends on | Feeds |
|---|---|---|---|---|
| [`stg_crm__sf_account`](#stg_crm__sf_account) | Staging | view | `crm.sf_account` | `int_planning__gm_clients` |
| [`stg_digital__gm_plan_dates`](#stg_digital__gm_plan_dates) | Staging | view | `digital.mt__gm_ppg_plan_dates` | `int_planning__gm_clients` |
| [`stg_fx__feebased_fp_plans`](#stg_fx__feebased_fp_plans) | Staging | view | `fx_test.ppg_feebased_fp_plans_by_agent` | `int_planning__fp_clients` |
| [`stg_metrics__policy_owner`](#stg_metrics__policy_owner) | Staging | view | `metrics_marketplace.rpt_fct_mk_cnt_cmpnt_po_all` | `int_clients__active_eop` |
| [`stg_pdm__contract_producer`](#stg_pdm__contract_producer) | Staging | view | `pdm.fact_contract_cmpnt_producer` | `int_contracts__with_producer` |
| [`stg_pdm__contracts`](#stg_pdm__contracts) | Staging | view | `pdm.dim_contract` | `int_contracts__scoped` |
| [`stg_pdm__dates`](#stg_pdm__dates) | Staging | view | `pdm.dim_date` | `int_clients__active_eop`, `int_metrics__base_all`, `int_summ__active_clients`, `int_summ__client_breadth_depth`, `int_summ__sales`, `ppg_metrics_monthly`, `ppg_stg_cnt_prd_mapping` |
| [`stg_pdm__invest_account`](#stg_pdm__invest_account) | Staging | view | `pdm.dim_invest_account` | `int_wm_accounts` |
| [`stg_pdm__invest_account_producer`](#stg_pdm__invest_account_producer) | Staging | view | `pdm.fact_invest_account_producer_role` | `int_wm_accounts__with_producer` |
| [`stg_pdm__invest_account_sub_account`](#stg_pdm__invest_account_sub_account) | Staging | view | `pdm.fact_invest_account_sub_account` | `int_wm_accounts` |
| [`stg_pdm__invest_sub_account`](#stg_pdm__invest_sub_account) | Staging | view | `pdm.dim_invest_sub_account` | `int_wm_accounts` |
| [`stg_pdm__primary_owner_derv`](#stg_pdm__primary_owner_derv) | Staging | view | `pdm.fact_primary_owner_derv` | `int_owners__by_contract`, `int_owners__by_invest_acct` |
| [`stg_pdm__products`](#stg_pdm__products) | Staging | view | `pdm.dim_product` | `int_products__categorized` |
| [`int_clients__active_eop`](#int_clients__active_eop) | Intermediate | ephemeral | `stg_metrics__policy_owner`, `stg_pdm__dates` | `ppg_metrics_dtl` |
| [`int_clients__planning_flags`](#int_clients__planning_flags) | Intermediate | ephemeral | `int_planning__gm_clients`, `int_planning__fp_clients` | `ppg_metrics_dtl` |
| [`int_contracts__scoped`](#int_contracts__scoped) | Intermediate | ephemeral | `stg_pdm__contracts` | `int_contracts__with_producer` |
| [`int_contracts__with_producer`](#int_contracts__with_producer) | Intermediate | ephemeral | `int_contracts__scoped`, `int_owners__by_contract`, `stg_pdm__contract_producer` | `int_products__unified` |
| [`int_metrics__base_all`](#int_metrics__base_all) | Intermediate | ephemeral | `ppg_stg_cnt_prd_mapping`, `stg_pdm__dates` | `ppg_metrics_dtl` |
| [`int_owners__by_contract`](#int_owners__by_contract) | Intermediate | ephemeral | `stg_pdm__primary_owner_derv` | `int_contracts__with_producer` |
| [`int_owners__by_invest_acct`](#int_owners__by_invest_acct) | Intermediate | ephemeral | `stg_pdm__primary_owner_derv` | `int_wm_accounts__with_producer` |
| [`int_planning__fp_clients`](#int_planning__fp_clients) | Intermediate | ephemeral | `stg_fx__feebased_fp_plans` | `int_clients__planning_flags` |
| [`int_planning__gm_clients`](#int_planning__gm_clients) | Intermediate | ephemeral | `stg_digital__gm_plan_dates`, `stg_crm__sf_account` | `int_clients__planning_flags` |
| [`int_products__categorized`](#int_products__categorized) | Intermediate | ephemeral | `int_products__unified`, `stg_pdm__products`, `product_category_map` | `ppg_stg_cnt_prd_mapping` |
| [`int_products__unified`](#int_products__unified) | Intermediate | ephemeral | `int_contracts__with_producer`, `int_wm_accounts__with_producer` | `int_products__categorized` |
| [`int_summ__active_clients`](#int_summ__active_clients) | Intermediate | ephemeral | `stg_pdm__dates`, `ppg_metrics_dtl` | `int_summ__client_breadth_depth` |
| [`int_summ__breadth_depth`](#int_summ__breadth_depth) | Intermediate | ephemeral | `int_summ__client_breadth_depth` | `ppg_metrics_summ_monthly` |
| [`int_summ__client_breadth_depth`](#int_summ__client_breadth_depth) | Intermediate | ephemeral | `stg_pdm__dates`, `int_summ__active_clients`, `ppg_metrics_dtl` | `int_summ__breadth_depth` |
| [`int_summ__sales`](#int_summ__sales) | Intermediate | ephemeral | `stg_pdm__dates`, `ppg_metrics_dtl` | `ppg_metrics_summ_monthly` |
| [`int_wm_accounts`](#int_wm_accounts) | Intermediate | ephemeral | `stg_pdm__invest_sub_account`, `stg_pdm__invest_account_sub_account`, `stg_pdm__invest_account` | `int_wm_accounts__with_producer` |
| [`int_wm_accounts__with_producer`](#int_wm_accounts__with_producer) | Intermediate | ephemeral | `int_wm_accounts`, `int_owners__by_invest_acct`, `stg_pdm__invest_account_producer` | `int_products__unified` |
| [`ppg_metrics_dtl`](#ppg_metrics_dtl) | Marts | incremental | `int_metrics__base_all`, `int_clients__active_eop`, `int_clients__planning_flags` | `int_summ__active_clients`, `int_summ__client_breadth_depth`, `int_summ__sales`, `ppg_metrics_monthly` |
| [`ppg_metrics_monthly`](#ppg_metrics_monthly) | Marts | incremental | `ppg_metrics_dtl`, `stg_pdm__dates` | — (terminal) |
| [`ppg_metrics_summ_monthly`](#ppg_metrics_summ_monthly) | Marts | incremental | `int_summ__sales`, `int_summ__breadth_depth` | — (terminal) |
| [`ppg_stg_cnt_prd_mapping`](#ppg_stg_cnt_prd_mapping) | Marts | incremental | `int_products__categorized`, `stg_pdm__dates` | `int_metrics__base_all` |

## Staging layer

### stg_crm__sf_account

**File:** [models/staging/stg_crm__sf_account.sql](../models/staging/stg_crm__sf_account.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_crm__sf_account`

**Upstream:** `crm.sf_account`

**Downstream:** `int_planning__gm_clients`

#### Model SQL

```sql
-- Salesforce account -> CASE client id crosswalk.
-- The original applied `case_cl_id is not null and case_cl_id <> ''` inside the
-- ON clause of an inner join, which is a WHERE in disguise. Made explicit here
-- so it is applied once rather than in each of the three places the subquery
-- was pasted.

with sf_account as ( 
select distinct
    acct_id_nk,
    case_cl_id
from {{ source('crm', 'sf_account') }}
where case_cl_id is not null
  and case_cl_id <> ''
  )
  
select * from sf_account
```

#### Compiled SQL

```sql
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
```

### stg_digital__gm_plan_dates

**File:** [models/staging/stg_digital__gm_plan_dates.sql](../models/staging/stg_digital__gm_plan_dates.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_digital__gm_plan_dates`

**Upstream:** `digital.mt__gm_ppg_plan_dates`

**Downstream:** `int_planning__gm_clients`

#### Model SQL

```sql
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
from {{ source('digital', 'mt__gm_ppg_plan_dates') }}
)

select * from gm_plan_dates
```

#### Compiled SQL

```sql
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
```

### stg_fx__feebased_fp_plans

**File:** [models/staging/stg_fx__feebased_fp_plans.sql](../models/staging/stg_fx__feebased_fp_plans.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_fx__feebased_fp_plans`

**Upstream:** `fx_test.ppg_feebased_fp_plans_by_agent`

**Downstream:** `int_planning__fp_clients`

#### Model SQL

```sql
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
from {{ source('fx_test', 'ppg_feebased_fp_plans_by_agent') }}
)
select * from feebased_fp_plans
```

#### Compiled SQL

```sql
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
```

### stg_metrics__policy_owner

**File:** [models/staging/stg_metrics__policy_owner.sql](../models/staging/stg_metrics__policy_owner.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_metrics__policy_owner`

**Upstream:** `metrics_marketplace.rpt_fct_mk_cnt_cmpnt_po_all`

**Downstream:** `int_clients__active_eop`

#### Model SQL

```sql
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
from {{ source('metrics_marketplace', 'rpt_fct_mk_cnt_cmpnt_po_all') }}
where dim_po_status_sk in (1, 2, 3)
)
select * from policy_owner
```

#### Compiled SQL

```sql
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
```

### stg_pdm__contract_producer

**File:** [models/staging/stg_pdm__contract_producer.sql](../models/staging/stg_pdm__contract_producer.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__contract_producer`

**Upstream:** `pdm.fact_contract_cmpnt_producer`

**Downstream:** `int_contracts__with_producer`

#### Model SQL

```sql
with contract_producer as (
select
    cnt_id_nk,
    cnt_iss_cd_nk,
    producer_id_nk,
    trim(producer_cnt_role_nm) as producer_cnt_role_nm
from {{ source('pdm', 'fact_contract_cmpnt_producer') }}
where {{ pdm_as_of() }}
)

select*
from contract_producer
```

#### Compiled SQL

```sql
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
```

### stg_pdm__contracts

**File:** [models/staging/stg_pdm__contracts.sql](../models/staging/stg_pdm__contracts.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__contracts`  

PDM contracts resolved to a single version per key as of the reporting month. The uniqueness test below is the build-time check on the as-of predicate itself.

**Upstream:** `pdm.dim_contract`

**Downstream:** `int_contracts__scoped`

#### Model SQL

```sql
with contracts as (
select
    cnt_id_nk,
    cnt_iss_cd_nk,
    plan_cd,
    lob_nm,
    cnt_eff_dt
from {{ source('pdm', 'dim_contract') }}
where {{ pdm_as_of() }}
)
select * from contracts
```

#### Compiled SQL

```sql
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
```

### stg_pdm__dates

**File:** [models/staging/stg_pdm__dates.sql](../models/staging/stg_pdm__dates.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__dates`  

The date spine. Exactly one row: the reporting month selected by ppg_var('report_month'). Everything else derives its dates from here.

**Upstream:** `pdm.dim_date`

**Downstream:** `int_clients__active_eop`, `int_metrics__base_all`, `int_summ__active_clients`, `int_summ__client_breadth_depth`, `int_summ__sales`, `ppg_metrics_monthly`, `ppg_stg_cnt_prd_mapping`

#### Model SQL

```sql
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
        {{ pdm_as_of_date() }}                       as snapshot_date,
        mth_end_dt                                   as month_end_date,
        to_date(date_trunc('year', mth_end_dt))      as ytd_begin_dt,
        date_format(mth_end_dt, 'yyyyMMdd')          as month_end_dim_sqn
    from {{ source('pdm', 'dim_date') }}
    where clndr_dt = {{ report_month_anchor() }}
)
select * from dates
```

#### Compiled SQL

```sql
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
```

### stg_pdm__invest_account

**File:** [models/staging/stg_pdm__invest_account.sql](../models/staging/stg_pdm__invest_account.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__invest_account`

**Upstream:** `pdm.dim_invest_account`

**Downstream:** `int_wm_accounts`

#### Model SQL

```sql
with invest_account as (
select
    invest_acct_id_nk,
    invest_acct_cd
from {{ source('pdm', 'dim_invest_account') }}
where {{ pdm_as_of() }}
)
select * from invest_account
```

#### Compiled SQL

```sql
with invest_account as (
select
    invest_acct_id_nk,
    invest_acct_cd
from `prod_execution_rs`.`ext_pdm`.`dim_invest_account`
where edh_record_status_in = 'A'
)
select * from invest_account
```

### stg_pdm__invest_account_producer

**File:** [models/staging/stg_pdm__invest_account_producer.sql](../models/staging/stg_pdm__invest_account_producer.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__invest_account_producer`

**Upstream:** `pdm.fact_invest_account_producer_role`

**Downstream:** `int_wm_accounts__with_producer`

#### Model SQL

```sql
-- NB: the source column really is spelled `prodcuer_role_cd_desc`.
-- Renamed here so the typo stops leaking into every downstream model.
with invest_account_producer as (
select
    invest_acct_id_nk,
    invest_acct_cd,
    producer_id_nk,
    trim(prodcuer_role_cd_desc) as producer_cnt_role_nm
from {{ source('pdm', 'fact_invest_account_producer_role') }}
where {{ pdm_as_of() }}
)
select * from invest_account_producer
```

#### Compiled SQL

```sql
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
```

### stg_pdm__invest_account_sub_account

**File:** [models/staging/stg_pdm__invest_account_sub_account.sql](../models/staging/stg_pdm__invest_account_sub_account.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__invest_account_sub_account`

**Upstream:** `pdm.fact_invest_account_sub_account`

**Downstream:** `int_wm_accounts`

#### Model SQL

```sql
with invest_account_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_acct_id
from {{ source('pdm', 'fact_invest_account_sub_account') }}
where {{ pdm_as_of() }}
)
select * from invest_account_sub_account
```

#### Compiled SQL

```sql
with invest_account_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_acct_id
from `prod_execution_rs`.`ext_pdm`.`fact_invest_account_sub_account`
where edh_record_status_in = 'A'
)
select * from invest_account_sub_account
```

### stg_pdm__invest_sub_account

**File:** [models/staging/stg_pdm__invest_sub_account.sql](../models/staging/stg_pdm__invest_sub_account.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__invest_sub_account`

**Upstream:** `pdm.dim_invest_sub_account`

**Downstream:** `int_wm_accounts`

#### Model SQL

```sql
with invest_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_sub_acct_iss_cd_nk,
    invest_sub_acct_eff_dt,
    plan_cd,
    product_nm
from {{ source('pdm', 'dim_invest_sub_account') }}
where {{ pdm_as_of() }}
  and product_nm in ('EAGLE', 'NYLIFE SEC', 'NP MUTFNDS', 'NP529', 'MAINSTAY')
)
select * from invest_sub_account
```

#### Compiled SQL

```sql
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
```

### stg_pdm__primary_owner_derv

**File:** [models/staging/stg_pdm__primary_owner_derv.sql](../models/staging/stg_pdm__primary_owner_derv.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__primary_owner_derv`

**Upstream:** `pdm.fact_primary_owner_derv`

**Downstream:** `int_owners__by_contract`, `int_owners__by_invest_acct`

#### Model SQL

```sql
with primary_owner_derv as (
select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id,
    primry_ownr_cl_role_eff_dt,
    rec_tp_cd
from {{ source('pdm', 'fact_primary_owner_derv') }}
where {{ pdm_as_of() }}
)
select * from primary_owner_derv
```

#### Compiled SQL

```sql
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
```

### stg_pdm__products

**File:** [models/staging/stg_pdm__products.sql](../models/staging/stg_pdm__products.sql)  
**Materialization:** `view`  
**Relation:** `dbt_dev.dbt_osalami_staging.stg_pdm__products`

**Upstream:** `pdm.dim_product`

**Downstream:** `int_products__categorized`

#### Model SQL

```sql
with products as (
select
    plan_cd_nk,
    product_ln_cd,
    product_grp_nm,
    product_nm
from {{ source('pdm', 'dim_product') }}
where {{ pdm_as_of() }}
)
select * from products
```

#### Compiled SQL

```sql
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
```

## Intermediate layer

### int_clients__active_eop

**File:** [models/intermediate/int_clients__active_eop.sql](../models/intermediate/int_clients__active_eop.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_clients__active_eop`

**Upstream:** `stg_metrics__policy_owner`, `stg_pdm__dates`

**Downstream:** `ppg_metrics_dtl`

#### Model SQL

```sql
-- Original CTE: get_active_cl_eop
-- Clients with an active policy-owner record as of the reporting month end.

with active_cl_eop as (
select distinct
    po.po_client_id_nk,
    dt.month_end_date
from {{ ref('stg_metrics__policy_owner') }} po
inner join {{ ref('stg_pdm__dates') }} dt
    on po.dt_key = dt.month_end_dim_sqn
)
select * from active_cl_eop
```

#### Compiled SQL

```sql
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
```

### int_clients__planning_flags

**File:** [models/intermediate/int_clients__planning_flags.sql](../models/intermediate/int_clients__planning_flags.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_clients__planning_flags`  

One row per client that has any completed plan, GM or fee-based.

**Upstream:** `int_planning__gm_clients`, `int_planning__fp_clients`

**Downstream:** `ppg_metrics_dtl`

#### Model SQL

```sql
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
```

#### Compiled SQL

```sql
-- Original CTEs: clients_with_planning + clients_with_planning_v2
--
-- The original built the union, then LEFT JOINed back to two more copies of the
-- same subqueries purely to work out which side each client came from. That is
-- what a conditional aggregate is for. Four subqueries collapse to two refs.
with  __dbt__cte__int_planning__gm_clients as (
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
),  __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
), gm as (
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
```

### int_contracts__scoped

**File:** [models/intermediate/int_contracts__scoped.sql](../models/intermediate/int_contracts__scoped.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_contracts__scoped`

**Upstream:** `stg_pdm__contracts`

**Downstream:** `int_contracts__with_producer`

#### Model SQL

```sql
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
from {{ ref('stg_pdm__contracts') }}
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
)
select * from scoped_contracts
```

#### Compiled SQL

```sql
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
```

### int_contracts__with_producer

**File:** [models/intermediate/int_contracts__with_producer.sql](../models/intermediate/int_contracts__with_producer.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_contracts__with_producer`

**Upstream:** `int_contracts__scoped`, `int_owners__by_contract`, `stg_pdm__contract_producer`

**Downstream:** `int_products__unified`

#### Model SQL

```sql
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
    select * from {{ ref('int_contracts__scoped') }}
),

owners as (
    select * from {{ ref('int_owners__by_contract') }}
),

producers as (
    select * from {{ ref('stg_pdm__contract_producer') }}
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
```

#### Compiled SQL

```sql
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
with  __dbt__cte__int_contracts__scoped as (
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
),  __dbt__cte__int_owners__by_contract as (
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


), contracts as (
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
```

### int_metrics__base_all

**File:** [models/intermediate/int_metrics__base_all.sql](../models/intermediate/int_metrics__base_all.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_metrics__base_all`  

Mapping rows for the reporting month, restricted to contracts effective on or before the month end. month_end_date and primry_ownr_cl_id are tested on ppg_metrics_dtl, which is built directly from this.

**Upstream:** `ppg_stg_cnt_prd_mapping`, `stg_pdm__dates`

**Downstream:** `ppg_metrics_dtl`

#### Model SQL

```sql
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
    from {{ ref('ppg_stg_cnt_prd_mapping') }}
    where month_end_date = (select month_end_date from {{ ref('stg_pdm__dates') }})
),

dates as (
    select * from {{ ref('stg_pdm__dates') }}
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
```

#### Compiled SQL

```sql
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
```

### int_owners__by_contract

**File:** [models/intermediate/int_owners__by_contract.sql](../models/intermediate/int_owners__by_contract.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_owners__by_contract`  

One primary owner per contract account.

**Upstream:** `stg_pdm__primary_owner_derv`

**Downstream:** `int_contracts__with_producer`

#### Model SQL

```sql
-- Original CTE: core_clients
{{ dedupe_primary_owner(rec_tp_cd='CONTRACT') }}
```

#### Compiled SQL

```sql
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
```

### int_owners__by_invest_acct

**File:** [models/intermediate/int_owners__by_invest_acct.sql](../models/intermediate/int_owners__by_invest_acct.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_owners__by_invest_acct`  

One primary owner per investment account.

**Upstream:** `stg_pdm__primary_owner_derv`

**Downstream:** `int_wm_accounts__with_producer`

#### Model SQL

```sql
-- Original CTE: wm_clients
{{ dedupe_primary_owner(rec_tp_cd='INVEST_ACCT') }}
```

#### Compiled SQL

```sql
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
```

### int_planning__fp_clients

**File:** [models/intermediate/int_planning__fp_clients.sql](../models/intermediate/int_planning__fp_clients.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_planning__fp_clients`

**Upstream:** `stg_fx__feebased_fp_plans`

**Downstream:** `int_clients__planning_flags`

#### Model SQL

```sql
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from {{ ref('stg_fx__feebased_fp_plans') }}
group by 1
)
select * from feebased_fp_clients
```

#### Compiled SQL

```sql
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
```

### int_planning__gm_clients

**File:** [models/intermediate/int_planning__gm_clients.sql](../models/intermediate/int_planning__gm_clients.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_planning__gm_clients`

**Upstream:** `stg_digital__gm_plan_dates`, `stg_crm__sf_account`

**Downstream:** `int_clients__planning_flags`

#### Model SQL

```sql
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
```

#### Compiled SQL

```sql
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
```

### int_products__categorized

**File:** [models/intermediate/int_products__categorized.sql](../models/intermediate/int_products__categorized.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_products__categorized`

**Upstream:** `int_products__unified`, `stg_pdm__products`, `product_category_map`

**Downstream:** `ppg_stg_cnt_prd_mapping`

#### Model SQL

```sql
-- Original CTE: core_wm_client_product
--
-- The four CASE expressions are now a seed lookup. Match on the specific
-- product_nm first; fall back to the '*' wildcard row for that
-- product_ln_cd + product_grp_nm.
with base as (
    select * from {{ ref('int_products__unified') }}
),

products as (
    select * from {{ ref('stg_pdm__products') }}
),

map as (
    select * from {{ ref('product_category_map') }}
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
```

#### Compiled SQL

```sql
-- Original CTE: core_wm_client_product
--
-- The four CASE expressions are now a seed lookup. Match on the specific
-- product_nm first; fall back to the '*' wildcard row for that
-- product_ln_cd + product_grp_nm.
with  __dbt__cte__int_contracts__scoped as (
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
),  __dbt__cte__int_owners__by_contract as (
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


),  __dbt__cte__int_contracts__with_producer as (
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
),  __dbt__cte__int_wm_accounts as (
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
),  __dbt__cte__int_owners__by_invest_acct as (
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


),  __dbt__cte__int_wm_accounts__with_producer as (
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
),  __dbt__cte__int_products__unified as (
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
), base as (
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
```

### int_products__unified

**File:** [models/intermediate/int_products__unified.sql](../models/intermediate/int_products__unified.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_products__unified`  

Shared grain across the insurance and wealth branches. If this test fails, a producer left join has fanned out -- fix the join, do not add a distinct.

**Upstream:** `int_contracts__with_producer`, `int_wm_accounts__with_producer`

**Downstream:** `int_products__categorized`

#### Model SQL

```sql
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
from {{ ref('int_contracts__with_producer') }}

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
from {{ ref('int_wm_accounts__with_producer') }}
)
select * from unified_products
```

#### Compiled SQL

```sql
-- Original CTE: core_wm
--
-- This is the contract between the insurance side and the wealth side. Any
-- column added to one branch must be added to the other. Grain and tests are
-- declared in _intermediate.yml -- test here, not only at the mart.
with  __dbt__cte__int_contracts__scoped as (
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
),  __dbt__cte__int_owners__by_contract as (
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


),  __dbt__cte__int_contracts__with_producer as (
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
),  __dbt__cte__int_wm_accounts as (
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
),  __dbt__cte__int_owners__by_invest_acct as (
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


),  __dbt__cte__int_wm_accounts__with_producer as (
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
), unified_products as (
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
```

### int_summ__active_clients

**File:** [models/intermediate/int_summ__active_clients.sql](../models/intermediate/int_summ__active_clients.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_summ__active_clients`  

Clients holding at least one contract effective in the trailing 60 months. Grain is guaranteed by `select distinct month_end_date, primry_ownr_cl_id` in the model itself, so there is nothing left to assert.

**Upstream:** `stg_pdm__dates`, `ppg_metrics_dtl`

**Downstream:** `int_summ__client_breadth_depth`

#### Model SQL

```sql
-- Original CTE: active_clients
-- A client is "active" for the month if they hold at least one contract whose
-- effective date falls in the trailing 60 months ending at month end.
with dates as (
    select * from {{ ref('stg_pdm__dates') }}
)

select distinct
    dtl.month_end_date,
    dtl.primry_ownr_cl_id
from {{ ref('ppg_metrics_dtl') }} dtl
inner join dates dt
    on dtl.month_end_date = dt.month_end_date
where dtl.cnt_eff_dt between cast(add_months(dtl.month_end_date, -60) + 1 as date)
                         and dtl.month_end_date
```

#### Compiled SQL

```sql
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
```

### int_summ__breadth_depth

**File:** [models/intermediate/int_summ__breadth_depth.sql](../models/intermediate/int_summ__breadth_depth.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_summ__breadth_depth`  

Per-month rollup of client breadth and depth. Nothing asserted here: month_end_date is `group by 1` and tested on ppg_metrics_summ_monthly, and denominator is a count(distinct), which cannot be null.

**Upstream:** `int_summ__client_breadth_depth`

**Downstream:** `ppg_metrics_summ_monthly`

#### Model SQL

```sql
-- Original CTE: breadth_depth
-- Rolls the per-client figures up to one row per month.
with breadth_depth as (
select
    month_end_date,
    sum(breadth_count)                  as breadth_val,
    sum(depth_count)                    as depth_val,
    count(distinct primry_ownr_cl_id)   as denominator
from {{ ref('int_summ__client_breadth_depth') }}
group by 1
)
select * from breadth_depth
```

#### Compiled SQL

```sql
-- Original CTE: breadth_depth
-- Rolls the per-client figures up to one row per month.
with  __dbt__cte__int_summ__active_clients as (
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
),  __dbt__cte__int_summ__client_breadth_depth as (
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
), breadth_depth as (
select
    month_end_date,
    sum(breadth_count)                  as breadth_val,
    sum(depth_count)                    as depth_val,
    count(distinct primry_ownr_cl_id)   as denominator
from __dbt__cte__int_summ__client_breadth_depth
group by 1
)
select * from breadth_depth
```

### int_summ__client_breadth_depth

**File:** [models/intermediate/int_summ__client_breadth_depth.sql](../models/intermediate/int_summ__client_breadth_depth.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_summ__client_breadth_depth`  

Breadth and depth per client per month. Grain is guaranteed by the `group by 1, 2`; the range tests below are the ones that can fail.

**Upstream:** `stg_pdm__dates`, `int_summ__active_clients`, `ppg_metrics_dtl`

**Downstream:** `int_summ__breadth_depth`

#### Model SQL

```sql
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
{% set term_types = ppg_var('depth_collapse_product_types') %}

with dates as (
    select * from {{ ref('stg_pdm__dates') }}
),

active_clients as (
    select * from {{ ref('int_summ__active_clients') }}
),

scoped as (
    -- The original read ppg_metrics_dtl here with no month predicate at all and
    -- relied on the join to active_clients to constrain it. That worked, but
    -- only by accident: it scans every retained month before filtering. The
    -- explicit month filter lets the partition prune.
    select ppg.*
    from {{ ref('ppg_metrics_dtl') }} ppg
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
                {%- for t in term_types %}
                '{{ t }}'{% if not loop.last %},{% endif %}
                {%- endfor %}
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
```

#### Compiled SQL

```sql
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


with  __dbt__cte__int_summ__active_clients as (
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
), dates as (
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
```

### int_summ__sales

**File:** [models/intermediate/int_summ__sales.sql](../models/intermediate/int_summ__sales.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_summ__sales`  

One row per month. YTD new business counts and penetration rates. The month grain and total_sales are tested on ppg_metrics_summ_monthly.

**Upstream:** `stg_pdm__dates`, `ppg_metrics_dtl`

**Downstream:** `ppg_metrics_summ_monthly`

#### Model SQL

```sql
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
    select * from {{ ref('stg_pdm__dates') }}
),

ytd_sales as (
    select dtl.*
    from {{ ref('ppg_metrics_dtl') }} dtl
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
```

#### Compiled SQL

```sql
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
```

### int_wm_accounts

**File:** [models/intermediate/int_wm_accounts.sql](../models/intermediate/int_wm_accounts.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_wm_accounts`

**Upstream:** `stg_pdm__invest_sub_account`, `stg_pdm__invest_account_sub_account`, `stg_pdm__invest_account`

**Downstream:** `int_wm_accounts__with_producer`

#### Model SQL

```sql
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
from {{ ref('stg_pdm__invest_sub_account') }} wlth
inner join {{ ref('stg_pdm__invest_account_sub_account') }} acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join {{ ref('stg_pdm__invest_account') }} prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
)
select * from wm_accounts
```

#### Compiled SQL

```sql
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
```

### int_wm_accounts__with_producer

**File:** [models/intermediate/int_wm_accounts__with_producer.sql](../models/intermediate/int_wm_accounts__with_producer.sql)  
**Materialization:** `ephemeral`  
**Relation:** `dbt_dev.dbt_osalami.int_wm_accounts__with_producer`

**Upstream:** `int_wm_accounts`, `int_owners__by_invest_acct`, `stg_pdm__invest_account_producer`

**Downstream:** `int_products__unified`

#### Model SQL

```sql
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
    select * from {{ ref('int_wm_accounts') }}
),

owners as (
    select * from {{ ref('int_owners__by_invest_acct') }}
),

producers as (
    select * from {{ ref('stg_pdm__invest_account_producer') }}
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
```

#### Compiled SQL

```sql
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
with  __dbt__cte__int_wm_accounts as (
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
),  __dbt__cte__int_owners__by_invest_acct as (
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


), accounts as (
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
```

## Marts layer

### ppg_metrics_dtl

**File:** [models/marts/ppg_metrics_dtl.sql](../models/marts/ppg_metrics_dtl.sql)  
**Materialization:** `incremental`  
**Incremental strategy:** `insert_overwrite` | **unique_key:** `['month_end_date', 'cnt_id_nk', 'cnt_iss_cd_nk', 'producer_id_nk']`  
**Relation:** `dbt_dev.dbt_osalami_marts.ppg_metrics_dtl`  

Contract-level detail for the reporting month, filtered to contracts whose primary owner was an active policy owner at month end.

**Upstream:** `int_metrics__base_all`, `int_clients__active_eop`, `int_clients__planning_flags`

**Downstream:** `int_summ__active_clients`, `int_summ__client_breadth_depth`, `int_summ__sales`, `ppg_metrics_monthly`

#### Model SQL

```sql
{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        unique_key = ['month_end_date', 'cnt_id_nk', 'cnt_iss_cd_nk', 'producer_id_nk'],
        file_format = 'delta'
    )
}}

-- Original: cell 2, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_dtl
--
-- Contract-level detail for the reporting month, restricted to contracts whose
-- primary owner was an active policy owner at month end, with planning flags
-- attached.

with base as (
    select * from {{ ref('int_metrics__base_all') }}
),

active_clients as (
    select * from {{ ref('int_clients__active_eop') }}
),

planning as (
    select * from {{ ref('int_clients__planning_flags') }}
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
    {% if ppg_var('coalesce_planning_flags') %}
    coalesce(pln.gm_flag, 'N')                          as gm_flag,
    coalesce(pln.fp_flag, 'N')                          as fp_flag,
    coalesce(pln.gm_or_fp_flag, 'N')                    as gm_or_fp_flag
    {% else %}
    pln.gm_flag,
    pln.fp_flag,
    pln.gm_or_fp_flag
    {% endif %}

from base
inner join active_clients actcl
    on  actcl.po_client_id_nk = base.primry_ownr_cl_id
    -- Redundant while dates yields one row, but it is the predicate that keeps
    -- this correct if the window is ever widened to several months.
    and actcl.month_end_date  = base.month_end_date
left join planning pln
    on  pln.client_id         = base.primry_ownr_cl_id
    and pln.completed_plan_dt <= base.month_end_date
```

#### Compiled SQL

```sql
-- Original: cell 2, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_dtl
--
-- Contract-level detail for the reporting month, restricted to contracts whose
-- primary owner was an active policy owner at month end, with planning flags
-- attached.

with  __dbt__cte__int_metrics__base_all as (
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
),  __dbt__cte__int_clients__active_eop as (
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
),  __dbt__cte__int_planning__gm_clients as (
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
),  __dbt__cte__int_planning__fp_clients as (
-- The fee-based side of the planning union. Pasted twice in the original.
with feebased_fp_clients as (
select
    client_id,
    min(completed_plan_dt) as completed_plan_dt
from `dbt_dev`.`dbt_osalami_staging`.`stg_fx__feebased_fp_plans`
group by 1
)
select * from feebased_fp_clients
),  __dbt__cte__int_clients__planning_flags as (
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
), base as (
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
```

### ppg_metrics_monthly

**File:** [models/marts/ppg_metrics_monthly.sql](../models/marts/ppg_metrics_monthly.sql)  
**Materialization:** `incremental`  
**Incremental strategy:** `insert_overwrite` | **unique_key:** `None`  
**Relation:** `dbt_dev.dbt_osalami_marts.ppg_metrics_monthly`  

ppg_metrics_dtl with cnt_iss_cd_nk and producer_cnt_role_nm dropped. A pure projection -- there is NO deduplication, matching the original notebook, so duplicate rows are expected wherever two dtl rows differed only in those two columns. This table therefore has no unique key. Count contracts with count(distinct cnt_id_nk), never with count(*). Accumulates one partition per reporting month; feeds ppg_metrics_summ_monthly.

**Upstream:** `ppg_metrics_dtl`, `stg_pdm__dates`

#### Model SQL

```sql
{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        file_format = 'delta'
    )
}}

-- Original: cell 3, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_monthly
--
-- WHAT THIS MODEL ACTUALLY DOES
-- It is ppg_metrics_dtl with two columns removed -- cnt_iss_cd_nk and
-- producer_cnt_role_nm -- and NOTHING ELSE. A pure projection.
--
-- ⚠ THERE IS NO `distinct` HERE, AND THAT IS DELIBERATE ⚠
-- This model briefly carried one, on the assumption that the original applied
-- it. It does not: removing the `distinct` is what makes this model's output
-- match the notebook's row for row. Verified by diffing against the legacy
-- table.
--
-- The consequence is that DUPLICATE ROWS ARE EXPECTED. Any two dtl rows that
-- differed only in cnt_iss_cd_nk or producer_cnt_role_nm are byte-identical
-- once those columns are dropped, and both are kept. So:
--
--   * this table has NO unique key -- `unique_key` was removed from the config
--     above rather than left there asserting a grain that does not hold;
--   * row count here equals row count in ppg_metrics_dtl for the same month,
--     because a projection does not change cardinality;
--   * counting rows to count contracts overstates. Use count(distinct
--     cnt_id_nk), which is what ppg_metrics_summ_monthly already does.
--
-- Adding a `distinct` back would be a real improvement, but it changes
-- published figures and it hides the two underlying questions rather than
-- answering them:
--   1. producer fan-out -- the role filters in int_contracts__with_producer
--      are commented out, so one contract can carry several producer roles.
--   2. whether cnt_id_nk is unique without cnt_iss_cd_nk.
-- Resolve those and the duplicates disappear at source, which is the correct
-- fix. See README items 4 and the Grain section.
--
-- The original's `INNER JOIN dates dt ON dt.ytd_end_dt = month_end_date` was
-- doing the job dbt's incremental config now does: pick the one month to
-- append. Kept as an explicit filter so a run is idempotent for a given
-- report_month and `--vars` backfill still works.

with dtl as (

    select * from {{ ref('ppg_metrics_dtl') }}
    -- Restrict to the reporting month, exactly as the original did.
    where month_end_date = (select month_end_date from {{ ref('stg_pdm__dates') }})

),

current_load as (

    select
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

select * from current_load
```

#### Compiled SQL

```sql
-- Original: cell 3, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_monthly
--
-- WHAT THIS MODEL ACTUALLY DOES
-- It is ppg_metrics_dtl with two columns removed -- cnt_iss_cd_nk and
-- producer_cnt_role_nm -- and NOTHING ELSE. A pure projection.
--
-- ⚠ THERE IS NO `distinct` HERE, AND THAT IS DELIBERATE ⚠
-- This model briefly carried one, on the assumption that the original applied
-- it. It does not: removing the `distinct` is what makes this model's output
-- match the notebook's row for row. Verified by diffing against the legacy
-- table.
--
-- The consequence is that DUPLICATE ROWS ARE EXPECTED. Any two dtl rows that
-- differed only in cnt_iss_cd_nk or producer_cnt_role_nm are byte-identical
-- once those columns are dropped, and both are kept. So:
--
--   * this table has NO unique key -- `unique_key` was removed from the config
--     above rather than left there asserting a grain that does not hold;
--   * row count here equals row count in ppg_metrics_dtl for the same month,
--     because a projection does not change cardinality;
--   * counting rows to count contracts overstates. Use count(distinct
--     cnt_id_nk), which is what ppg_metrics_summ_monthly already does.
--
-- Adding a `distinct` back would be a real improvement, but it changes
-- published figures and it hides the two underlying questions rather than
-- answering them:
--   1. producer fan-out -- the role filters in int_contracts__with_producer
--      are commented out, so one contract can carry several producer roles.
--   2. whether cnt_id_nk is unique without cnt_iss_cd_nk.
-- Resolve those and the duplicates disappear at source, which is the correct
-- fix. See README items 4 and the Grain section.
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

    select
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

select * from current_load
```

### ppg_metrics_summ_monthly

**File:** [models/marts/ppg_metrics_summ_monthly.sql](../models/marts/ppg_metrics_summ_monthly.sql)  
**Materialization:** `incremental`  
**Incremental strategy:** `insert_overwrite` | **unique_key:** `['month_end_date']`  
**Relation:** `dbt_dev.dbt_osalami_marts.ppg_metrics_summ_monthly`  

One row per reporting month: YTD sales penetration plus multi-product breadth and depth. Reads ppg_metrics_dtl directly, not ppg_metrics_monthly.

**Upstream:** `int_summ__sales`, `int_summ__breadth_depth`

#### Model SQL

```sql
{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        unique_key = ['month_end_date'],
        file_format = 'delta'
    )
}}

-- Original: cell 4, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_summ_monthly
--
-- One row per reporting month. Two independent halves joined on the month:
--   sales        -- YTD new business counts and penetration rates
--   breadth_depth-- multi-product breadth and depth across active clients
--
-- The original's ORDER BY is dropped. Ordering an insert into a Delta table
-- does nothing for the stored result and costs a shuffle.

with sales as (
    select * from {{ ref('int_summ__sales') }}
),

breadth_depth as (
    select * from {{ ref('int_summ__breadth_depth') }}
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
```

#### Compiled SQL

```sql
-- Original: cell 4, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_summ_monthly
--
-- One row per reporting month. Two independent halves joined on the month:
--   sales        -- YTD new business counts and penetration rates
--   breadth_depth-- multi-product breadth and depth across active clients
--
-- The original's ORDER BY is dropped. Ordering an insert into a Delta table
-- does nothing for the stored result and costs a shuffle.

with  __dbt__cte__int_summ__sales as (
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
),  __dbt__cte__int_summ__active_clients as (
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
),  __dbt__cte__int_summ__client_breadth_depth as (
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
),  __dbt__cte__int_summ__breadth_depth as (
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
), sales as (
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
```

### ppg_stg_cnt_prd_mapping

**File:** [models/marts/ppg_stg_cnt_prd_mapping.sql](../models/marts/ppg_stg_cnt_prd_mapping.sql)  
**Materialization:** `incremental`  
**Incremental strategy:** `insert_overwrite` | **unique_key:** `['month_end_date', 'cnt_id_nk', 'cnt_iss_cd_nk', 'producer_id_nk']`  
**Relation:** `dbt_dev.dbt_osalami_marts.ppg_stg_cnt_prd_mapping`  

One row per in-scope contract or investment account per REPORTING MONTH, with product categorisation attached. Feeds ppg_metrics_dtl. Was keyed by a daily snapshot_date, which did not match the monthly grain of every table downstream of it.

**Upstream:** `int_products__categorized`, `stg_pdm__dates`

**Downstream:** `int_metrics__base_all`

#### Model SQL

```sql
{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        unique_key = ['month_end_date', 'cnt_id_nk', 'cnt_iss_cd_nk', 'producer_id_nk'],
        file_format = 'delta'
    )
}}

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
    select * from {{ ref('int_products__categorized') }}
),

dates as (
    select * from {{ ref('stg_pdm__dates') }}
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
```

#### Compiled SQL

```sql
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

with  __dbt__cte__int_contracts__scoped as (
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
),  __dbt__cte__int_owners__by_contract as (
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


),  __dbt__cte__int_contracts__with_producer as (
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
),  __dbt__cte__int_wm_accounts as (
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
),  __dbt__cte__int_owners__by_invest_acct as (
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


),  __dbt__cte__int_wm_accounts__with_producer as (
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
),  __dbt__cte__int_products__unified as (
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
),  __dbt__cte__int_products__categorized as (
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
), categorized as (
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
```

