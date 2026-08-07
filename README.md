# FOD_query.sql → dbt

A translation of the 182-line `FOD_query.sql` into a layered dbt project.

## The layout

```
sources (a360 mart, read-only)
   │
   ├─ staging/        one thin model per source table: rename, cast, nothing clever
   │     stg_a360__load_control          ← ONE ROW: the report's as-of date
   │     stg_a360__daily_fyc             ← daily commission
   │     stg_a360__daily_paid_cases      ← daily paid cases
   │     stg_a360__product               ← product dim, carries the 'LF' line code
   │     stg_a360__class_history         ← type-2 class windows
   │     stg_a360__marketer_status       ← type-2 contract windows, 9999 sentinel
   │     stg_a360__marketer_dashboard    ← the marketer dim, self-joined in the mart
   │     stg_a360__marketer_appointment  ← original appointment date
   │     stg_a360__org_zone              ← office / zone lookup
   │     stg_a360__title_type            ← title lookup, initcap'd
   │     stg_a360__manpower              ← headcount flags
   │
   ├─ intermediate/   the business logic
   │     int_reporting_periods      ← the `dt` CTE. ONE ROW. everything anchors here
   │     int_fyc_by_marketer        ← the `fyc` CTE
   │     int_paid_cases_by_marketer ← the `prm` CTE
   │     int_class_by_marketer      ← the `class_hist` CTE
   │     int_marketer_contract      ← resolves the 9999 sentinel end date
   │
   └─ marts/
         fct_marketer_production    ← the final SELECT
```

Each CTE in the original became one model. That is the whole idea: instead of a
single 182-line block you can only run start-to-finish, you get six pieces you
can `dbt run --select int_fyc_by_marketer` and inspect on their own.

Staging does renaming, trimming and casting and nothing else. Two places where
that rule shapes the layer:

- **`stg_a360__daily_paid_cases` does not carry the product line.** The line
  code lives on the product dimension, so the join is in
  `int_paid_cases_by_marketer` where the `'LF'` filter also lives.
- **`stg_a360__marketer_status` exposes the contract end date twice**, raw text
  and as a resolved timestamp. Resolving the 9999 sentinel to a *timestamp* is a
  cast; resolving it to *the end of the reporting year* is a business rule, and
  that one stays in `int_marketer_contract`.

## Getting it running

```bash
dbt deps
dbt build                 # seed, run and test in dependency order
```

Or without a connection to the a360 mart at all — see
[Simulating the project](#simulating-the-project) below:

```bash
python scripts/load_dummy_data.py          # once, to load the stand-in tables
dbt build --vars '{use_dummy_data: true}'
```

To check a single piece:

```bash
dbt run  --select int_reporting_periods
dbt show --select int_reporting_periods    # eyeball the calendar before trusting it
dbt build --select +fct_marketer_production # the mart, its parents, and their tests
```

## Simulating the project

The whole project builds against generated data, with no access to
`prod_execution_rs` and no changes to any model:

```bash
python scripts/load_dummy_data.py          # loads 11 tables, ~900 rows
dbt build --vars '{use_dummy_data: true}'
```

`scripts/load_dummy_data.py` creates one stand-in table per real source table,
**with the same table name and the same column types**, in
`<catalog>.<schema>_dummy_a360`. It reads the connection from the same `host` /
`http_path` / `token` / `catalog` / `schema` variables the dbt profile uses, out
of the environment or a `.env` file. `--dry-run` prints the SQL instead of
running it; `--as-of` moves the calendar; `--schema` and `--catalog` move the
target.

`macros/source.sql` overrides dbt's built-in `source()`. With the var on, every
`source('a360', 'x')` resolves to that dummy schema instead of the real mart —
**only the catalog and schema change, never the table name.** Staging models are
unchanged between modes: they say `source()`, and the macro decides what that
means. The flag is read at parse time, so it must come from `--vars` or
`dbt_project.yml`, not mid-run; `dummy_schema` overrides the schema if you need
to read someone else's copy.

**The stand-ins are tables, not dbt seeds.** They replace *sources*, and a
source is something that exists before dbt runs — as seeds they would sit inside
the DAG they are meant to stand outside of, appear in the docs as project-owned
nodes, and get their column types from CSV inference. That last part is not
hypothetical: inference is what turned the status code `'01'` into the integer
`1` and produced a report where nobody was under contract (see
[Testing](#testing)). The loader declares every type in DDL, so the codes are
`string` because the schema says so.

The generator produces 32 marketers in six recruiting downlines, with dates
computed **relative to the as-of date** (default today). Relative rather than
fixed because the report's buckets are current week, prior week and month to
date; hardcoded dates would fall out of every one of those within days and the
buckets would silently read zero. The random seed is fixed, so a reload on the
same day reproduces the same rows.

The data is shaped to exercise the logic rather than to look pretty. Two of the
six recruiters are unreportable — one holds a title absent from
`reportable_titles`, one a dashboard status absent from
`reportable_dashboard_status_codes` — so both downlines should vanish from the
mart. Some marketers are terminated, some are inside their first six months,
and non-life products exist so the `'LF'` filter has something to remove. On the
current data, 32 marketers become 22 rows under 4 recruiters.

`scripts/generate_dummy_data.py` holds the generation logic and the table
definitions. Run it directly to print what would be loaded; it never touches the
warehouse.

Two cautions. `dbt source freshness` reads the source config directly and never
calls the macro, so do not run it in simulated mode. And the two modes should
not share a target schema — the stand-ins are isolated in their own schema, but
the models built on top of them are not.

## Testing

`dbt build --vars '{use_dummy_data: true}'` currently runs 143 tests, all
passing. The interesting ones are not the `not_null`s:

| Test | What it protects |
|---|---|
| `assert_single_reporting_period` | The calendar is exactly one row. Two rows doubles every measure in the mart; zero rows empties it. Neither raises an error on its own. |
| `assert_fyc_ties_to_source` | Per-marketer reconciliation from the mart back to the raw daily table, past six joins and the bucketing macro. |
| `assert_report_is_not_vacuous` | Catches joins that resolve to nothing — see below. |
| `mutually_exclusive_ranges` on both type-2 models | Overlapping windows make the point-in-time class lookup return the wrong row rather than fail. |
| `unique` on `stg_a360__marketer_appointment.mktr_no` | The fan-out the original's `select distinct` was hiding, tested at the layer where it originates. |
| `equal_rowcount` between load control and the calendar | One row in, one row out. |

**Why `assert_report_is_not_vacuous` exists.** During the first simulated build,
the status codes were inferred from CSV as integers, so `01` arrived as `1` and
the join to `active_status_codes` matched nothing. Every marketer came
out with a null contract, every `active_*` flag came out `0`, and every
six-month flag came out `'N'`. **All 181 tests passed.** `not_null`, `unique`,
`accepted_values` and `relationships` are all perfectly satisfied by a column
that is uniformly wrong in the empty direction, and a left join turns a missing
match into a null rather than an error. A report claiming zero active marketers
is never right, and it is the kind of wrong that gets published rather than
noticed — so it is now asserted directly, alongside `at_least_one` on the models
that feed it. The underlying cause is fixed twice over: the stand-in tables
declare their types in DDL rather than inferring them, and the code seeds pin
`status_cd` to `string` in `dbt_project.yml`.

Severities are deliberate. Tests that mean *the numbers are wrong* are errors.
Tests that mean *the source has changed shape and someone should look* — an
unlabelled class code, a title code missing from the lookup — are warnings.
Anything comparing commission across periods is a warning too, because
chargebacks make commission legitimately negative; the equivalent case-count
tests are errors, because case counts cannot be.

`store_failures` is off by default: it materialises one table per test, and 143
of them exceeds Unity Catalog's 100-table-per-schema limit. Turn it on for what
you are investigating instead:

```bash
dbt test --store-failures --select fct_marketer_production
```

## What changed, and why

**The five period buckets are now a macro.** `macros/period_buckets.sql` writes
the `sum(case when ... then ... end)` block once. FYC and paid cases both call
it, so the two can no longer drift apart — which is the failure mode when the
same ten lines are copy-pasted.

**Magic lists moved to seeds.** Status codes, titles, and the recruiter status
filter were hardcoded `IN` lists scattered through the original — the active
status list appeared twice, on lines 71–73 and again on 169–171, with no
guarantee the two stayed in sync. They are CSVs in `seeds/` now:

| Seed | Replaces |
|---|---|
| `active_status_codes.csv` | lines 71–73 and 169–171 |
| `reportable_titles.csv` | line 178 |
| `reportable_dashboard_status_codes.csv` | line 179 |
| `marketer_class_labels.csv` | the CASE block, lines 120–127 |

Models filter by joining to the seed rather than by an `IN` list. An inner join
to a lookup table *is* a filter — only rows with a matching code survive.

Seeds rather than `vars` because a code list is business data, not project
configuration. It can be queried, tested, given a description column, and
reviewed in a pull request by someone who doesn't read YAML. `dbt_project.yml`
stays untouched when the business adds a status code.

The descriptions in `active_status_codes.csv` are placeholders — confirm the
real ones with the business owner and correct that file.

**`limit 10` removed.** It was a testing leftover on line 182.

**`select distinct` removed.** Distinct was hiding a possible fan-out from the
join to marketer history. There is now a `unique` test on `mktr_no` in the mart
instead, so a duplicate fails the run rather than silently disappearing.

**`current_date` replaced with `cur_dt`.** Lines 112–113 of the original used
`current_date` while everything else used the load date. On a late or re-run
load those disagree.

**Singular data tests added.** `assert_single_reporting_period` guards the cross
join — if the calendar ever returns two rows, every fact doubles.
`assert_fyc_ties_to_source` checks the mart's YTD commission against the raw
daily table, which is the check the comment on line 167 was worried about.
`assert_report_is_not_vacuous` catches the joins-to-nothing failure described
under [Testing](#testing). Every model and column is documented in the
`_*.yml` files alongside them.

## Five things to confirm before you trust the output

1. **Lines 84–85 of the original are self-referential.**
   `a.start_6mo between a.start_6mo and d.prv_Month_EndDate` — the lower bound
   compares a column to itself, so half the condition does nothing. I've written
   it as `d.prv_me between a.start_6mo and a.end_6mo`, which is what the flag
   name implies. Verify against the report spec.

2. **The manpower table was joined twice on the same key** (`mp` and `mpr`, both
   `on mktr_no = dash.mktr_no`) to produce `prorata` and `prior_prorata`. With no
   distinguishing filter, those two columns always held identical values. Only
   one join is kept. If `prior_prorata` is meant to be last month's snapshot, it
   needs a date predicate — that predicate does not exist in the original.

3. **`active_mtd` and `active_ytd` were identical** in the original (both test
   `cur_dt`). Preserved as-is, but likely a copy-paste slip.

4. **The `LF` product filter sits in a WHERE clause after a LEFT JOIN,** which
   turns it into an inner join. Preserved deliberately, and flagged in the model
   comments. If unmatched products should survive, move it into the ON clause.

5. **Titles are matched on `initcap()`'d display text,** carried over from line
   178. That means a title stored as "MANAGING PARTNER " with a trailing space,
   or renamed to "Managing Partner (Field)", silently drops those marketers from
   the report with no error. Matching on `mk_ttl_tp_cd` instead would be robust;
   swap `reportable_titles.csv` for a list of codes once you can look them up.

## Where to go next

`int_reporting_periods` cross-joined everywhere is a faithful translation, but
the more idiomatic dbt pattern is a **date spine**: one row per date with period
flags, aggregate long, then pivot. That makes adding a sixth period (QTD, say) a
one-row change instead of an edit to two models and a macro. Worth doing once
this version is verified to tie out against the current report.
