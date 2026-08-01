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

-- ----------------------------------------------------------------------------
-- 2. dim_contract : insurance contracts.
--    Scope filter keeps LIFE INSURANCE / ANNUITIES / LONG TERM CARE, or
--    cnt_iss_cd_nk = 'IDI'. C9001 (GROUP INSURANCE) and C9002 (edh status 'D')
--    exist to prove the filters work.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_rs.ext_pdm.dim_contract (
    cnt_id_nk            string,
    cnt_iss_cd_nk        string,
    plan_cd              string,
    lob_nm               string,
    cnt_eff_dt           date,
    edh_record_status_in string
);

insert into prod_execution_rs.ext_pdm.dim_contract values
    ('C1001', 'NYL', 'WL100', 'LIFE INSURANCE', date'2024-03-15', 'A'),
    ('C1002', 'NYL', 'LT100', 'LIFE INSURANCE', add_months(current_date, -6), 'A'),
    ('C1003', 'NYL', 'YRT10', 'LIFE INSURANCE', add_months(current_date, -5), 'A'),
    ('C1004', 'NYL', 'UL100', 'LIFE INSURANCE', add_months(current_date, -9), 'A'),
    ('C1005', 'NYL', 'MWP01', 'LIFE INSURANCE', add_months(current_date, -3), 'A'),
    ('C2001', 'NYL', 'VA100', 'ANNUITIES',      add_months(current_date, -7), 'A'),
    ('C2002', 'NYL', 'FA100', 'ANNUITIES',      date'2025-06-30',             'A'),
    ('C2003', 'NYL', 'GIA01', 'ANNUITIES',      add_months(current_date, -4), 'A'),
    ('C3001', 'NYL', 'LTC01', 'LONG TERM CARE', add_months(current_date, -2), 'A'),
    ('C4001', 'IDI', 'IDI01', 'DISABILITY',     add_months(current_date, -6), 'A'),
    ('C9001', 'NYL', 'WL100', 'GROUP INSURANCE', date'2024-01-10', 'A'),
    ('C9002', 'NYL', 'WL100', 'LIFE INSURANCE',  date'2024-02-10', 'D');

-- ----------------------------------------------------------------------------
-- 3. fact_primary_owner_derv : one owner per contract / invest account.
--    C1001 has a second, later owner row (CL011) to exercise the
--    dedupe_primary_owner window.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_rs.ext_pdm.fact_primary_owner_derv (
    cnt_acct_id_nk             string,
    iss_cd_nk                  string,
    primry_ownr_cl_id          string,
    primry_ownr_cl_role_eff_dt date,
    rec_tp_cd                  string,
    edh_record_status_in       string
);

insert into prod_execution_rs.ext_pdm.fact_primary_owner_derv values
    ('C1001',  'NYL', 'CL001', date'2024-03-15', 'CONTRACT',    'A'),
    ('C1001',  'NYL', 'CL011', date'2025-01-01', 'CONTRACT',    'A'),
    ('C1002',  'NYL', 'CL002', date'2026-02-10', 'CONTRACT',    'A'),
    ('C1003',  'NYL', 'CL002', date'2026-03-05', 'CONTRACT',    'A'),
    ('C1004',  'NYL', 'CL003', date'2025-11-20', 'CONTRACT',    'A'),
    ('C1005',  'NYL', 'CL004', date'2026-05-01', 'CONTRACT',    'A'),
    ('C2001',  'NYL', 'CL005', date'2026-01-15', 'CONTRACT',    'A'),
    ('C2002',  'NYL', 'CL006', date'2025-06-30', 'CONTRACT',    'A'),
    ('C2003',  'NYL', 'CL001', date'2026-04-12', 'CONTRACT',    'A'),
    ('C3001',  'NYL', 'CL007', date'2026-06-18', 'CONTRACT',    'A'),
    ('C4001',  'IDI', 'CL008', date'2026-02-25', 'CONTRACT',    'A'),
    ('C9001',  'NYL', 'CL009', date'2024-01-10', 'CONTRACT',    'A'),
    ('SA1001', 'WM',  'CL003', date'2026-03-01', 'INVEST_ACCT', 'A'),
    ('SA1002', 'WM',  'CL004', date'2025-09-15', 'INVEST_ACCT', 'A'),
    ('SA1003', 'WM',  'CL005', date'2026-06-10', 'INVEST_ACCT', 'A'),
    ('SA1004', 'WM',  'CL001', date'2026-01-20', 'INVEST_ACCT', 'A'),
    ('SA1005', 'WM',  'CL002', date'2026-07-02', 'INVEST_ACCT', 'A');

-- ----------------------------------------------------------------------------
-- 4. fact_contract_cmpnt_producer : contract producers.
--    C1001 carries two roles so pick_producer() / the fan-out behaviour is
--    observable either way the apply_producer_role_filter var is set.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_rs.ext_pdm.fact_contract_cmpnt_producer (
    cnt_id_nk            string,
    cnt_iss_cd_nk        string,
    producer_id_nk       string,
    producer_cnt_role_nm string,
    edh_record_status_in string
);

insert into prod_execution_rs.ext_pdm.fact_contract_cmpnt_producer values
    ('C1001', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A'),
    ('C1001', 'NYL', 'PR02', 'ALTERNATE SERVICING PRODUCER', 'A'),
    ('C1002', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A'),
    ('C1003', 'NYL', 'PR02', 'ORIGINAL PRODUCER',            'A'),
    ('C1004', 'NYL', 'PR03', 'ORIGINAL PRODUCER',            'A'),
    ('C1005', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A'),
    ('C2001', 'NYL', 'PR02', 'ORIGINAL PRODUCER',            'A'),
    ('C2002', 'NYL', 'PR03', 'ORIGINAL PRODUCER',            'A'),
    ('C2003', 'NYL', 'PR01', 'ORIGINAL PRODUCER',            'A'),
    ('C3001', 'NYL', 'PR04', 'PERMANENT SERVICING PRODUCER', 'A'),
    ('C4001', 'IDI', 'PR05', 'UNKNOWN',                      'A');

-- ----------------------------------------------------------------------------
-- 5. Investment side. int_wm_accounts joins
--    dim_invest_account.invest_acct_id_nk = fact_...sub_account.invest_sub_acct_id_nk,
--    so account ids deliberately reuse the sub-account ids.
--    SA9001 (product OTHERFUND) is filtered out by stg_pdm__invest_sub_account.
-- ----------------------------------------------------------------------------
create or replace table prod_execution_rs.ext_pdm.dim_invest_sub_account (
    invest_sub_acct_id_nk     string,
    invest_sub_acct_iss_cd_nk string,
    invest_sub_acct_eff_dt    date,
    plan_cd                   string,
    product_nm                string,
    edh_record_status_in      string
);

insert into prod_execution_rs.ext_pdm.dim_invest_sub_account values
    ('SA1001', 'WM', add_months(current_date, -5), 'EAG01', 'EAGLE',      'A'),
    ('SA1002', 'WM', date'2025-09-15',             'SEC01', 'NYLIFE SEC', 'A'),
    ('SA1003', 'WM', add_months(current_date, -2), 'MF001', 'MAINSTAY',   'A'),
    ('SA1004', 'WM', add_months(current_date, -7), 'MF001', 'NP MUTFNDS', 'A'),
    ('SA1005', 'WM', add_months(current_date, -1), 'MF001', 'NP529',      'A'),
    ('SA9001', 'WM', date'2025-01-01',             'MF001', 'OTHERFUND',  'A');

create or replace table prod_execution_rs.ext_pdm.fact_invest_account_sub_account (
    invest_sub_acct_id_nk string,
    invest_acct_id        string,
    edh_record_status_in  string
);

insert into prod_execution_rs.ext_pdm.fact_invest_account_sub_account values
    ('SA1001', 'SA1001', 'A'),
    ('SA1002', 'SA1002', 'A'),
    ('SA1003', 'SA1003', 'A'),
    ('SA1004', 'SA1004', 'A'),
    ('SA1005', 'SA1005', 'A');

create or replace table prod_execution_rs.ext_pdm.dim_invest_account (
    invest_acct_id_nk    string,
    invest_acct_cd       string,
    edh_record_status_in string
);

insert into prod_execution_rs.ext_pdm.dim_invest_account values
    ('SA1001', 'WM', 'A'),
    ('SA1002', 'WM', 'A'),
    ('SA1003', 'WM', 'A'),
    ('SA1004', 'WM', 'A'),
    ('SA1005', 'WM', 'A');

-- NB: the misspelled column `prodcuer_role_cd_desc` is intentional -- it
-- matches the real source, and stg_pdm__invest_account_producer renames it.
create or replace table prod_execution_rs.ext_pdm.fact_invest_account_producer_role (
    invest_acct_id_nk     string,
    invest_acct_cd        string,
    producer_id_nk        string,
    prodcuer_role_cd_desc string,
    edh_record_status_in  string
);

insert into prod_execution_rs.ext_pdm.fact_invest_account_producer_role values
    ('SA1001', 'WM', 'PR02', 'ORIGINAL PRODUCER',  'A'),
    ('SA1002', 'WM', 'PR01', 'ORIGINAL PRODUCER',  'A'),
    ('SA1003', 'WM', 'PR03', 'ORIGINAL PRODUCER',  'A'),
    ('SA1004', 'WM', 'PR04', 'PRODUCER OF RECORD', 'A'),
    ('SA1005', 'WM', 'PR05', 'PRODUCER OF RECORD', 'A');

-- ----------------------------------------------------------------------------
-- 6. dim_product : plan_cd_nk matches every plan_cd used above; ln/grp/nm
--    values line up with seeds/product_category_map.csv (MWP01 hits the exact
--    product_nm row, everything else falls back to the '*' wildcard).
-- ----------------------------------------------------------------------------
create or replace table prod_execution_rs.ext_pdm.dim_product (
    plan_cd_nk           string,
    product_ln_cd        string,
    product_grp_nm       string,
    product_nm           string,
    edh_record_status_in string
);

insert into prod_execution_rs.ext_pdm.dim_product values
    ('WL100', 'LIFE',       'WHOLE LIFE',               'WHOLE LIFE CLASSIC',              'A'),
    ('LT100', 'LIFE',       'LEVEL TERM',               'LEVEL TERM 20',                   'A'),
    ('YRT10', 'LIFE',       'YEARLY RENEWABLE TERM',    'YEARLY RENEWABLE TERM 10',        'A'),
    ('UL100', 'LIFE',       'UNIVERSAL LIFE',           'CUSTOM UNIVERSAL LIFE 100',       'A'),
    ('MWP01', 'LIFE',       'VARIABLE LIFE',            'NEW YORK LIFE MARKET WEALTH PLUS','A'),
    ('VA100', 'ANNUITY',    'VARIABLE DEFERRED',        'VA FLEX CHOICE',                  'A'),
    ('FA100', 'ANNUITY',    'FIXED DEFERRED',           'SECURE TERM MVA',                 'A'),
    ('GIA01', 'ANNUITY',    'GUARANTEED INCOME ANNUITY','GUARANTEED LIFETIME INCOME',      'A'),
    ('LTC01', 'LTC',        'LTC 6.0',                  'NYL SECURE CARE',                 'A'),
    ('IDI01', 'IDI',        'MY INCOME PROTECTOR',      'MY INCOME PROTECTOR',             'A'),
    ('EAG01', 'INVESTMENT', 'EAGLE',                    'EAGLE STRATEGIES ADVISORY',       'A'),
    ('SEC01', 'INVESTMENT', 'SECURITIES',               'NYLIFE SECURITIES BROKERAGE',     'A'),
    ('MF001', 'INVESTMENT', 'MUTUAL FUNDS',             'MAINSTAY FUNDS',                  'A');

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
