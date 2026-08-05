-- ===========================================================================
-- WHICH pdm_history_mode CAN YOU ACTUALLY USE?
-- ===========================================================================
-- Run this BEFORE attempting any backfill of ppg_stg_cnt_prd_mapping. It
-- answers one question: does the history you need exist at source, and in what
-- form. Nothing in dbt can invent it if the answer is no.
--
-- Paste into a Databricks SQL editor or notebook and run the statements in
-- order. This lives in analyses/ so dbt compiles it but never executes it.
--
-- Steps 1, 2 and 6 are the decisive ones. Do those first.


-- ===========================================================================
-- STEP 1 -- do the PDM tables carry validity columns?  (-> mode 'scd2')
-- ===========================================================================
-- If any table shows a plausible effective/expiry PAIR, scd2 is available and
-- is the best answer by a wide margin: it reaches back as far as the source
-- retains, with no new infrastructure.

select
    table_name,
    column_name,
    data_type
from prod_execution_rs.information_schema.columns
where table_schema = 'ext_pdm'
  and table_name in (
        'dim_contract', 'fact_contract_cmpnt_producer', 'dim_product',
        'fact_primary_owner_derv', 'dim_invest_account',
        'dim_invest_sub_account', 'fact_invest_account_sub_account',
        'fact_invest_account_producer_role')
  and (
        lower(column_name) like '%eff%'      or lower(column_name) like '%exp%'
     or lower(column_name) like '%valid%'    or lower(column_name) like '%start%'
     or lower(column_name) like '%end_%'     or lower(column_name) like '%_from%'
     or lower(column_name) like '%_to'       or lower(column_name) like '%current%'
     or lower(column_name) like '%active%'   or lower(column_name) like '%status%'
  )
order by table_name, column_name;

-- Careful: cnt_eff_dt and invest_sub_acct_eff_dt are BUSINESS effective dates
-- (when the contract started), not ROW validity dates (when this version of
-- the row became true). Only the second kind can reconstruct history. A row
-- validity pair is usually prefixed edh_, row_, rec_ or dw_.


-- ===========================================================================
-- STEP 2 -- is dim_contract really Type 2, or does it just soft-delete?
-- ===========================================================================
-- A Type 2 table holds MULTIPLE rows per key. A table that only soft-deletes
-- holds ONE. This is the single most informative query here.

select
    count(*)                                                as total_rows,
    count(distinct cnt_id_nk, cnt_iss_cd_nk)                as distinct_keys,
    round(count(*) / count(distinct cnt_id_nk, cnt_iss_cd_nk), 4) as rows_per_key,
    sum(case when edh_record_status_in = 'A' then 1 else 0 end)   as active_rows,
    sum(case when edh_record_status_in <> 'A' then 1 else 0 end)  as inactive_rows
from prod_execution_rs.ext_pdm.dim_contract;

--   rows_per_key ~ 1.0  -> NOT Type 2. History does not exist at source.
--                          Go to steps 4, 5 and 6.
--   rows_per_key > 1.0  -> Type 2. Confirm with step 3, then use mode 'scd2'.


-- ===========================================================================
-- STEP 3 -- do the intervals tile cleanly, and what does 'A' mean?
-- ===========================================================================
-- Substitute the column names found in step 1 for <eff_col> / <exp_col>.
--
-- 3a. Overlap check. MUST return zero rows -- if intervals overlap, an as-of
--     filter returns duplicates rather than a clean point-in-time view, and
--     every count in the report doubles for the affected keys.
--
--     with v as (
--         select
--             cnt_id_nk, cnt_iss_cd_nk,
--             <eff_col> as eff,
--             coalesce(<exp_col>, date'9999-12-31') as exp,
--             lead(<eff_col>) over (
--                 partition by cnt_id_nk, cnt_iss_cd_nk order by <eff_col>
--             ) as next_eff
--         from prod_execution_rs.ext_pdm.dim_contract
--     )
--     select * from v where next_eff is not null and next_eff < exp;
--
-- 3b. THE ONE THAT BITES. Decides whether pdm_as_of() may AND the status flag
--     into the scd2 predicate. Count active rows per key:
--
--     with per_key as (
--         select cnt_id_nk, cnt_iss_cd_nk,
--                sum(case when edh_record_status_in = 'A' then 1 else 0 end) as active_versions,
--                count(*) as total_versions
--         from prod_execution_rs.ext_pdm.dim_contract
--         group by 1, 2
--         having count(*) > 1
--     )
--     select
--         count(*)                                                   as multi_version_keys,
--         sum(case when active_versions = 1 then 1 else 0 end)        as exactly_one_active,
--         sum(case when active_versions = total_versions then 1 else 0 end) as all_active
--     from per_key;
--
--     exactly_one_active ~ multi_version_keys
--         -> 'A' marks the LATEST version. Do NOT add the status predicate to
--            scd2 mode; ANDing it collapses you back to current state and the
--            history silently vanishes. This is the default in pdm_as_of().
--     all_active ~ multi_version_keys
--         -> 'A' means "not soft-deleted" and IS safe to AND in. Add it to the
--            scd2 branch of macros/pdm_as_of.sql.


-- ===========================================================================
-- STEP 4 -- how far back does Delta time travel reach?  (-> 'time_travel')
-- ===========================================================================
-- Worth running even if scd2 is available: time_travel also makes the NORMAL
-- monthly run exact, because it can read PDM as of the month end rather than
-- as of whenever the job happened to run.

describe history prod_execution_rs.ext_pdm.dim_contract;
-- The oldest timestamp is your backfill floor.

show tblproperties prod_execution_rs.ext_pdm.dim_contract;
-- delta.logRetentionDuration            -- default 30 days
-- delta.deletedFileRetentionDuration    -- default 7 days; the REAL floor for
--                                          reading old versions
-- delta.enableChangeDataFeed            -- if true, see step 5


-- ===========================================================================
-- STEP 5 -- sibling history tables and change data feed
-- ===========================================================================
-- Frequently the history does exist, just not in the table you were reading.
-- This is the cheapest possible win and nothing had looked for it.

select table_catalog, table_schema, table_name
from prod_execution_rs.information_schema.tables
where (lower(table_schema) like '%pdm%' or lower(table_schema) like '%hist%')
  and (lower(table_name) like '%contract%' or lower(table_name) like '%producer%')
  and (lower(table_name) like '%hist%' or lower(table_name) like '%arch%'
       or lower(table_name) like '%scd%' or lower(table_name) like '%snap%'
       or lower(table_schema) like '%hist%' or lower(table_schema) like '%arch%')
order by table_schema, table_name;

-- If delta.enableChangeDataFeed was true in step 4, this reconstructs changes
-- directly (bounded by the same retention window):
--
--     select * from table_changes('prod_execution_rs.ext_pdm.dim_contract', 1)
--     limit 100;


-- ===========================================================================
-- STEP 6 -- how much can ppg_metrics_dtl_hist give you?
-- ===========================================================================
-- The one place real PPG history already exists. It is a SUBSET of the mapping
-- table -- it survived the inner join to active clients, and lacks
-- cnt_iss_cd_nk and producer_cnt_role_nm -- so it cannot rebuild the mapping
-- table exactly. But it tells you which months you actually lost.

select
    month_end_date,
    count(*)                            as rows,
    count(distinct cnt_id_nk)           as contracts,
    count(distinct primry_ownr_cl_id)   as clients
from prod_builder_fieldexperience.ppg.ppg_metrics_dtl_hist
group by 1
order by 1;


-- ===========================================================================
-- WHAT TO DO WITH THE ANSWERS
-- ===========================================================================
-- step 1 + 2 + 3 all clean          -> pdm_history_mode: 'scd2', set
--                                      pdm_eff_col / pdm_exp_col. Done.
-- step 5 finds a history table      -> point the source at it; likely scd2.
-- only step 4 has reach             -> 'time_travel'. Backfill the months
--                                      inside retention NOW, before they age
--                                      out. They are expiring as you read this.
-- nothing                           -> 'snapshot', and accept that history
--                                      starts today. Run `dbt snapshot` daily
--                                      from now on; a missed day is a
--                                      permanent hole. Also add snapshots for
--                                      the five un-snapshotted tables before
--                                      calling a backfill audit-grade.

select 'run the statements above in order' as instructions
