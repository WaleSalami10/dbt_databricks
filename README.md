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
dbt build         # builds the most recent complete month
```

Build a specific month. Any day inside the month works — the month end is
resolved from `dim_date`, so these three are the same command:

```bash
dbt build --vars '{report_month: "2026-06-01"}'
dbt build --vars '{report_month: "2026-06-14"}'
dbt build --vars '{report_month: "2026-06-30"}'
```

A **past** month is refused unless `pdm_history_mode` is also set — see
[Getting history](#getting-history-of-ppg_stg_cnt_prd_mapping). That refusal is
the point: without it the backfill silently succeeds and is wrong.

## This is a monthly report

It was previously anchored on a **day**, and that mismatch was structural rather
than cosmetic.

Both date CTEs in the original always collapsed to the same previous month end
no matter which day they ran — cell 1 computed `mth_begin_dt - 1` from
`CURRENT_DATE`, cell 2 read `mth_end_dt` from `ADD_MONTHS(CURRENT_DATE, -1)`.
Every mart is partitioned by `month_end_date`. Only `ppg_stg_cnt_prd_mapping`
was partitioned by a daily `snapshot_date`, which meant:

- roughly 30 partitions per reporting month, all describing the same month;
- a rerun on a different day quietly changed an already-published month, because
  `int_metrics__base_all` filtered the mapping table to `snapshot_date =
  current_date`;
- that same filter coupled the marts to the mapping model having run **today** —
  cross midnight between the two and the month came out empty, with no error;
- "backfill a missed day", which is not a thing a monthly report has.

Now: `var('report_month')` selects the month, `stg_pdm__dates` is the single
date spine, and `ppg_stg_cnt_prd_mapping` is partitioned and keyed on
`month_end_date` like everything else.

`snapshot_date` survives as an **audit column** — when PDM was observed, not
what is being reported. It is not a key and nothing joins on it. The two dates
are separate on purpose (`macros/report_dates.sql`): in `current` mode a report
built on 4 August for the July month end reads 4 August's contracts, so
`snapshot_date` is what tells you the month was captured four days late.
`tests/assert_snapshot_is_month_end.sql` warns with the drift in days.

`stg_pdm__ytd_dates` is now a renaming view over the spine rather than a second
independent computation of the month end, so the `relationships` test that
guarded the two against drifting apart is gone — there is nothing left to drift.

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

## Getting history of ppg_stg_cnt_prd_mapping

`edh_record_status_in` cannot give you this, and it is worth being precise about
why: it is a **current-state flag, not a temporal one**. `'A'` means "this is the
row that is live right now". Filtering to `'I'` does not give you rows that were
alive last month -- it gives you rows that are dead now, with no indication of
when they died. Point-in-time reconstruction needs a validity *interval* per row.
No combination of status values can synthesise one.

### The trap this exposed

Before this change, only the date spine moved with the run date. Every PDM
staging model was pinned to current state, so

```bash
dbt build --vars '{report_month: "2026-06-30"}'
```

produced **today's** contracts, owners and producers stamped with June's month
end and written into June's partition. It looked plausible and passed every
test. `tests/assert_backfill_is_honest.sql` now fails the build in exactly that
case.

**The same defect affects the normal run, at smaller scale.** In `current` mode
a report built on 5 August for July reads 5 August's state: five days of new
business, lapses and producer reassignments leak into July. That is how the
notebook always behaved, so `tests/assert_snapshot_is_month_end.sql` warns
rather than fails — but it means a month rerun a week later gives a different
answer.

### Delta time travel is not available

It is not enabled on the PDM sources, so there is no version log to read as of a
past month end. The `time_travel` mode has been removed rather than left in
place to fail at runtime.

This narrows the problem sharply, and it is worth being blunt about why. Time
travel was the only option that needed **no modelling work** and could still
reach **backwards**. Without it there are exactly two outcomes:

- the PDM tables are Type 2, and everything is recoverable; or
- they are not, and history begins the first time you run `dbt snapshot`.

There is no third path. No month that has already passed is recoverable in the
second case, and the gap grows by one month every month the decision is
deferred.

### Step 1: the validity columns exist

All eight PDM tables carry **`edh_record_start_ts` / `edh_record_end_ts`**.
These are *record* validity timestamps — when a version of the row was true —
which is the kind that reconstructs history, as opposed to business dates like
`cnt_eff_dt`. They are set as `pdm_eff_col` / `pdm_exp_col` in
`dbt_project.yml`, so `scd2` mode is wired and ready to use.

**Having the columns is not the same as having the history.** A table can carry
validity columns and still hold one row per key, if the loader overwrites
instead of versioning. In that case the as-of predicate matches the single
current row for every past month, and a backfill of March returns today's
contracts — silently, with every downstream test passing. That is the same
failure `assert_backfill_is_honest.sql` prevents in `current` mode, coming back
through the mode meant to fix it, which is why the default is still `current`.

### Step 2: confirm versions are actually retained

This is now the only open question. Run `analyses/diagnose_pdm_history.sql` —
it is executable SQL, not a checklist. The decisive query is rows-per-key on
`dim_contract`: above 1.0 means versions are retained, exactly 1.0 means the
columns are decorative. `tests/assert_pdm_retains_versions.sql` enforces the
same threshold on every `scd2` run, so if you flip the mode on a table that
does not version, the build fails instead of quietly lying.

### `edh_record_status_in` must not be combined with the interval

This is settled and worth stating plainly, because it looks like a bug and
someone will eventually try to "fix" it.

Measured across the whole table, `'A'` **never appears on a closed version**
(step 3b: `closed_but_active = 0`). Every superseded version is stamped `'I'`
when the next one is written, so the flag marks *the latest version*, not a
business status recorded per version.

So `scd2` mode filters on the validity interval **alone**. Adding
`and edh_record_status_in = 'A'` would select "the version live at the as-of
instant *and* the current version", which for any past month is either nothing
or today's row — the exact failure the mode exists to prevent, arriving
silently with all tests green.

**The cost of that finding:** business active/inactive status as of a past month
is *not recoverable from PDM*. It was never stored per version. "Was this
contract active in March" cannot be answered from this table by any query, and
would need a different source. Worth knowing before someone promises it.

Step 3c closed the remaining question: **only `'A'` appears on open-ended
versions**, so `edh_record_status_in = 'A'` is *exactly* equivalent to
`edh_record_end_ts >= '9999-01-01'`. The flag is a redundant restatement of the
interval. Two things follow:

- **The switch to `scd2` loses no filtering.** `current` and `scd2` return
  identical rows for the current month, so the reconciliation should match to
  the row. Any difference is the session timezone or the interval convention,
  not the status flag.
- **`'A'` never excluded lapsed or cancelled contracts.** It only ever picked
  the latest version. Nothing upstream removes terminated business; the
  population is narrowed solely by the join to `int_clients__active_eop`, which
  comes from the metrics marketplace policy-owner fact. If a contract-level
  lapse filter is ever wanted it belongs in `int_contracts__scoped`, and it
  needs a column that carries that meaning — this one does not.

`tests/assert_pdm_status_matches_version.sql` enforces the equivalence, so if
EDH ever introduces a soft-delete the build fails rather than the two modes
drifting apart unnoticed.

Trial it without committing to it:

```bash
dbt build --vars '{pdm_history_mode: scd2, report_month: "2026-06-30"}'
```

and compare the result against the published June figures before flipping the
default in `dbt_project.yml`.

### Step 3: pick a mode

Set `pdm_history_mode` in `dbt_project.yml`.

| Mode | Use when | Reaches back |
|---|---|---|
| `current` | normal run (default) | today only; backfill refused |
| `scd2` | PDM tables are Type 2 | as far as the source retains |
| `snapshot` | source overwrites in place | from the day you start, no earlier |

`scd2` is the real answer and the columns are already configured. Every model
becomes point-in-time with no other change, and it is the only mode that makes
the *normal* monthly run exact rather than merely close.

**Two subtleties, both silent when wrong.** The validity columns are
timestamps, not dates, and comparing them against a bare date —
`edh_record_end_ts > date'2026-06-30'` — casts to `2026-06-30 00:00:00`, asking
for state at the *start* of the month-end day and discarding every change made
during the last day of the month. `pdm_as_of_instant()` in
`macros/report_dates.sql` handles that.

The second is the interval convention. PDM's intervals are **closed with a
one-second gap**, not half-open:

```
I   2019-11-01 04:00:00   2022-01-04 10:57:04
I   2022-01-04 10:57:05   2022-01-05 09:12:06
A   2022-01-05 09:12:07   9999-12-31 05:00:00
```

Each version ends one second *before* the next begins, so the as-of instant is
anchored on `23:59:59` of the month end rather than the next day's midnight. A
midnight anchor would fall in that one-second hole whenever a change is written
on a midnight boundary — and the `04:00:00Z` / `05:00:00Z` values above are
midnight US/Eastern, so this source demonstrably does that. The key would drop
out of the month with no row and no error.

Which also means **the session timezone matters**. `last_day()` resolves in the
session timezone, so a session running in UTC evaluates "end of 30 June" as
`23:59:59Z` = `19:59:59` Eastern, pushing the last four hours of every month
into the next one. Step 0 of the diagnostic checks it; fix it on the profile,
not in the models.

Note that dbt's own snapshot intervals *are* half-open, so the `snapshot` branch
of the macro uses a strict `>` on the upper bound where `scd2` uses `>=`. The
two conventions genuinely differ; this is not an inconsistency.

`snapshot` is the fallback when the source genuinely overwrites. It reaches
back to your first snapshot run and no further, so a backfill of an earlier
month returns **no rows rather than wrong rows** — the right failure, but still
a failure. If this is where you land, start running `dbt snapshot` today rather
than after the next month end, and tell whoever consumes `ppg_metrics_*` that
pre-snapshot months cannot be restated. That is a reporting fact, not an
engineering detail. `snapshots/` contains three: `dim_contract`,
`fact_contract_cmpnt_producer` and `dim_product`. Producer assignments were
prioritised because a servicing reassignment is exactly the kind of edit that
overwrites in place and leaves no trace. Run `dbt snapshot` **daily and before
`dbt build`**, on its own schedule. A missed day is a permanent hole, and
snapshots are append-only — drop the table and the history is gone for good.

Daily matters even though the report is monthly: the snapshot records a change
when it next *sees* it, so an edit made and reverted between runs is invisible,
and a snapshot run only at month end would date every change to month end. The
report grain is monthly; the capture cadence has to be finer than the thing it
is trying to observe.

**`snapshot` mode is a hybrid, and it does not announce itself.** Only those
three tables have snapshots. The other five PDM staging models keep reading the
live source at current state, so a backfilled month has contracts and producers
as they were, but owners, investment accounts and sub-accounts as they are
today. `macros/pdm_as_of.sql` handles this per table rather than emitting
`dbt_valid_from` against tables that have no such column, but the asymmetry is
real: add the missing snapshots before treating a `snapshot`-mode backfill as
audit-grade.

### What you cannot recover

If the diagnostic shows one row per key and no validity columns, **history
before today does not exist at source**, full stop — there is no retention
window to fall back on now that time travel is ruled out. Nothing in dbt can
invent it. Two partial consolations:

- `ppg_metrics_dtl_hist` already holds real PPG history. It cannot rebuild the
  mapping table exactly -- it survived the inner join to active clients, so it
  is a subset, and it lacks `cnt_iss_cd_nk` and `producer_cnt_role_nm` -- but
  step 6 of the diagnostic shows what shape it covers.
- `cnt_eff_dt` lets you reconstruct which contracts *existed* at a past date.
  That captures additions only. A contract that lapsed still appears, and
  product recategorisations are invisible. Useful for counting, not for audit.

### One semantic check before trusting `scd2`

The macro deliberately does **not** also require `edh_record_status_in = 'A'` in
`scd2` mode. In most EDH Type 2 designs that flag marks the latest version of a
key, so ANDing it with the interval collapses back to current state and silently
removes the history. In some designs it means "not soft-deleted" and is safe to
combine. Step 3b of the diagnostic distinguishes them. Get this wrong in the
first direction and your backfill returns current data again.

## Read this before running

**1. `base_all` needs a month filter, and this is not optional.**
The original read `ppg_stg_cnt_prd_mapping` with no date predicate. That was
only safe because cell 1 did `create or replace`, so the table held exactly one
snapshot. The mapping model is now incremental and retains history, so reading
it unfiltered would multiply every metric by the number of retained months.
`int_metrics__base_all` filters to the reporting month. It used to filter on
`snapshot_date = current_date`, which additionally required the mapping model to
have run the same calendar day; filtering on the month removes that coupling and
prunes the same partition.

**2. Two independent month-end computations — resolved.** Cell 1 anchored on
`CURRENT_DATE` and derived `mth_begin_dt - 1`. Cell 2 anchored on
`ADD_MONTHS(CURRENT_DATE, -1)` and read `mth_end_dt` directly. They agreed on
every date I checked, including month-length edge cases, but nothing enforced
that. There is now one date spine and nothing to reconcile. The residual risk
moved rather than vanished: `macros/report_dates.sql` computes the as-of date
with `last_day()` while the partition key comes from `dim_date.mth_end_dt`, so
`tests/assert_month_end_is_calendar.sql` fails the build if `dim_date` is ever
switched to a fiscal calendar.

**2b. `stg_digital__gm_plan_dates` may be missing `where type <> 'FB'`.** The
two copies of this project disagreed and nothing records which is right. If that
source carries `type = 'FB'` rows, fee-based plans are counted on the GM side as
well as the FP side and `gm_plan_sales` is overstated. See the model header for
the query that settles it. This is the only unresolved *logic* question in the
merge.

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

- `ppg_stg_cnt_prd_mapping`: one row per `month_end_date + cnt_id_nk +
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
