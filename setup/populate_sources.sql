-- ============================================================================
-- populate_sources.sql
-- Creates and populates every source table declared in
-- models/staging/_pdm__sources.yml with synthetic-but-coherent data, so the
-- whole dbt DAG (staging -> intermediate -> marts) runs end to end.
--
-- Databricks SQL (Unity Catalog). Run in the SQL editor, a notebook, or via
-- setup/run_populate.py. Dates are anchored to current_date so the
-- snapshot_date()/ytd logic works on any day you run it.
--
-- If you cannot create these catalogs, point the source `database:` entries in
-- _pdm__sources.yml at a catalog you own and adjust the names below to match.
-- ============================================================================

create catalog if not exists prod_execution_rs;
create catalog if not exists prod_execution_metrics_marketplace;
create catalog if not exists prod_execution_datalake;
create catalog if not exists prod_execution_fieldexperience;
create catalog if not exists prod_builder_fieldexperience;

create schema if not exists prod_execution_rs.ext_pdm;
create schema if not exists prod_execution_metrics_marketplace.metrics359;
create schema if not exists prod_execution_datalake.lake_int_crm_salescentral;
create schema if not exists prod_execution_fieldexperience.digital;
create schema if not exists prod_builder_fieldexperience.fx_test;
create schema if not exists prod_builder_fieldexperience.ppg;

-- ----------------------------------------------------------------------------
-- 1. dim_date : full calendar 2024-2027.
--    stg_pdm__dates needs clndr_dt = current_date; stg_pdm__ytd_dates needs
--    clndr_dt = add_months(current_date, -1).
-- ----------------------------------------------------------------------------
create or replace table prod_execution_rs.ext_pdm.dim_date (
    clndr_dt      date,
    mth_begin_dt  date,
    mth_end_dt    date
);

insert into prod_execution_rs.ext_pdm.dim_date
select
    d                       as clndr_dt,
    date_trunc('MONTH', d)  as mth_begin_dt,
    last_day(d)             as mth_end_dt
from (select explode(sequence(date'2024-01-01', date'2027-12-31')) as d);

-- ============================================================================
-- SCD2 CONVENTION USED BELOW
--
-- Every PDM table carries edh_record_start_ts / edh_record_end_ts, matching the
-- real source. The convention is copied from observed production rows and the
-- models depend on all three parts of it:
--
--   * CLOSED intervals with a ONE-SECOND GAP. A version ends one second before
--     its successor begins (10:57:04 -> 10:57:05), so end_ts is the last
--     instant the version was valid, NOT the instant it was replaced. This is
--     why pdm_as_of_instant() anchors on 23:59:59 rather than the next day's
--     midnight -- see macros/report_dates.sql.
--
--   * The open version ends at the sentinel 9999-12-31 05:00:00, never null.
--
--   * edh_record_status_in = 'A' appears on the open version and ONLY there;
--     every superseded version is stamped 'I'. The flag is exactly equivalent
--     to "end_ts is the sentinel", which is what
--     tests/assert_pdm_status_matches_version.sql enforces. Do not add an 'A'
--     row with a closed interval here or that test will fail, correctly.
--
-- Historical versions are not decoration: they make a backfill produce
-- genuinely different output from a current-state run, which is the only way
-- to prove pdm_history_mode: scd2 works. Contracts also start their validity
-- at cnt_eff_dt, so a backfill far enough back excludes contracts that did not
-- exist yet.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 2. dim_contract : insurance contracts.
--    Scope filter keeps LIFE INSURANCE / ANNUITIES / LONG TERM CARE, or
--    cnt_iss_cd_nk = 'IDI'. C9001 (GROUP INSURANCE) and C9002 (edh status 'D')
--    exist to prove the filters work.
--
--    HISTORY: C1001, C1002 and C2001 were each recategorised onto a different
--    plan_cd, so a backfill shows them under their OLD product. C9002 was
--    deleted two months ago -- its last version is closed with no successor,
--    so it vanishes from current state but is still visible as of an earlier
--    month. 15 rows over 12 keys keeps rows_per_key at 1.25, comfortably above
--    the 1.05 floor in tests/assert_pdm_retains_versions.sql.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_rs.ext_pdm.dim_contract (
    cnt_id_nk            string,
    cnt_iss_cd_nk        string,
    plan_cd              string,
    lob_nm               string,
    cnt_eff_dt           date,
    edh_record_status_in string,
    edh_record_start_ts  timestamp,
    edh_record_end_ts    timestamp
);

insert into prod_execution_rs.ext_pdm.dim_contract values
    -- C1001 : universal life -> whole life, four months ago
    ('C1001', 'NYL', 'UL100', 'LIFE INSURANCE', date'2024-03-15', 'I',
        timestamp'2024-03-15 00:00:00',
        cast(add_months(current_date, -4) as timestamp) - interval 1 second),
    ('C1001', 'NYL', 'WL100', 'LIFE INSURANCE', date'2024-03-15', 'A',
        cast(add_months(current_date, -4) as timestamp),
        timestamp'9999-12-31 05:00:00'),

    -- C1002 : yearly renewable term -> level term, three months ago
    ('C1002', 'NYL', 'YRT10', 'LIFE INSURANCE', add_months(current_date, -6), 'I',
        cast(add_months(current_date, -6) as timestamp),
        cast(add_months(current_date, -3) as timestamp) - interval 1 second),
    ('C1002', 'NYL', 'LT100', 'LIFE INSURANCE', add_months(current_date, -6), 'A',
        cast(add_months(current_date, -3) as timestamp),
        timestamp'9999-12-31 05:00:00'),

    -- C2001 : fixed -> variable annuity, five months ago
    ('C2001', 'NYL', 'FA100', 'ANNUITIES', add_months(current_date, -7), 'I',
        cast(add_months(current_date, -7) as timestamp),
        cast(add_months(current_date, -5) as timestamp) - interval 1 second),
    ('C2001', 'NYL', 'VA100', 'ANNUITIES', add_months(current_date, -7), 'A',
        cast(add_months(current_date, -5) as timestamp),
        timestamp'9999-12-31 05:00:00'),

    -- Single-version contracts. Validity starts at cnt_eff_dt, so C1005 (-3mo),
    -- C2003 (-4mo) and C3001 (-2mo) are absent from a backfill reaching further
    -- back than that.
    ('C1003', 'NYL', 'YRT10', 'LIFE INSURANCE', add_months(current_date, -5), 'A',
        cast(add_months(current_date, -5) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C1004', 'NYL', 'UL100', 'LIFE INSURANCE', add_months(current_date, -9), 'A',
        cast(add_months(current_date, -9) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C1005', 'NYL', 'MWP01', 'LIFE INSURANCE', add_months(current_date, -3), 'A',
        cast(add_months(current_date, -3) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C2002', 'NYL', 'FA100', 'ANNUITIES', date'2025-06-30', 'A',
        timestamp'2025-06-30 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C2003', 'NYL', 'GIA01', 'ANNUITIES', add_months(current_date, -4), 'A',
        cast(add_months(current_date, -4) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C3001', 'NYL', 'LTC01', 'LONG TERM CARE', add_months(current_date, -2), 'A',
        cast(add_months(current_date, -2) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C4001', 'IDI', 'IDI01', 'DISABILITY', add_months(current_date, -6), 'A',
        cast(add_months(current_date, -6) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C9001', 'NYL', 'WL100', 'GROUP INSURANCE', date'2024-01-10', 'A',
        timestamp'2024-01-10 00:00:00', timestamp'9999-12-31 05:00:00'),

    -- C9002 : deleted two months ago. Closed with no successor, so no version
    -- covers "now" and it is absent from current state -- as it already was via
    -- the 'D' status. Both modes exclude it, for different but correct reasons.
    ('C9002', 'NYL', 'WL100', 'LIFE INSURANCE', date'2024-02-10', 'D',
        timestamp'2024-02-10 00:00:00',
        cast(add_months(current_date, -2) as timestamp) - interval 1 second);

-- ----------------------------------------------------------------------------
-- 3. fact_primary_owner_derv : one owner per contract / invest account.
--    C1001 has a second, later owner row (CL011) to exercise the
--    dedupe_primary_owner window.
-- ----------------------------------------------------------------------------
--    HISTORY: C1005 changed hands three months ago (CL010 -> CL004), so a
--    backfill attributes it to the previous owner.
create or replace table prod_execution_rs.ext_pdm.fact_primary_owner_derv (
    cnt_acct_id_nk             string,
    iss_cd_nk                  string,
    primry_ownr_cl_id          string,
    primry_ownr_cl_role_eff_dt date,
    rec_tp_cd                  string,
    edh_record_status_in       string,
    edh_record_start_ts        timestamp,
    edh_record_end_ts          timestamp
);

insert into prod_execution_rs.ext_pdm.fact_primary_owner_derv values
    ('C1001',  'NYL', 'CL001', date'2024-03-15', 'CONTRACT',    'A',
        timestamp'2024-03-15 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C1001',  'NYL', 'CL011', date'2025-01-01', 'CONTRACT',    'A',
        timestamp'2025-01-01 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C1002',  'NYL', 'CL002', date'2026-02-10', 'CONTRACT',    'A',
        timestamp'2026-02-10 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C1003',  'NYL', 'CL002', date'2026-03-05', 'CONTRACT',    'A',
        timestamp'2026-03-05 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C1004',  'NYL', 'CL003', date'2025-11-20', 'CONTRACT',    'A',
        timestamp'2025-11-20 00:00:00', timestamp'9999-12-31 05:00:00'),

    -- C1005 : owner change three months ago
    ('C1005',  'NYL', 'CL010', date'2026-05-01', 'CONTRACT',    'I',
        cast(add_months(current_date, -6) as timestamp),
        cast(add_months(current_date, -3) as timestamp) - interval 1 second),
    ('C1005',  'NYL', 'CL004', date'2026-05-01', 'CONTRACT',    'A',
        cast(add_months(current_date, -3) as timestamp), timestamp'9999-12-31 05:00:00'),

    ('C2001',  'NYL', 'CL005', date'2026-01-15', 'CONTRACT',    'A',
        timestamp'2026-01-15 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C2002',  'NYL', 'CL006', date'2025-06-30', 'CONTRACT',    'A',
        timestamp'2025-06-30 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C2003',  'NYL', 'CL001', date'2026-04-12', 'CONTRACT',    'A',
        timestamp'2026-04-12 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C3001',  'NYL', 'CL007', date'2026-06-18', 'CONTRACT',    'A',
        timestamp'2026-06-18 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C4001',  'IDI', 'CL008', date'2026-02-25', 'CONTRACT',    'A',
        timestamp'2026-02-25 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C9001',  'NYL', 'CL009', date'2024-01-10', 'CONTRACT',    'A',
        timestamp'2024-01-10 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('SA1001', 'WM',  'CL003', date'2026-03-01', 'INVEST_ACCT', 'A',
        timestamp'2026-03-01 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('SA1002', 'WM',  'CL004', date'2025-09-15', 'INVEST_ACCT', 'A',
        timestamp'2025-09-15 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('SA1003', 'WM',  'CL005', date'2026-06-10', 'INVEST_ACCT', 'A',
        timestamp'2026-06-10 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('SA1004', 'WM',  'CL001', date'2026-01-20', 'INVEST_ACCT', 'A',
        timestamp'2026-01-20 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('SA1005', 'WM',  'CL002', date'2026-07-02', 'INVEST_ACCT', 'A',
        timestamp'2026-07-02 00:00:00', timestamp'9999-12-31 05:00:00');

-- ----------------------------------------------------------------------------
-- 4. fact_contract_cmpnt_producer : contract producers.
--    C1001 carries two roles so pick_producer() / the fan-out behaviour is
--    observable either way the apply_producer_role_filter var is set.
-- ----------------------------------------------------------------------------
--    HISTORY: C1003's producer PR02 was reclassified from ALTERNATE SERVICING
--    to ORIGINAL four months ago. A servicing reassignment is the change most
--    likely to be lost without history, which is why it is modelled here.
create or replace table prod_execution_rs.ext_pdm.fact_contract_cmpnt_producer (
    cnt_id_nk            string,
    cnt_iss_cd_nk        string,
    producer_id_nk       string,
    producer_cnt_role_nm string,
    edh_record_status_in string,
    edh_record_start_ts  timestamp,
    edh_record_end_ts    timestamp
);

insert into prod_execution_rs.ext_pdm.fact_contract_cmpnt_producer values
    ('C1001', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A',
        timestamp'2024-03-15 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C1001', 'NYL', 'PR02', 'ALTERNATE SERVICING PRODUCER', 'A',
        timestamp'2024-03-15 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C1002', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A',
        cast(add_months(current_date, -6) as timestamp), timestamp'9999-12-31 05:00:00'),

    -- C1003 / PR02 : role reclassified four months ago
    ('C1003', 'NYL', 'PR02', 'ALTERNATE SERVICING PRODUCER', 'I',
        cast(add_months(current_date, -5) as timestamp),
        cast(add_months(current_date, -4) as timestamp) - interval 1 second),
    ('C1003', 'NYL', 'PR02', 'ORIGINAL PRODUCER',            'A',
        cast(add_months(current_date, -4) as timestamp), timestamp'9999-12-31 05:00:00'),

    ('C1004', 'NYL', 'PR03', 'ORIGINAL PRODUCER',            'A',
        cast(add_months(current_date, -9) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C1005', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A',
        cast(add_months(current_date, -3) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C2001', 'NYL', 'PR02', 'ORIGINAL PRODUCER',            'A',
        cast(add_months(current_date, -7) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C2002', 'NYL', 'PR03', 'ORIGINAL PRODUCER',            'A',
        timestamp'2025-06-30 00:00:00', timestamp'9999-12-31 05:00:00'),
    ('C2003', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A',
        cast(add_months(current_date, -4) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C3001', 'NYL', 'PR04', 'PERMANENT SERVICING PRODUCER', 'A',
        cast(add_months(current_date, -2) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('C4001', 'IDI', 'PR05', 'UNKNOWN',                      'A',
        cast(add_months(current_date, -6) as timestamp), timestamp'9999-12-31 05:00:00');

-- ----------------------------------------------------------------------------
-- 5. Investment side. int_wm_accounts joins
--    dim_invest_account.invest_acct_id_nk = fact_...sub_account.invest_sub_acct_id_nk,
--    so account ids deliberately reuse the sub-account ids.
--    SA9001 (product OTHERFUND) is filtered out by stg_pdm__invest_sub_account.
-- ----------------------------------------------------------------------------
-- Sub-account validity starts at invest_sub_acct_eff_dt, so SA1005 (-1mo) and
-- SA1003 (-2mo) drop out of a backfill reaching back further than that.
create or replace table prod_execution_rs.ext_pdm.dim_invest_sub_account (
    invest_sub_acct_id_nk     string,
    invest_sub_acct_iss_cd_nk string,
    invest_sub_acct_eff_dt    date,
    plan_cd                   string,
    product_nm                string,
    edh_record_status_in      string,
    edh_record_start_ts       timestamp,
    edh_record_end_ts         timestamp
);

insert into prod_execution_rs.ext_pdm.dim_invest_sub_account values
    ('SA1001', 'WM', add_months(current_date, -5), 'EAG01', 'EAGLE',      'A',
        cast(add_months(current_date, -5) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1002', 'WM', date'2025-09-15',             'SEC01', 'NYLIFE SEC', 'A',
        cast(date'2025-09-15' as timestamp),             timestamp'9999-12-31 05:00:00'),
    ('SA1003', 'WM', add_months(current_date, -2), 'MF001', 'MAINSTAY',   'A',
        cast(add_months(current_date, -2) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1004', 'WM', add_months(current_date, -7), 'MF001', 'NP MUTFNDS', 'A',
        cast(add_months(current_date, -7) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1005', 'WM', add_months(current_date, -1), 'MF001', 'NP529',      'A',
        cast(add_months(current_date, -1) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA9001', 'WM', date'2025-01-01',             'MF001', 'OTHERFUND',  'A',
        cast(date'2025-01-01' as timestamp),             timestamp'9999-12-31 05:00:00');

create or replace table prod_execution_rs.ext_pdm.fact_invest_account_sub_account (
    invest_sub_acct_id_nk string,
    invest_acct_id        string,
    edh_record_status_in  string,
    edh_record_start_ts   timestamp,
    edh_record_end_ts     timestamp
);

insert into prod_execution_rs.ext_pdm.fact_invest_account_sub_account values
    ('SA1001', 'SA1001', 'A',
        cast(add_months(current_date, -5) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1002', 'SA1002', 'A',
        cast(date'2025-09-15' as timestamp),             timestamp'9999-12-31 05:00:00'),
    ('SA1003', 'SA1003', 'A',
        cast(add_months(current_date, -2) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1004', 'SA1004', 'A',
        cast(add_months(current_date, -7) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1005', 'SA1005', 'A',
        cast(add_months(current_date, -1) as timestamp), timestamp'9999-12-31 05:00:00');

create or replace table prod_execution_rs.ext_pdm.dim_invest_account (
    invest_acct_id_nk    string,
    invest_acct_cd       string,
    edh_record_status_in string,
    edh_record_start_ts  timestamp,
    edh_record_end_ts    timestamp
);

insert into prod_execution_rs.ext_pdm.dim_invest_account values
    ('SA1001', 'WM', 'A',
        cast(add_months(current_date, -5) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1002', 'WM', 'A',
        cast(date'2025-09-15' as timestamp),             timestamp'9999-12-31 05:00:00'),
    ('SA1003', 'WM', 'A',
        cast(add_months(current_date, -2) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1004', 'WM', 'A',
        cast(add_months(current_date, -7) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1005', 'WM', 'A',
        cast(add_months(current_date, -1) as timestamp), timestamp'9999-12-31 05:00:00');

-- NB: the misspelled column `prodcuer_role_cd_desc` is intentional -- it
-- matches the real source, and stg_pdm__invest_account_producer renames it.
create or replace table prod_execution_rs.ext_pdm.fact_invest_account_producer_role (
    invest_acct_id_nk     string,
    invest_acct_cd        string,
    producer_id_nk        string,
    prodcuer_role_cd_desc string,
    edh_record_status_in  string,
    edh_record_start_ts   timestamp,
    edh_record_end_ts     timestamp
);

insert into prod_execution_rs.ext_pdm.fact_invest_account_producer_role values
    ('SA1001', 'WM', 'PR02', 'ORIGINAL PRODUCER',  'A',
        cast(add_months(current_date, -5) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1002', 'WM', 'PR01', 'ORIGINAL PRODUCER',  'A',
        cast(date'2025-09-15' as timestamp),             timestamp'9999-12-31 05:00:00'),
    ('SA1003', 'WM', 'PR03', 'ORIGINAL PRODUCER',  'A',
        cast(add_months(current_date, -2) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1004', 'WM', 'PR04', 'PRODUCER OF RECORD', 'A',
        cast(add_months(current_date, -7) as timestamp), timestamp'9999-12-31 05:00:00'),
    ('SA1005', 'WM', 'PR05', 'PRODUCER OF RECORD', 'A',
        cast(add_months(current_date, -1) as timestamp), timestamp'9999-12-31 05:00:00');

-- ----------------------------------------------------------------------------
-- 6. dim_product : plan_cd_nk matches every plan_cd used above; ln/grp/nm
--    values line up with seeds/product_category_map.csv (MWP01 hits the exact
--    product_nm row, everything else falls back to the '*' wildcard).
-- ----------------------------------------------------------------------------
--    No history here on purpose. Product recategorisation is already exercised
--    by the plan_cd changes on C1001 / C1002 / C2001 in dim_contract, and
--    changing product_grp_nm or product_nm mid-history would also change which
--    seeds/product_category_map.csv row matches -- an unrelated variable that
--    would make a backfill diff hard to attribute.
create or replace table prod_execution_rs.ext_pdm.dim_product (
    plan_cd_nk           string,
    product_ln_cd        string,
    product_grp_nm       string,
    product_nm           string,
    edh_record_status_in string,
    edh_record_start_ts  timestamp,
    edh_record_end_ts    timestamp
);

insert into prod_execution_rs.ext_pdm.dim_product
select
    plan_cd_nk, product_ln_cd, product_grp_nm, product_nm, 'A',
    -- Products predate every contract, so they are visible in any backfill.
    cast(date'2023-01-01' as timestamp),
    timestamp'9999-12-31 05:00:00'
from values
    ('WL100', 'LIFE',       'WHOLE LIFE',               'WHOLE LIFE CLASSIC'),
    ('LT100', 'LIFE',       'LEVEL TERM',               'LEVEL TERM 20'),
    ('YRT10', 'LIFE',       'YEARLY RENEWABLE TERM',    'YEARLY RENEWABLE TERM 10'),
    ('UL100', 'LIFE',       'UNIVERSAL LIFE',           'CUSTOM UNIVERSAL LIFE 100'),
    ('MWP01', 'LIFE',       'VARIABLE LIFE',            'NEW YORK LIFE MARKET WEALTH PLUS'),
    ('VA100', 'ANNUITY',    'VARIABLE DEFERRED',        'VA FLEX CHOICE'),
    ('FA100', 'ANNUITY',    'FIXED DEFERRED',           'SECURE TERM MVA'),
    ('GIA01', 'ANNUITY',    'GUARANTEED INCOME ANNUITY','GUARANTEED LIFETIME INCOME'),
    ('LTC01', 'LTC',        'LTC 6.0',                  'NYL SECURE CARE'),
    ('IDI01', 'IDI',        'MY INCOME PROTECTOR',      'MY INCOME PROTECTOR'),
    ('EAG01', 'INVESTMENT', 'EAGLE',                    'EAGLE STRATEGIES ADVISORY'),
    ('SEC01', 'INVESTMENT', 'SECURITIES',               'NYLIFE SECURITIES BROKERAGE'),
    ('MF001', 'INVESTMENT', 'MUTUAL FUNDS',             'MAINSTAY FUNDS')
    as t(plan_cd_nk, product_ln_cd, product_grp_nm, product_nm);

-- ----------------------------------------------------------------------------
-- 7. Policy-owner fact : active clients (status 1-3) at each of the last six
--    month-ends, keyed the way int_clients__active_eop expects
--    (dt_key = yyyyMMdd of the month end). CL012 is status 5 -> excluded.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_metrics_marketplace.metrics359.rpt_fct_mk_cnt_cmpnt_po_all (
    po_client_id     string,
    dt_key           string,
    dim_po_status_sk int
);

insert into prod_execution_metrics_marketplace.metrics359.rpt_fct_mk_cnt_cmpnt_po_all
select
    c.client_id,
    date_format(last_day(add_months(current_date, -1 - m.n)), 'yyyyMMdd'),
    c.status
from (
    select stack(11,
        'CL001', 1, 'CL002', 1, 'CL003', 2, 'CL004', 1, 'CL005', 3,
        'CL006', 1, 'CL007', 2, 'CL008', 1, 'CL009', 1, 'CL010', 1,
        'CL012', 5
    ) as (client_id, status)
) c
cross join (select explode(sequence(0, 5)) as n) m;

-- ----------------------------------------------------------------------------
-- 8. CRM sf_account : salesforce id -> CASE client id crosswalk.
--    The null / empty rows are dropped by stg_crm__sf_account.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_datalake.lake_int_crm_salescentral.sf_account (
    acct_id_nk string,
    case_cl_id string
);

insert into prod_execution_datalake.lake_int_crm_salescentral.sf_account values
    ('SF001', 'CL001'),
    ('SF002', 'CL002'),
    ('SF003', 'CL003'),
    ('SF004', 'CL007'),
    ('SF098', null),
    ('SF099', '');

-- ----------------------------------------------------------------------------
-- 9. Guided Meeting plan dates. type 'FB' rows are excluded by staging.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_fieldexperience.digital.mt__gm_ppg_plan_dates (
    salesforce_id     string,
    completed_plan_dt date,
    type              string
);

insert into prod_execution_fieldexperience.digital.mt__gm_ppg_plan_dates values
    ('SF001', add_months(current_date, -4), 'GM'),
    ('SF002', add_months(current_date, -6), 'GM'),
    ('SF003', date'2025-12-01',             'FB'),
    ('SF004', add_months(current_date, -1), 'GM');

-- ----------------------------------------------------------------------------
-- 10. Fee-based FP plans. CL001 appears here AND via GM (SF001) so at least
--     one client gets gm_flag = fp_flag = 'Y'.
-- ----------------------------------------------------------------------------
create or replace table prod_builder_fieldexperience.fx_test.ppg_feebased_fp_plans_by_agent (
    client_id         string,
    completed_plan_dt date
);

insert into prod_builder_fieldexperience.fx_test.ppg_feebased_fp_plans_by_agent values
    ('CL003', add_months(current_date, -5)),
    ('CL005', add_months(current_date, -3)),
    ('CL001', add_months(current_date, -2));

-- ----------------------------------------------------------------------------
-- 11. Legacy history : created empty. Only read when
--     var('include_historical_load') = true.
-- ----------------------------------------------------------------------------
create table if not exists prod_builder_fieldexperience.ppg.ppg_metrics_dtl_hist (
    snapshot_date                                      date,
    month_end_date                                     date,
    lob_nm                                             string,
    primry_ownr_cl_id                                  string,
    cnt_id_nk                                          string,
    cnt_eff_dt                                         date,
    producer_id_nk                                     string,
    product_category_protection_accumulation_alternate string,
    product_category_need_based_by_product             string,
    product_category_risk_wm                           string,
    product_type                                       string,
    risk_management_ind                                string,
    wealth_management_ind                              string,
    gm_flag                                            string,
    fp_flag                                            string,
    gm_or_fp_flag                                      string
);
