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
-- Step 2 is the decisive one -- steps 1, 3b and 3c are already answered inline.


-- ===========================================================================
-- STEP 0 -- what timezone is the session in?
-- ===========================================================================
-- Cheap, and it silently shifts every month boundary if it is wrong.
--
-- The validity timestamps are stored UTC but written on US/Eastern midnights:
-- the sentinel is 9999-12-31 05:00:00Z and older rows start 2019-11-01
-- 04:00:00Z, both exactly midnight Eastern. The as-of instant is built with
-- last_day(), which resolves in the SESSION timezone. A session in UTC
-- therefore treats "end of 30 June" as 23:59:59Z = 19:59:59 Eastern, and every
-- change made in the last four hours of the month lands in the following
-- month's report.

select current_timezone() as session_tz;

-- Not America/New_York -> set it on the dbt profile or the warehouse rather
-- than compensating inside the models:
--     set time zone 'America/New_York';
-- Confirm which one the source actually means before changing anything; the
-- 04:00 vs 05:00 split across the samples is EDT vs EST, which is consistent
-- with a local-midnight convention rather than a fixed offset.


-- ===========================================================================
-- STEP 1 -- do the PDM tables carry validity columns?  ANSWERED: YES
-- ===========================================================================
-- All eight tables carry edh_record_start_ts / edh_record_end_ts. These are
-- RECORD validity timestamps -- when this version of the row was true -- which
-- is the kind that reconstructs history, not business dates like cnt_eff_dt.
--
-- They are already set as pdm_eff_col / pdm_exp_col in macros/ppg_config.sql,
-- so scd2 mode is wired and ready. It is NOT yet proven: see step 2.
--
-- Re-run the query below only if the PDM schema changes.

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
-- STEP 3 -- do the intervals tile, and what does 'A' mean?
-- ===========================================================================
-- Run these two only if step 2 showed rows_per_key > 1.0.

-- 3a. OVERLAP CHECK. Must return ZERO rows. If intervals overlap, more than one
--     version satisfies the as-of predicate, so the affected contracts are
--     counted twice all the way through to ppg_metrics_summ_monthly.
--
--     This is also enforced on every run by the uniqueness test on
--     stg_pdm__contracts, so it is a pre-check rather than the last line of
--     defence.

with v as (
    select
        cnt_id_nk,
        cnt_iss_cd_nk,
        edh_record_start_ts                                     as eff,
        coalesce(edh_record_end_ts, timestamp'9999-12-31')       as exp,
        lead(edh_record_start_ts) over (
            partition by cnt_id_nk, cnt_iss_cd_nk
            order by edh_record_start_ts
        )                                                       as next_eff
    from prod_execution_rs.ext_pdm.dim_contract
)
select count(*) as overlapping_versions
from v
where next_eff is not null
  and next_eff < exp;

-- 3a-ii. HALF-OPEN OR CLOSED?  ANSWERED: CLOSED, with a one-second gap.
--        Sample shows 10:57:04 -> 10:57:05 and 09:12:06 -> 09:12:07, so end_ts
--        is the last instant the version was valid. pdm_as_of_instant() is
--        anchored on 23:59:59 rather than next-day midnight for exactly this
--        reason -- midnight would fall in the one-second hole between versions
--        and drop the key from the month with no error.
--
--        Re-run if the loader changes. `gapped` should stay dominant.

select
    count(*)                                                as adjacent_pairs,
    sum(case when next_eff = exp then 1 else 0 end)         as contiguous_half_open,
    sum(case when next_eff > exp then 1 else 0 end)         as gapped_closed,
    max(unix_micros(next_eff) - unix_micros(exp))           as max_gap_micros
from v
where next_eff is not null;

--     If max_gap_micros is ever LARGER than one second, versions do not tile:
--     there are instants where a key has no valid version at all, and a month
--     end landing in such a hole loses that key silently.

-- 3b. THE ONE THAT BITES. Decides whether pdm_as_of() may AND the status flag
--     into the scd2 predicate.
--
--     A sample key looks like this:
--
--         I   2019-11-01 04:00:00   2022-01-04 10:57:04
--         I   2022-01-04 10:57:05   2022-01-05 09:12:06
--         A   2022-01-05 09:12:07   9999-12-31 05:00:00
--
--     'A' sits only on the open-ended version. That is consistent with TWO
--     incompatible readings, and the sample alone cannot separate them:
--
--       (a) 'A' is a VERSIONING ARTEFACT meaning "latest version of this key".
--           Historical versions are stamped 'I' no matter what the record's
--           business state was at the time. The status column then carries no
--           historical meaning at all, and `where edh_record_status_in = 'A'`
--           is just the house idiom for "current state" -- which is exactly how
--           the original notebook used it.
--
--       (b) 'A' is a REAL BUSINESS STATUS that happened to change on
--           2022-01-05. The record genuinely was inactive before then, and a
--           point-in-time query for 2021 SHOULD exclude it.
--
--     The separating question is whether 'A' ever appears on a CLOSED version.
--     Under (a) it never can; under (b) it will, wherever a record went active
--     and then changed again.

select
    count(*)                                                        as closed_versions,
    sum(case when edh_record_status_in = 'A' then 1 else 0 end)     as closed_but_active,
    count(distinct case when edh_record_status_in = 'A'
                        then cnt_id_nk end)                         as keys_affected
from prod_execution_rs.ext_pdm.dim_contract
where edh_record_end_ts < timestamp'9999-01-01';

--     ANSWERED: closed_but_active = 0. Reading (a).
--
--     'A' marks the latest version. Every superseded version is stamped 'I'
--     when the next is written, so the flag records nothing about the past.
--     macros/pdm_as_of.sql therefore does NOT combine it with the interval in
--     scd2 mode, and must not be changed to -- see the comment there.
--
--     THE COST: business active/inactive status as of a past month is not
--     recoverable from this table. It was never stored per version. "Was this
--     contract active in March" cannot be answered from PDM history at all,
--     by any query, and needs a different source.


-- ===========================================================================
-- STEP 3c -- can a CURRENT version be inactive?
-- ===========================================================================
-- The remaining consequence of 3b, and the one that will show up the moment
-- you reconcile a scd2 run against the published figures.
--
-- In 'current' mode the pipeline filters to edh_record_status_in = 'A'. In
-- scd2 mode it does not filter on status at all. For a PAST month that is
-- correct and unavoidable. For the CURRENT month the two modes should agree --
-- unless some open-ended version carries 'I', i.e. a record that is live but
-- soft-deleted. Those would be excluded by 'current' and included by scd2.

select
    edh_record_status_in,
    count(*)                        as open_versions,
    count(distinct cnt_id_nk)       as distinct_keys
from prod_execution_rs.ext_pdm.dim_contract
where edh_record_end_ts >= timestamp'9999-01-01'
group by 1
order by 2 desc;

--     ANSWERED: only 'A' appears.
--
--     Combined with 3b, edh_record_status_in = 'A' is EXACTLY equivalent to
--     edh_record_end_ts >= '9999-01-01'. The flag carries no information the
--     validity interval does not already carry. Three consequences:
--
--       1. scd2 and current return identical rows for the CURRENT month, so
--          step 3d below should reconcile to the row. Any difference is the
--          timezone (step 0) or the interval convention (3a-ii), not the
--          status flag.
--
--       2. Switching to scd2 loses no business filtering. Nothing is being
--          dropped from the predicate except a redundant restatement of it.
--
--       3. There are no soft-deletes in this column. `where
--          edh_record_status_in = 'A'` never excluded lapsed or cancelled
--          contracts -- it only picked the latest version. The population is
--          narrowed to live business solely by the join to
--          int_clients__active_eop, which comes from the metrics marketplace
--          policy-owner fact. See the note in int_contracts__scoped.sql.
--
--     tests/assert_pdm_status_matches_version.sql now enforces the
--     equivalence, so if EDH ever introduces a soft-delete the build fails
--     instead of the two modes quietly diverging.


-- ===========================================================================
-- STEP 3d -- reconcile before switching
-- ===========================================================================
-- Run the CURRENT month both ways and compare. This is the cheapest proof that
-- scd2 is wired correctly, because for the current month the two modes are
-- answering the same question and should return the same rows.
--
--     dbt run -s stg_pdm__contracts
--     dbt run -s stg_pdm__contracts --vars '{pdm_history_mode: scd2}'
--
-- A difference is explained by 3c, by the timezone in step 0, or by the
-- interval convention in 3a-ii -- in that order of likelihood. Do not flip the
-- project default until this matches.


-- ===========================================================================
-- STEP 4 -- Delta time travel: RULED OUT
-- ===========================================================================
-- Time travel is not enabled on the PDM sources, so there is no version log to
-- read as of a past month end. The 'time_travel' mode has been removed from
-- macros/pdm_as_of.sql accordingly.
--
-- This matters more than it looks. Time travel was the only option that needed
-- no modelling work AND could reach backwards. Its absence is what makes
-- step 2 decisive: either the source is Type 2 and everything is recoverable,
-- or nothing before today is. There is no intermediate outcome.
--
-- Re-run these two if the platform team ever changes the table properties --
-- they are the only thing that would reopen the option:
--
--     describe history prod_execution_rs.ext_pdm.dim_contract;
--     show tblproperties prod_execution_rs.ext_pdm.dim_contract;
--     -- delta.logRetentionDuration, delta.deletedFileRetentionDuration


-- ===========================================================================
-- STEP 5 -- sibling history tables
-- ===========================================================================
-- Frequently the history does exist, just not in the table you were reading.
-- With time travel ruled out this is no longer a nice-to-have: if the source is
-- not Type 2, a sibling history table is the LAST remaining way to recover a
-- month that has already passed. Run it even if steps 1-3 looked hopeless.

select table_catalog, table_schema, table_name
from prod_execution_rs.information_schema.tables
where (lower(table_schema) like '%pdm%' or lower(table_schema) like '%hist%')
  and (lower(table_name) like '%contract%' or lower(table_name) like '%producer%')
  and (lower(table_name) like '%hist%' or lower(table_name) like '%arch%'
       or lower(table_name) like '%scd%' or lower(table_name) like '%snap%'
       or lower(table_schema) like '%hist%' or lower(table_schema) like '%arch%')
order by table_schema, table_name;

-- Change data feed would be the other way to reconstruct changes directly, but
-- it reads through the same version log that time travel uses, so it is almost
-- certainly unavailable for the same reason. Cheap enough to disprove:
--
--     select * from table_changes('prod_execution_rs.ext_pdm.dim_contract', 1)
--     limit 100;
--
-- An error here confirms it; do not spend longer than one query on this.


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
-- Steps 1, 3b and 3c are answered: the validity columns exist, 'A' marks the
-- latest version only, and it is exactly equivalent to the open interval. The
-- whole question reduces to step 2 -- are versions actually RETAINED.
--
-- step 2 rows_per_key > 1.0,        -> pdm_history_mode: 'scd2'. Backfill as
--   step 3a returns zero               far as the source retains. Flip the
--                                      default in macros/ppg_config.sql and you
--                                      are done. Trial it first with:
--                                        dbt build --vars '{pdm_history_mode: scd2,
--                                          report_month: "2026-06-30"}'
--                                      and compare row counts against the
--                                      published June figures.
--
-- step 5 finds a history table      -> point the source at it; likely scd2.
--
-- step 2 rows_per_key ~ 1.0         -> the columns are decorative: the loader
--                                      overwrites instead of versioning. scd2
--                                      would then return CURRENT data for every
--                                      past month, silently. This is the trap,
--                                      and tests/assert_pdm_retains_versions.sql
--                                      fails the build rather than let it
--                                      happen.
--
--                                      There is no fallback left if this
--                                      happens: time travel is not enabled, and
--                                      dbt-snapshot mode was removed once the
--                                      source was confirmed Type 2. Recovering
--                                      would mean reinstating snapshots from
--                                      git and starting to accumulate history
--                                      forward from that day -- nothing earlier
--                                      would be recoverable. Tell whoever
--                                      consumes ppg_metrics_* before promising
--                                      any restatement.

select 'run the statements above in order' as instructions
