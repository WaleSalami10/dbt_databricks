#!/usr/bin/env python3
"""
Generate dummy data for the daily FOD (Field Office Development) count report.

The real sources are read-only: the a360 mart (`prod_execution_rs.
ext_agy_a360_mart`) and an EDH lake schema
(`prod_execution_datalake.lake_oracle_orap10_ai0101`). This module builds a
stand-in for every table the report reads -- same table names, same column
names, same column TYPES -- so the whole project can be built and tested
without a connection to either.

It only generates. scripts/load_fod_dummy_data.py is what writes the tables
into Databricks:

    python scripts/load_fod_dummy_data.py
    dbt build --vars '{use_dummy_data: true}'

The dummy tables are deliberately NOT dbt seeds -- see the README's
"Simulating the project" section for why (in short: a source exists before
dbt runs, and seeds would put the stand-ins inside the DAG and hand their
column types to CSV inference instead of the DDL declared here).

Event dates are generated RELATIVE to the as-of date (default: today), and
int_fod_events' active-year window is itself relative to that date, so
hardcoded dates would age out within a year. The random seed is fixed, so
regenerating on the same as-of date reproduces the same rows.

Usage (prints what would be built -- see load_fod_dummy_data.py to actually
load):
    python scripts/generate_fod_dummy_data.py [--as-of YYYY-MM-DD]
"""

from __future__ import annotations

import argparse
import random
from dataclasses import dataclass, field
from datetime import date, timedelta

RANDOM_SEED = 20260901

# The load-control feed int_reporting_periods anchors on.
TARGET_SYSTEM = "DASHBOARD"
LOAD_FEED = "Life Premium/Paid Cases"

# One of the ten active-status codes int_fod_events matches on.
FOD_ACTIVE_STATUS_CODE = "01"
FOD_TOOLS = ["FOD", "PRP", "IID"]


def add_months(d: date, n: int) -> date:
    """Calendar-safe month arithmetic, clamped to the end of the target month."""
    total = (d.year * 12 + d.month - 1) + n
    year, month = divmod(total, 12)
    month += 1
    day = min(d.day, [31, 29 if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)
                      else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1])
    return date(year, month, day)


@dataclass
class FodMarketer:
    mktr_no: str
    rcr_no: str
    title: str
    acf2id: str


def build_fod_marketers() -> list[FodMarketer]:
    """
    One recruiter and seven producers underneath, all pure-digit ids.

    Pure-digit, unlike a display-friendly 'M9004'-style id, because
    int_fod_events casts trf_cs_user.case_marketer_id_c to an integer and
    matches it against both the EDH lake dashboard and orap10_mk_sts_atv.
    """
    base = 700000
    marketers = [FodMarketer(mktr_no=str(base), rcr_no=str(base),
                              title="Managing Partner", acf2id=f"ACF2{base}")]
    titles = ["Partner", "Senior Partner", "Executive Partner", "Agent"]
    for i in range(1, 8):
        mktr_no = str(base + i)
        marketers.append(FodMarketer(
            mktr_no=mktr_no,
            rcr_no=str(base),
            title=titles[i % len(titles)],
            acf2id=f"ACF2{mktr_no}",
        ))
    return marketers


def build_load_control(as_of: date) -> list[dict]:
    """
    One row per (target system, data subject). Only the DASHBOARD /
    'Life Premium/Paid Cases' row is read.

    The other two rows are decoys: each matches on exactly one of the two
    filter columns, so a model that filters on only one of them picks up a
    wrong load date instead of silently working.
    """
    return [
        {"tgt_sys_nm": TARGET_SYSTEM, "common_data_name": LOAD_FEED,
         "ld_dt": as_of.isoformat(), "ld_stat_cd": "C"},
        {"tgt_sys_nm": TARGET_SYSTEM, "common_data_name": "Agent Headcount",
         "ld_dt": as_of.replace(day=1).isoformat(), "ld_stat_cd": "C"},
        {"tgt_sys_nm": "EDW", "common_data_name": LOAD_FEED,
         "ld_dt": (as_of - timedelta(days=3)).isoformat(), "ld_stat_cd": "C"},
    ]


def build_status_rows(marketers: list[FodMarketer], as_of: date) -> list[dict]:
    """Active, open-ended contract-status windows -- one per marketer."""
    return [
        {"mktr_no": m.mktr_no, "mk_sts_tp_cd": FOD_ACTIVE_STATUS_CODE,
         "mk_sts_atv_edt": add_months(as_of, -30).isoformat(),
         "mk_sts_atv_xdt": "9999-12-31"}
        for m in marketers
    ]


@dataclass
class Table:
    """
    One stand-in source table: its name, its typed columns, and its rows.

    The name matches the real table exactly -- lake or a360 -- which is what
    lets each source's dummy redirect swap in the stand-in schema by changing
    only the catalog and schema, leaving every table name untouched.
    """
    name: str
    columns: list[tuple[str, str]]
    rows: list[dict] = field(default_factory=list)

    @property
    def column_names(self) -> list[str]:
        return [c for c, _ in self.columns]


def build_tables(as_of: date) -> list[Table]:
    """Build every stand-in table the FOD report reads, for the given as-of date."""
    rng = random.Random(RANDOM_SEED)
    marketers = build_fod_marketers()

    dashboard_rows = [
        {"MKTR_ID_NK": m.mktr_no, "REL_MKTR_ID": m.rcr_no,
         "EDH_RECORD_STATUS_IN": "A"}
        for m in marketers
    ]
    # A decoy superseded row: same marketer, non-'A' status. int_fod_new_agents
    # filters it out -- present so that filter is actually exercised.
    dashboard_rows.append({"MKTR_ID_NK": marketers[-1].mktr_no,
                            "REL_MKTR_ID": marketers[-1].rcr_no,
                            "EDH_RECORD_STATUS_IN": "S"})

    history_rows = [
        {"MKTR_ID_NK": m.mktr_no,
         "ORIG_APPL_DT": (date(2024, 1, 1) + timedelta(days=15 * i)).isoformat()}
        for i, m in enumerate(marketers)
    ]
    # A decoy application from before the program's inception date, on the
    # last marketer -- exercises the >= 2024-01-01 filter without removing
    # that marketer's qualifying row.
    history_rows.append({"MKTR_ID_NK": marketers[-1].mktr_no,
                          "ORIG_APPL_DT": "2023-06-01"})

    crm_rows = [
        {"case_marketer_id_c": m.mktr_no, "acf2id_c": m.acf2id, "user_title": m.title}
        for m in marketers
    ]
    # A decoy non-numeric id -- exercises the RLIKE '^[0-9]+$' filter.
    crm_rows.append({"case_marketer_id_c": "PENDING", "acf2id_c": "ACF2PENDING",
                      "user_title": "Agent"})

    window_start = date(as_of.year - 1, 1, 1)
    span = (as_of - window_start).days

    event_rows: list[dict] = []
    dip_rows: list[dict] = []
    last_mod_dip_rows: list[dict] = []
    last_mod_stg_rows: list[dict] = []
    event_no = 0

    for m in marketers:
        for _ in range(rng.randint(4, 9)):
            event_no += 1
            event_id = f"EVT{event_no:05d}"
            dip_id = f"DIP{event_no:05d}"
            event_dt = window_start + timedelta(days=rng.randint(0, span))
            modified_at = f"{event_dt.isoformat()}T00:00:00"
            tool = rng.choice(FOD_TOOLS)

            event_rows.append({
                "sale_force_id": event_id,
                "case_ownr_acf2id_id": m.acf2id,
                "event_ownr_desc": f"{m.title} Owner",
                "case_agent_nm_desc": f"Agent {m.mktr_no}",
                "case_dev_tool_desc": tool,
                "case_dev_in_prog_desc": dip_id,
                "case_fod_occur_desc": "Yes" if rng.random() < 0.6 else "No",
                "is_fod_mgr_ownr_ind": 1 if rng.random() < 0.7 else 0,
                "actvt_dt": event_dt.isoformat(),
                "is_deleted_cd": 0,
                "last_modify_dt": modified_at,
            })
            dip_rows.append({"sale_force_id_nk": dip_id, "last_modified_dt": modified_at})
            last_mod_dip_rows.append({"sale_force_id_nk": dip_id, "dt": modified_at})
            last_mod_stg_rows.append({"sale_force_id": event_id, "dt": modified_at})

        # A deleted decoy event, well-formed otherwise -- is_deleted_cd = 0 is
        # the only reason int_fod_events should exclude it.
        event_no += 1
        event_id = f"EVT{event_no:05d}"
        dip_id = f"DIP{event_no:05d}"
        event_dt = as_of - timedelta(days=5)
        modified_at = f"{event_dt.isoformat()}T00:00:00"
        event_rows.append({
            "sale_force_id": event_id,
            "case_ownr_acf2id_id": m.acf2id,
            "event_ownr_desc": f"{m.title} Owner",
            "case_agent_nm_desc": f"Agent {m.mktr_no}",
            "case_dev_tool_desc": "FOD",
            "case_dev_in_prog_desc": dip_id,
            "case_fod_occur_desc": "Yes",
            "is_fod_mgr_ownr_ind": 1,
            "actvt_dt": event_dt.isoformat(),
            "is_deleted_cd": 1,
            "last_modify_dt": modified_at,
        })
        dip_rows.append({"sale_force_id_nk": dip_id, "last_modified_dt": modified_at})
        last_mod_dip_rows.append({"sale_force_id_nk": dip_id, "dt": modified_at})
        last_mod_stg_rows.append({"sale_force_id": event_id, "dt": modified_at})

    return [
        # --- a360 source ('a360' in _a360__sources.yml) --------------------
        Table(
            "orap10_data_src_load_ctrl",
            [("tgt_sys_nm", "string"), ("common_data_name", "string"),
             ("ld_dt", "date"), ("ld_stat_cd", "string")],
            build_load_control(as_of),
        ),
        Table(
            "orap10_mk_sts_atv",
            # mk_sts_atv_xdt is string, not date: it carries the 9999 sentinel,
            # and resolving that is stg_a360__marketer_status's job.
            [("mktr_no", "string"), ("mk_sts_tp_cd", "string"),
             ("mk_sts_atv_edt", "date"), ("mk_sts_atv_xdt", "string")],
            build_status_rows(marketers, as_of),
        ),
        # --- a360_fod source ('a360_fod' in _fod_a360__sources.yml) --------
        Table(
            "trf_cs_user",
            [("case_marketer_id_c", "string"), ("acf2id_c", "string"),
             ("user_title", "string")],
            crm_rows,
        ),
        Table(
            "sf_event",
            [("sale_force_id", "string"), ("case_ownr_acf2id_id", "string"),
             ("event_ownr_desc", "string"), ("case_agent_nm_desc", "string"),
             ("case_dev_tool_desc", "string"), ("case_dev_in_prog_desc", "string"),
             ("case_fod_occur_desc", "string"), ("is_fod_mgr_ownr_ind", "int"),
             ("actvt_dt", "date"), ("is_deleted_cd", "int"),
             ("last_modify_dt", "timestamp")],
            event_rows,
        ),
        Table(
            "sf_case_development_in_progress_c",
            [("sale_force_id_nk", "string"), ("last_modified_dt", "timestamp")],
            dip_rows,
        ),
        Table(
            "p_adp_lst_mod_dt_dip",
            [("sale_force_id_nk", "string"), ("dt", "timestamp")],
            last_mod_dip_rows,
        ),
        Table(
            "p_adp_lst_mod_dt_stg",
            [("sale_force_id", "string"), ("dt", "timestamp")],
            last_mod_stg_rows,
        ),
        # --- lake_orap10 source ('lake_orap10' in _lake_orap10__sources.yml)
        Table(
            "mk_dashbrd",
            [("MKTR_ID_NK", "string"), ("REL_MKTR_ID", "string"),
             ("EDH_RECORD_STATUS_IN", "string")],
            dashboard_rows,
        ),
        Table(
            "mk_history",
            [("MKTR_ID_NK", "string"), ("ORIG_APPL_DT", "date")],
            history_rows,
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

    print(f"Generated dummy FOD sources as of {as_of}:")
    for table in tables:
        print(f"  {table.name:<34} {len(table.rows):>6} rows")

    print("\nNothing was loaded. To load into Databricks:")
    print("  python scripts/load_fod_dummy_data.py")


if __name__ == "__main__":
    main()
