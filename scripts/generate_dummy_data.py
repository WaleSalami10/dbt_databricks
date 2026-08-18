#!/usr/bin/env python3
"""
Generate dummy a360 source data.

The real sources live in `prod_execution_rs.ext_agy_a360_mart` and are read-only.
This module builds a stand-in for each of them -- same table names, same column
names, same column TYPES -- so the whole project can be built and tested without
a connection to that mart.

It only generates. `scripts/load_dummy_data.py` is what writes the tables into
Databricks, and that is the script to run:

    python scripts/load_dummy_data.py
    dbt build --vars '{use_dummy_data: true}'

The dummy tables are deliberately NOT dbt seeds. They stand in for sources, and
a source is something that exists before dbt runs; making them seeds would put
them inside the DAG they are supposed to sit outside of, and would leave dbt
inferring their column types from CSV text. Declaring the types explicitly here
is not incidental -- inferring them is what silently turned the status code '01'
into the integer 1 the first time this was built.

Dates are generated RELATIVE to the as-of date (default: today). The reporting
calendar anchors on the load-control date, and fixed dates would drift out of
the current-week / current-month buckets within days, leaving those buckets
silently reading zero.

The random seed is fixed, so regenerating on the same as-of date reproduces the
same data exactly.

Usage (prints what would be built -- see load_dummy_data.py to actually load):
    python scripts/generate_dummy_data.py [--as-of YYYY-MM-DD]
"""

from __future__ import annotations

import argparse
import random
from dataclasses import dataclass, field
from datetime import date, timedelta

RANDOM_SEED = 20260807

# The load-control feed that int_reporting_periods anchors on.
TARGET_SYSTEM = "DASHBOARD"
LOAD_FEED = "Life Premium/Paid Cases"

# Titles are stored upper-case in the source and initcap()'d by the staging
# model, which is how the original query matched them. Only the first four are
# in the title list in fct_marketer_production -- 'AGENT' and 'ASSOCIATE
# PARTNER' exist so the
# title filter has something to actually filter out.
TITLES = [
    ("MP", "MANAGING PARTNER"),
    ("PT", "PARTNER"),
    ("SP", "SENIOR PARTNER"),
    ("EP", "EXECUTIVE PARTNER"),
    ("AP", "ASSOCIATE PARTNER"),
    ("AG", "AGENT"),
]
REPORTABLE_TITLE_CODES = ["MP", "PT", "SP", "EP"]

# Matches the dashboard status filter in fct_marketer_production (01, 04, 1C)
# plus '99', deliberately absent from every code list so it gets filtered out.
DASHBOARD_STATUS_CODES = ["01", "04", "1C", "99"]

# Matches the active-status IN list in the intermediate models, plus '99'
# (terminated, not active).
CONTRACT_STATUS_CODES = ["01", "04", "05", "07", "99"]

# 1-5 and 10 are the codes the CASE block in fct_marketer_production maps; 6 is
# here so the unmapped -> 'Other' fallback is actually exercised by the build.
CLASS_CODES = [1, 2, 3, 4, 5, 10, 6]

OFFICES = [
    ("OU100", "Chicago General Office", "Central Zone"),
    ("OU200", "Dallas General Office", "South Zone"),
    ("OU300", "Boston General Office", "Northeast Zone"),
    ("OU400", "Phoenix General Office", "West Zone"),
]

# alt_prdt_line_cd 'LF' is the life line the paid-case model filters to.
PRODUCTS = [
    ("P001", "LF", "Whole Life"),
    ("P002", "LF", "Universal Life"),
    ("P003", "LF", "Level Term"),
    ("P004", "AN", "Fixed Annuity"),
    ("P005", "AN", "Variable Annuity"),
    ("P006", "LT", "Long Term Care"),
]

FIRST_NAMES = [
    "Avery", "Jordan", "Riley", "Casey", "Morgan", "Quinn", "Rowan", "Sage",
    "Emerson", "Harper", "Kai", "Logan", "Micah", "Noel", "Parker", "Reese",
    "Skyler", "Tatum", "Alexis", "Blake", "Cameron", "Dakota", "Ellis",
    "Finley", "Greer", "Hayden", "Indigo", "Jamie", "Kendall", "Lennox",
    "Marlowe", "Nico",
]
LAST_NAMES = [
    "Okafor", "Nakamura", "Alvarez", "Petrov", "Sullivan", "Haddad", "Larsen",
    "Mensah", "Rossi", "Novak", "Bergstrom", "Chaudhry", "Delacroix", "Eriksen",
    "Fontaine", "Guzman", "Hollande", "Ibarra", "Jansen", "Kowalski", "Lindqvist",
    "Moreau", "Nyberg", "Oyelaran", "Pashkov", "Quintero", "Ramirez", "Sorensen",
    "Tanaka", "Umeh", "Vasquez", "Wojcik",
]


@dataclass
class Marketer:
    mktr_no: str
    rel_mktr_no: str
    first_nm: str
    last_nm: str
    title_cd: str
    dashboard_status_cd: str
    contract_status_cd: str
    class_cd: int
    org_unit_cd: str
    appt_dt: date
    terminated_on: date | None
    is_recruiter: bool

    @property
    def abbreviated_nm(self) -> str:
        return f"{self.first_nm[0]}. {self.last_nm}"[:20]


def month_start(d: date) -> date:
    return d.replace(day=1)


def add_months(d: date, n: int) -> date:
    """Calendar-safe month arithmetic, clamped to the end of the target month."""
    total = (d.year * 12 + d.month - 1) + n
    year, month = divmod(total, 12)
    month += 1
    # Clamp: 31 Jan + 1 month -> 28/29 Feb.
    day = min(d.day, [31, 29 if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)
                      else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1])
    return date(year, month, day)


def build_marketers(rng: random.Random, as_of: date) -> list[Marketer]:
    """Six recruiting managers, each with three to five producers underneath."""
    marketers: list[Marketer] = []
    name_pool = [(f, l) for f in FIRST_NAMES for l in LAST_NAMES]
    rng.shuffle(name_pool)
    names = iter(name_pool)

    recruiters: list[Marketer] = []
    for i in range(6):
        first, last = next(names)
        recruiter = Marketer(
            mktr_no=f"M{9000 + i:04d}",
            rel_mktr_no=f"M{9000 + i:04d}",  # a manager recruits themselves
            first_nm=first,
            last_nm=last,
            # Recruiter 5 gets a non-reportable title and recruiter 4 a
            # non-reportable dashboard status: both of their downlines should
            # disappear from the mart. That is the point of them. 'AG' (Agent)
            # is used rather than 'AP' because Associate Partner IS in
            # the reportable-title list.
            title_cd=REPORTABLE_TITLE_CODES[i] if i < 4 else ("AG" if i == 5 else "MP"),
            dashboard_status_cd="99" if i == 4 else rng.choice(DASHBOARD_STATUS_CODES[:3]),
            contract_status_cd=rng.choice(CONTRACT_STATUS_CODES[:4]),
            class_cd=rng.choice(CLASS_CODES[4:]),
            org_unit_cd=OFFICES[i % len(OFFICES)][0],
            appt_dt=add_months(as_of, -rng.randint(60, 200)),
            terminated_on=None,
            is_recruiter=True,
        )
        recruiters.append(recruiter)
        marketers.append(recruiter)

    producer_no = 1000
    for recruiter in recruiters:
        for _ in range(rng.randint(3, 5)):
            first, last = next(names)
            # A quarter of producers are inside their first six months, which is
            # what the six-month flags in the mart key off.
            months_tenure = rng.choice([1, 3, 5, 9, 14, 26, 48, 77])
            appt = add_months(as_of, -months_tenure) - timedelta(days=rng.randint(0, 20))
            terminated = None
            status_cd = rng.choices(CONTRACT_STATUS_CODES, weights=[50, 15, 10, 10, 15])[0]
            if status_cd == "99":
                terminated = as_of - timedelta(days=rng.randint(10, 400))
                if terminated <= appt:
                    terminated = appt + timedelta(days=30)
            marketers.append(
                Marketer(
                    mktr_no=f"M{producer_no:04d}",
                    rel_mktr_no=recruiter.mktr_no,
                    first_nm=first,
                    last_nm=last,
                    title_cd=rng.choice(["AG", "AP"]),
                    dashboard_status_cd=rng.choice(DASHBOARD_STATUS_CODES[:3]),
                    contract_status_cd=status_cd,
                    class_cd=rng.choice(CLASS_CODES),
                    org_unit_cd=recruiter.org_unit_cd,
                    appt_dt=appt,
                    terminated_on=terminated,
                    is_recruiter=False,
                )
            )
            producer_no += 1

    return marketers


def collapse_to_grain(rows: list[dict], keys: list[str], measures: dict[str, str]) -> list[dict]:
    """
    Roll duplicate rows up onto the grain the source is documented to have.

    The daily summary tables are one row per marketer per day; random generation
    naturally produces two rows on the same day for the same marketer. Rather
    than weaken the grain tests to warnings, the generator honours the grain --
    a uniqueness failure on this data then means a real modelling bug.
    """
    merged: dict[tuple, dict] = {}
    for row in rows:
        key = tuple(row[k] for k in keys)
        if key not in merged:
            merged[key] = dict(row)
            continue
        target = merged[key]
        for col, how in measures.items():
            if how == "sum_money":
                target[col] = f"{float(target[col]) + float(row[col]):.2f}"
            else:
                target[col] = int(target[col]) + int(row[col])
    return [merged[k] for k in sorted(merged)]


def build_load_control(as_of: date) -> list[dict]:
    """
    One row per (target system, data subject). Only the
    DASHBOARD / 'Life Premium/Paid Cases' row is read.

    The other two rows are decoys: each matches on exactly one of the two
    filter columns, so a model that filters on only one of them picks up a
    wrong load date instead of silently working.
    """
    return [
        {"tgt_sys_nm": TARGET_SYSTEM, "common_data_name": LOAD_FEED,
         "ld_dt": as_of.isoformat(), "ld_stat_cd": "C"},
        {"tgt_sys_nm": TARGET_SYSTEM, "common_data_name": "Agent Headcount",
         "ld_dt": month_start(as_of).isoformat(), "ld_stat_cd": "C"},
        {"tgt_sys_nm": "EDW", "common_data_name": LOAD_FEED,
         "ld_dt": (as_of - timedelta(days=3)).isoformat(), "ld_stat_cd": "C"},
    ]


def build_daily_fyc(rng: random.Random, marketers: list[Marketer], as_of: date) -> list[dict]:
    """
    Commission activity from the start of last year through the as-of date.

    Rows are spread deliberately across every bucket the report cares about --
    current week, prior week, month to date, prior month end, year to date --
    so a bucket that silently returns nothing is a bug, not thin data.
    """
    rows = []
    window_start = date(as_of.year - 1, 1, 1)
    span = (as_of - window_start).days
    for m in marketers:
        if m.is_recruiter:
            continue
        for _ in range(rng.randint(8, 30)):
            fyc_dt = window_start + timedelta(days=rng.randint(0, span))
            if fyc_dt < m.appt_dt or (m.terminated_on and fyc_dt > m.terminated_on):
                continue
            rows.append({
                "mktr_no": m.mktr_no,
                "fyc_smy_edt": fyc_dt.isoformat(),
                "mk_shr_fyc_am": f"{rng.uniform(150, 9500):.2f}",
            })
        # Guarantee coverage of the two week buckets and month to date.
        for offset in (rng.randint(0, 6), rng.randint(7, 13), rng.randint(0, 25)):
            fyc_dt = as_of - timedelta(days=offset)
            if fyc_dt < m.appt_dt or (m.terminated_on and fyc_dt > m.terminated_on):
                continue
            rows.append({
                "mktr_no": m.mktr_no,
                "fyc_smy_edt": fyc_dt.isoformat(),
                "mk_shr_fyc_am": f"{rng.uniform(150, 9500):.2f}",
            })
    return collapse_to_grain(rows, ["mktr_no", "fyc_smy_edt"], {"mk_shr_fyc_am": "sum_money"})


def build_paid_cases(rng: random.Random, marketers: list[Marketer], as_of: date) -> list[dict]:
    rows = []
    window_start = date(as_of.year - 1, 1, 1)
    span = (as_of - window_start).days
    for m in marketers:
        if m.is_recruiter:
            continue
        for _ in range(rng.randint(5, 20)):
            paid_dt = window_start + timedelta(days=rng.randint(0, span))
            if paid_dt < m.appt_dt or (m.terminated_on and paid_dt > m.terminated_on):
                continue
            product = rng.choices(PRODUCTS, weights=[30, 25, 20, 10, 10, 5])[0]
            rows.append({
                "mktr_no": m.mktr_no,
                "ctcp_prm_smy_edt": paid_dt.isoformat(),
                "alt_prdt_cd": product[0],
                "mk_shr_ctcp_sld_qy": rng.randint(1, 3),
            })
        for offset in (rng.randint(0, 6), rng.randint(7, 13)):
            paid_dt = as_of - timedelta(days=offset)
            if paid_dt < m.appt_dt or (m.terminated_on and paid_dt > m.terminated_on):
                continue
            rows.append({
                "mktr_no": m.mktr_no,
                "ctcp_prm_smy_edt": paid_dt.isoformat(),
                "alt_prdt_cd": rng.choice(PRODUCTS[:3])[0],
                "mk_shr_ctcp_sld_qy": rng.randint(1, 2),
            })
    return collapse_to_grain(
        rows,
        ["mktr_no", "ctcp_prm_smy_edt", "alt_prdt_cd"],
        {"mk_shr_ctcp_sld_qy": "sum_int"},
    )


def build_class_history(rng: random.Random, marketers: list[Marketer], as_of: date) -> list[dict]:
    """
    A closed chain of validity windows per marketer: each row ends the day before
    the next begins, and the last row is open ended (9999-12-31). Overlapping
    windows would make the point-in-time lookup in int_class_by_marketer return
    an arbitrary row, so the generator does not produce any.
    """
    rows = []
    for m in marketers:
        cursor = m.appt_dt
        cls = max(1, m.class_cd - rng.randint(0, 3))
        end_of_life = m.terminated_on or date(9999, 12, 31)
        while True:
            next_change = cursor + timedelta(days=rng.randint(180, 900))
            is_last = next_change >= end_of_life or next_change > as_of
            valid_to = end_of_life if is_last else next_change - timedelta(days=1)
            rows.append({
                "mktr_no": m.mktr_no,
                "mk_cls_tp_cd": cls,
                "mk_cls_edt": cursor.isoformat(),
                "mk_cls_xdt": valid_to.isoformat(),
            })
            if is_last:
                break
            cursor = next_change
            cls = min(8, cls + 1)
    return rows


def build_status_history(marketers: list[Marketer]) -> list[dict]:
    """
    Contract status windows. The open-ended end date is the literal string
    '9999-12-31' -- the sentinel int_marketer_contract exists to resolve.
    """
    rows = []
    for m in marketers:
        if m.terminated_on:
            rows.append({
                "mktr_no": m.mktr_no,
                "mk_sts_tp_cd": m.contract_status_cd if m.contract_status_cd != "99" else "01",
                "mk_sts_atv_edt": m.appt_dt.isoformat(),
                "mk_sts_atv_xdt": (m.terminated_on - timedelta(days=1)).isoformat(),
            })
            rows.append({
                "mktr_no": m.mktr_no,
                "mk_sts_tp_cd": "99",
                "mk_sts_atv_edt": m.terminated_on.isoformat(),
                "mk_sts_atv_xdt": "9999-12-31",
            })
        else:
            rows.append({
                "mktr_no": m.mktr_no,
                "mk_sts_tp_cd": m.contract_status_cd,
                "mk_sts_atv_edt": m.appt_dt.isoformat(),
                "mk_sts_atv_xdt": "9999-12-31",
            })
    return rows


@dataclass
class Table:
    """
    One stand-in source table: its name, its typed columns, and its rows.

    The name matches the real table in ext_agy_a360_mart exactly. That is what
    lets the a360 source config swap in the dummy schema by changing only the
    catalog and schema, leaving every table name -- and therefore every staging
    model -- untouched.
    """
    name: str
    columns: list[tuple[str, str]]
    rows: list[dict] = field(default_factory=list)

    @property
    def column_names(self) -> list[str]:
        return [c for c, _ in self.columns]


def build_tables(as_of: date) -> list[Table]:
    """Build every stand-in table for the given as-of date."""
    rng = random.Random(RANDOM_SEED)
    marketers = build_marketers(rng, as_of)

    return [
        Table(
            "orap10_data_src_load_ctrl",
            [("tgt_sys_nm", "string"), ("common_data_name", "string"),
             ("ld_dt", "date"), ("ld_stat_cd", "string")],
            build_load_control(as_of),
        ),
        Table(
            "orap10_mk_dashbrd",
            # mk_sts_tp_cd is text, not a number: the codes are zero-padded
            # ('01', '04') and one of them is '1C'.
            [("mktr_no", "string"), ("rel_mktr_no", "string"),
             ("mk_cls_tp_cd", "int"), ("mk_ttl_tp_cd", "string"),
             ("mk_sts_tp_cd", "string"), ("alt_org_unit_cd", "string"),
             ("abreviated_nm", "string"), ("mk_fst_nm", "string"),
             ("mk_lst_nm", "string")],
            [{"mktr_no": m.mktr_no,
              "rel_mktr_no": m.rel_mktr_no,
              "mk_cls_tp_cd": m.class_cd,
              "mk_ttl_tp_cd": m.title_cd,
              "mk_sts_tp_cd": m.dashboard_status_cd,
              "alt_org_unit_cd": m.org_unit_cd,
              "abreviated_nm": m.abbreviated_nm,
              "mk_fst_nm": m.first_nm,
              "mk_lst_nm": m.last_nm} for m in marketers],
        ),
        Table(
            "orap10_mk_history",
            [("mktr_no", "string"), ("orig_appt_dt", "date")],
            [{"mktr_no": m.mktr_no, "orig_appt_dt": m.appt_dt.isoformat()}
             for m in marketers],
        ),
        Table(
            "orap10_mk_manpower",
            [("mktr_no", "string"), ("pro_rata_ind", "int"), ("count_active", "int")],
            [{"mktr_no": m.mktr_no,
              "pro_rata_ind": 1 if rng.random() < 0.35 else 0,
              "count_active": 0 if m.terminated_on else 1} for m in marketers],
        ),
        Table(
            "orap10_cur_go_zone",
            [("org_unit_cd", "string"), ("org_unit_nm", "string"), ("zone_nm", "string")],
            [{"org_unit_cd": c, "org_unit_nm": g, "zone_nm": z} for c, g, z in OFFICES],
        ),
        Table(
            "orap10_mk_ttl_tp",
            [("mk_ttl_tp_cd", "string"), ("mk_ttl_tp_nm", "string")],
            [{"mk_ttl_tp_cd": c, "mk_ttl_tp_nm": d} for c, d in TITLES],
        ),
        Table(
            "orap10_dash_alt_prdt_mv",
            # The third element of each PRODUCTS tuple is a readable label for
            # whoever edits this file; it is not a column on the real table.
            [("alt_prdt_cd", "string"), ("alt_prdt_line_cd", "string")],
            [{"alt_prdt_cd": c, "alt_prdt_line_cd": l}
             for c, l, _ in PRODUCTS],
        ),
        Table(
            "orap10_mk_cls_hist",
            [("mktr_no", "string"), ("mk_cls_tp_cd", "int"),
             ("mk_cls_edt", "date"), ("mk_cls_xdt", "date")],
            build_class_history(rng, marketers, as_of),
        ),
        Table(
            "orap10_mk_sts_atv",
            # mk_sts_atv_xdt is string, not date: it carries the 9999 sentinel,
            # and resolving that is stg_a360__marketer_status's job.
            [("mktr_no", "string"), ("mk_sts_tp_cd", "string"),
             ("mk_sts_atv_edt", "date"), ("mk_sts_atv_xdt", "string")],
            build_status_history(marketers),
        ),
        Table(
            "orap10_mk_daly_fyc_join_mv",
            [("mktr_no", "string"), ("fyc_smy_edt", "date"),
             ("mk_shr_fyc_am", "decimal(18,2)")],
            build_daily_fyc(rng, marketers, as_of),
        ),
        Table(
            "orap10_mk_daly_ctcp_prm_smy",
            [("mktr_no", "string"), ("ctcp_prm_smy_edt", "date"),
             ("alt_prdt_cd", "string"), ("mk_shr_ctcp_sld_qy", "int")],
            build_paid_cases(rng, marketers, as_of),
        ),
    ]


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--as-of", default=date.today().isoformat(),
                        help="Load-control date the calendar anchors on (default: today).")
    args = parser.parse_args()

    as_of = date.fromisoformat(args.as_of)
    tables = build_tables(as_of)

    print(f"Generated dummy a360 sources as of {as_of}:")
    for table in tables:
        print(f"  {table.name:<34} {len(table.rows):>6} rows")

    print("\nNothing was loaded. To load into Databricks:")
    print("  python scripts/load_dummy_data.py")


if __name__ == "__main__":
    main()
