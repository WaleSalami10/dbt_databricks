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
dbt build                 # run and test in dependency order
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

The redirect is in the source config itself — `database` and `schema` in
[models/staging/_a360__sources.yml](models/staging/_a360__sources.yml) are
templated on the var, so with it on, every `source('a360', 'x')` resolves to the
dummy schema instead of the real mart. **Only the catalog and schema change,
never the table name**, which is why no macro is involved: redirecting a source
to another location is what source config is already for. Staging models are
identical between modes. The flag is read at parse time, so it must come from
`--vars` or `dbt_project.yml`, not mid-run; `dummy_schema` overrides the schema
if you need to read someone else's copy.

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
the `reportable_titles` var, one a dashboard status absent from
`reportable_dashboard_status_codes` — so both downlines should vanish from the
mart. Some marketers are terminated, some are inside their first six months,
and non-life products exist so the `'LF'` filter has something to remove. On the
current data, 32 marketers become 22 rows under 4 recruiters.

`scripts/generate_dummy_data.py` holds the generation logic and the table
definitions. Run it directly to print what would be loaded; it never touches the
warehouse.

One caution: the two modes should not share a target schema. The stand-ins are
isolated in their own schema, but the models built on top of them are not.

`dbt source freshness` follows the redirect like everything else, so it works in
simulated mode and reports the stand-ins as fresh — the generated load date is
the as-of date. That is a side benefit of configuring the redirect rather than
overriding `source()`: a macro override is invisible to freshness, which reads
the source config directly.

## Testing

`dbt build --vars '{use_dummy_data: true}'` currently runs 143 tests, all
passing. The interesting ones are not the `not_null`s:

| Test | What it protects |
|---|---|
| `assert_single_reporting_period` | The calendar is exactly one row. Two rows doubles every measure in the mart; zero rows empties it. Neither raises an error on its own. |
| `assert_fyc_ties_to_source` | Per-marketer reconciliation from the mart back to the raw daily table, past six joins and the bucketing macro. |
| `assert_report_is_not_vacuous` | Catches joins that resolve to nothing — see below. |
| `mutually_exclusive_ranges` on both type-2 models | Overlapping windows make the point-in-time class lookup return the wrong row rather than fail. |
| `unique` on `stg_a360__marketer_appointment.mktr_no` | The fan-out `select distinct` can hide, tested at the layer where it originates rather than papered over at the end. |
| `equal_rowcount` between load control and the calendar | One row in, one row out. |

**Why `assert_report_is_not_vacuous` exists.** During the first simulated build,
the status codes were inferred from CSV as integers, so `01` arrived as `1` and
the active-status filter matched nothing. Every marketer came
out with a null contract, every `active_*` flag came out `0`, and every
six-month flag came out `'N'`. **All 181 tests passed.** `not_null`, `unique`,
`accepted_values` and `relationships` are all perfectly satisfied by a column
that is uniformly wrong in the empty direction, and a left join turns a missing
match into a null rather than an error. A report claiming zero active marketers
is never right, and it is the kind of wrong that gets published rather than
noticed — so it is now asserted directly, alongside `at_least_one` on the models
that feed it. The underlying cause is fixed twice over: the stand-in tables
declare their types in DDL rather than inferring them, and every status code in
every `IN` list is quoted so it cannot be read as an integer.

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

**Code lists stay as literal `IN` lists,** exactly where and how
FOD_query.sql writes them:

| List | Lives in | From |
|---|---|---|
| Ten active status codes | `int_class_by_marketer`, `int_marketer_contract` | lines 71–73 and 169–171 |
| Five reportable titles | `fct_marketer_production` | line 178 |
| Three dashboard status codes | `fct_marketer_production` | line 179 |
| Class-code labels (`CASE`) | `fct_marketer_production` | lines 120–127 |

**The active status list is written out twice** — once in each intermediate
model — because the original has it twice. Nothing enforces that the two copies
agree. If they drift, a marketer counts as active for their class lookup but not
for their contract, or the reverse, and the report is quietly wrong rather than
broken. Both model headers say so. This is the one deliberate piece of
duplication in the project; if it bites, the fix is a macro or a var, not a
third copy.

**The status codes must stay quoted.** They are zero-padded text and one of them
is `1C`. As integers, `'01'` becomes `1`, the `IN` list matches nothing, and the
report shows no marketer under contract — silently. That is the exact failure
described under `assert_report_is_not_vacuous` below. The class codes in the
`CASE` block are the opposite: `mk_cls_tp_cd` is an integer, so those are
unquoted.

The class labels map `1→CC, 2→1P, 3→2P, 4→3P, 5→Estab, 10→PTAS`, with anything
else falling through to `Other` — the `ELSE` in the original. Confirm those
labels against the class taxonomy the business actually uses.

**`limit 10` removed.** It was a testing leftover on line 182.

**`select distinct` kept,** as in the original. Be clear about what it does and
does not do: it collapses duplicate rows from an upstream fan-out only when
those rows are byte-identical, and does nothing when they differ — then the
marketer appears twice and the report doubles. The `unique` test on `mktr_no` in
the mart is the actual guard, and it stays for that reason. The fan-out's origin
is the join to marketer history, tested at that layer too.

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

2. **The manpower table is joined twice on the same key** (`mp` and `mpr`, both
   `on mktr_no = m.mktr_no`), producing `prorata` and `prior_prorata`. With no
   distinguishing predicate those two columns are always identical. Both joins
   are reproduced from the original, and `expression_is_true` on
   `prior_prorata = prorata` in `_marts.yml` states the duplication as a test —
   it fails the day someone gives `mpr` a real predicate, which is the signal to
   remove the test. If `prior_prorata` is meant to be last month's snapshot it
   needs a date predicate, and `orap10_mk_manpower` exposes no column to write
   one against. **Do not report `prior_prorata` as a prior-period figure until
   that is resolved.**

3. **`active_mtd` and `active_ytd` were identical** in the original (both test
   `cur_dt`). Preserved as-is, but likely a copy-paste slip.

4. **The `LF` product filter sits in a WHERE clause after a LEFT JOIN,** which
   turns it into an inner join. Preserved deliberately, and flagged in the model
   comments. If unmatched products should survive, move it into the ON clause.

5. **Titles are matched on `initcap()`'d display text,** carried over from line
   178. That means a title stored as "MANAGING PARTNER " with a trailing space,
   or renamed to "Managing Partner (Field)", silently drops those marketers from
   the report with no error. Matching on `mk_ttl_tp_cd` instead would be robust;
   swap the `reportable_titles` var for a list of codes once you can look them up.

## Where to go next

`int_reporting_periods` cross-joined everywhere is a faithful translation, but
the more idiomatic dbt pattern is a **date spine**: one row per date with period
flags, aggregate long, then pivot. That makes adding a sixth period (QTD, say) a
one-row change instead of an edit to two models and a macro. Worth doing once
this version is verified to tie out against the current report.
