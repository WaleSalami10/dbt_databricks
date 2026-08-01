# PPG pipeline, as dbt

Refactor of the PPG Monthly Load notebook. Covers cells 1 and 2:

- **Cell 1** — `create or replace table … ppg_stg_cnt_prd_mapping`
- **Cell 2** — `insert into … ppg_metrics_dtl`
- **Cell 3** — `insert into … ppg_metrics_monthly`
- **Cell 4** — `insert into … ppg_metrics_summ_monthly`

All four cells are modelled.

## Setup

```bash
dbt deps          # dbt_utils, needed for the grain tests
dbt seed
dbt build
```

Backfill a specific day:

```bash
dbt build --vars '{snapshot_date: "2026-06-14"}'
```

## CTE to model mapping

### Cell 1 -> `ppg_stg_cnt_prd_mapping`

| Original CTE | Model |
|---|---|
| `dates` | `stg_pdm__dates` |
| `core_contracts` | `int_contracts__scoped` |
| `core_clients` | `int_owners__by_contract` |
| `core` (3 x union all) | `int_contracts__with_producer` |
| `wm_accounts` | `int_wm_accounts` |
| `wm_clients` | `int_owners__by_invest_acct` |
| `wm` (2 x union all) | `int_wm_accounts__with_producer` |
| `core_wm` | `int_products__unified` |
| `core_wm_client_product` | `int_products__categorized` |
| final select | `ppg_stg_cnt_prd_mapping` |

The four ~300-line `CASE` expressions became `seeds/product_category_map.csv`.

### Cell 2 -> `ppg_metrics_dtl`

| Original CTE | Model |
|---|---|
| `dates` | `stg_pdm__ytd_dates` |
| `base_all` | `int_metrics__base_all` |
| `get_active_cl_eop` | `int_clients__active_eop` |
| `clients_with_planning` + `clients_with_planning_v2` | `int_clients__planning_flags` (+ `int_planning__gm_clients`, `int_planning__fp_clients`) |
| final select | `ppg_metrics_dtl` |

### Cell 3 -> `ppg_metrics_monthly`

| Original CTE | Model |
|---|---|
| `dates` | `stg_pdm__ytd_dates` (reused) |
| final select | `ppg_metrics_monthly` |
| commented-out `ppg_metrics_dtl_hist` union | same model, behind `include_historical_load` |

### Cell 4 -> `ppg_metrics_summ_monthly`

| Original CTE | Model |
|---|---|
| `dates` | `stg_pdm__ytd_dates` (reused) |
| `sales` | `int_summ__sales` |
| `active_clients` | `int_summ__active_clients` |
| `base` | `int_summ__client_breadth_depth` |
| `breadth_depth` | `int_summ__breadth_depth` |
| final select | `ppg_metrics_summ_monthly` |

The sf_account to `mt__gm_ppg_plan_dates` join appeared **three times** in cell 2
and the fee-based subquery **twice**. Both are now defined once. The two
planning CTEs collapse into one conditional aggregate: the original built a
union and then left-joined back to two more copies of the same subqueries purely
to determine which side each client came from.

## ppg_metrics_monthly is a leaf node

Cell 4 reads `ppg_metrics_dtl` directly. It does **not** read
`ppg_metrics_monthly`. Nothing else in the notebook does either, so within this
project `ppg_metrics_monthly` is a leaf: built every month, consumed by nothing
that is version-controlled here.

That does not make it dead -- a dashboard or an extract almost certainly points
at it, which is exactly the kind of dependency that does not show up in a
notebook. But it is worth confirming, because it is the cheapest thing in the
pipeline to delete if nothing reads it, and the most dangerous to change blindly
if something does. Check the table's query history before you touch it.

## Is cell 3 still needed?

Yes, but not for the reason it was written.

Structurally, `ppg_metrics_monthly` is `ppg_metrics_dtl` with two columns
dropped -- `cnt_iss_cd_nk` and `producer_cnt_role_nm` -- and `distinct` applied.
Everything else is identical, column for column.

**The month filter is now redundant.** The original's
`INNER JOIN dates dt ON dt.ytd_end_dt = month_end_date` existed to pick which
single month to append to an accumulating table. That is what dbt's incremental
partition config does. Cell 3's join is preserved in the model, but as an
idempotency guard rather than as load logic.

**The grain reduction is the real content, and it is load-bearing.** Dropping
those two columns and deduplicating means a contract that exists under two
issue codes, or with one producer recorded under two roles, collapses to a
single row. Counting contracts in `ppg_metrics_dtl` and in
`ppg_metrics_monthly` gives different answers, by design.

Two things follow:

- This dedup is partially masking the producer fan-out flagged in item 4 below.
  It collapses duplicate *roles* but not duplicate *producers*. If you turn on
  `apply_producer_role_filter`, the role half of this dedup becomes a no-op --
  which is the correct end state, because then the grain is explicit rather
  than the accidental output of a `distinct`.
- Dropping `cnt_iss_cd_nk` deserves a second look. It was half the contract key
  in every upstream join, and then it is discarded here. That is only safe if
  `cnt_id_nk` is unique on its own. The grain test on this model is what tells
  you whether it is.

If both were resolved, cell 3 would genuinely collapse to a view. Until then it
is doing real work and should stay a materialized model.

## Read this before running

**1. `base_all` now needs a snapshot filter, and this is not optional.**
The original read `ppg_stg_cnt_prd_mapping` with no date predicate. That was
only safe because cell 1 did `create or replace`, so the table held exactly one
snapshot. The mapping model is now incremental and retains history, so reading
it unfiltered would multiply every metric by the number of retained snapshots.
`int_metrics__base_all` filters to the run's snapshot_date. If you revert the
mapping model to a full rebuild, that filter becomes a no-op and stays correct
either way.

**2. Two independent month-end computations.** Cell 1 anchors on
`CURRENT_DATE` and derives `mth_begin_dt - 1`. Cell 2 anchors on
`ADD_MONTHS(CURRENT_DATE, -1)` and reads `mth_end_dt` directly. They agree on
every date I checked, including month-length edge cases, but nothing enforced
that. `stg_pdm__ytd_dates` now carries a `relationships` test against
`stg_pdm__dates.month_end_date` that fails the build if they ever diverge.

**3. Planning flags were NULL, not 'N'.** In the original, the
`pln.Completed_Plan_Dt <= base.month_end_date` predicate sits in the `LEFT JOIN`
ON clause, so a client whose plan completed *after* the reporting month gets
NULL for all three flags, identical to a client with no plan at all. Anything
downstream doing `where gm_flag = 'N'` silently drops both groups. Default is
now `coalesce(..., 'N')`; set `coalesce_planning_flags: false` to reproduce the
original NULLs. **Check cells 3 and 4 for `= 'N'` predicates before flipping
this either way.**

**4. The producer role filters are still off.** Every
`-- and cp.producer_cnt_role_nm = '...'` line is preserved as
`apply_producer_role_filter: false`. Flip to `true` to activate
`seeds/lob_producer_role.csv`. Until then the grain tests on
`int_products__unified` and `ppg_metrics_dtl` will likely fail, which is the
point: `select distinct` was hiding producer fan-out, and if a contract carries
three producers in three roles you are counting it three times in the metrics.

**5. `int_owners__*` partition by only `cnt_acct_id_nk`** but join downstream on
`cnt_acct_id_nk` *and* `iss_cd_nk`. If an account id exists under two issue
codes, one is silently dropped. Pass `partition_by_iss_cd=true` to the macro to
fix. Left off to match today's output.

**6. `dim_invest_account` join looks wrong.** The original was
`on acc.invest_sub_acct_id_nk = prnt.invest_acct_id_nk`, a *sub*-account id
matched to an *account* id. Preserved verbatim; worth confirming it is not meant
to be `acc.invest_acct_id`.

**7. `ppg_feebased_fp_plans_by_agent` is declared as a source** but lives in
`prod_builder_fieldexperience.fx_test`, the same schema this pipeline writes to.
If another notebook builds it, that notebook should become a dbt model and this
should become a `ref()`, otherwise dbt cannot order the two correctly.

**8. The depth rule is coupled to the seed by string equality.**
`int_summ__client_breadth_depth` collapses all term products into one unit, so a
client with five term policies and two whole life contracts has depth 3, not 7.
It identifies term products by matching two literal `product_type` strings that
`product_category_map.csv` emits. Rename either one in the seed and the depth
rule silently stops collapsing -- depth jumps for every term-holding client, with
no error. The strings now live in `var('depth_collapse_product_types')` and
`tests/assert_depth_collapse_types_exist.sql` fails the build if the seed stops
producing them.

**9. `ytd_begin_dt` was computed in all three date CTEs and never used.**
Cell 4's YTD filter was written as
`YEAR(cnt_eff_dt) = YEAR(month_end_date) AND cnt_eff_dt <= month_end_date`,
which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and ytd_end_dt`
but wraps the column in a function so no partition can prune. `int_summ__sales`
uses the sargable form. Same rows, less scanned.

**10. Seed transcription.** `product_category_map.csv` was read off photographs.
Diff it against the notebook before relying on it, particularly the 24-value
LIFE `product_grp_nm` list that repeats four times in the original with small
variations between repetitions.

## Grain

- `ppg_stg_cnt_prd_mapping`: one row per `snapshot_date + cnt_id_nk +
  cnt_iss_cd_nk + producer_id_nk`
- `ppg_metrics_dtl`: one row per `month_end_date + cnt_id_nk + cnt_iss_cd_nk +
  producer_id_nk`
- `ppg_metrics_monthly`: one row per `month_end_date + cnt_id_nk +
  producer_id_nk`
- `ppg_metrics_summ_monthly`: one row per `month_end_date`

Both contract-level grains include `producer_id_nk`. If the business definition
is one row per contract, item 4 needs resolving and the unique keys should drop
that column, otherwise contract counts double wherever a contract has multiple
producers.

**Cell 4 partly answers the `cnt_iss_cd_nk` question from earlier.** Its depth
calculation counts `distinct cnt_id_nk` with no issue code, and cell 3 drops the
column entirely. Two of the four cells therefore already assume `cnt_id_nk` is
unique on its own. If that assumption is wrong, depth is understated -- two
contracts sharing an id under different issue codes count once. The grain test
on `ppg_metrics_monthly` is the cheapest way to find out.

Note also that the producer fan-out in item 4 does **not** reach
`ppg_metrics_summ_monthly`: every figure there is a `count(distinct client)` or a
`count(distinct contract)`, so duplicate producer rows collapse. The summary is
safe; the two detail tables are the ones to check.

## Historical load

The commented-out `ppg_metrics_dtl_hist` union in cell 3, including its
double-commented `>= '2025-01-01'` predicate, is preserved behind vars:

```bash
dbt run -s ppg_metrics_monthly --full-refresh \
  --vars '{include_historical_load: true, historical_load_from: "2025-01-01"}'
```

Run it once to fold the legacy partitions in, then set it back to false.
Leaving it on makes every incremental run rescan the legacy table.
