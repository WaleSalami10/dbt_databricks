#!/usr/bin/env python3
"""
Load the dummy a360 sources into Databricks.

Creates one table per real source table, with the same name and the same column
types, in a dedicated schema:

    python scripts/load_dummy_data.py
    dbt build --vars '{use_dummy_data: true}'

With `use_dummy_data: true`, `macros/source.sql` points every
`source('a360', x)` at `<catalog>.<schema>_dummy_a360.x` instead of
`prod_execution_rs.ext_agy_a360_mart.x`. Only the catalog and schema change --
the table names are identical, so no model, test or piece of documentation is
aware of the difference.

These are tables rather than dbt seeds on purpose. A source is something that
exists before dbt runs; a seed is a node inside the DAG. Making the stand-ins
seeds would put them inside the graph they are meant to sit outside, and would
hand their column types to CSV inference -- which is exactly what turned the
status code '01' into the integer 1 the first time this project was built.

Connection details come from the environment, the same variables the dbt
profile reads. Either export them or let this script read a .env file:

    host, http_path, token, catalog, schema

Usage:
    python scripts/load_dummy_data.py [--as-of YYYY-MM-DD] [--schema NAME]
                                      [--env-file .env] [--dry-run]
"""

from __future__ import annotations

import argparse
import os
import sys
from datetime import date
from decimal import Decimal
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from generate_dummy_data import Table, build_tables  # noqa: E402

# Inserted in batches: one multi-row INSERT per chunk rather than one per row,
# which is the difference between a few seconds and a few minutes over a SQL
# warehouse connection.
ROWS_PER_INSERT = 250

SCHEMA_SUFFIX = "dummy_a360"


def load_env_file(path: Path) -> None:
    """
    Read a KEY=value file into the environment without overwriting anything
    already set. Deliberately minimal -- no dependency on python-dotenv.
    """
    if not path.exists():
        return
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        os.environ.setdefault(key.strip(), value.strip().strip('"').strip("'"))


def require_env(name: str) -> str:
    value = os.environ.get(name)
    if not value:
        sys.exit(f"Missing required environment variable '{name}'. "
                 f"Export it or pass --env-file pointing at a file that sets it.")
    return value


def sql_literal(value, sql_type: str) -> str:
    """Render one Python value as a Databricks SQL literal of the given type."""
    if value is None:
        return "null"

    if sql_type == "date":
        return f"date'{value}'"

    if sql_type.startswith("decimal"):
        return f"cast({Decimal(str(value))} as {sql_type})"

    if sql_type in ("int", "bigint"):
        return str(int(value))

    # string: single quotes doubled, backslashes escaped. Databricks treats a
    # backslash as an escape character inside string literals by default.
    text = str(value).replace("\\", "\\\\").replace("'", "''")
    return f"'{text}'"


def create_table_ddl(table: Table, full_name: str) -> str:
    columns = ",\n    ".join(f"`{name}` {sql_type}" for name, sql_type in table.columns)
    return f"create table {full_name} (\n    {columns}\n)"


def insert_statements(table: Table, full_name: str):
    """Yield one multi-row INSERT per batch of rows."""
    types = dict(table.columns)
    column_list = ", ".join(f"`{c}`" for c in table.column_names)

    for start in range(0, len(table.rows), ROWS_PER_INSERT):
        batch = table.rows[start:start + ROWS_PER_INSERT]
        values = ",\n    ".join(
            "(" + ", ".join(sql_literal(row.get(c), types[c])
                            for c in table.column_names) + ")"
            for row in batch
        )
        yield f"insert into {full_name} ({column_list}) values\n    {values}"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--as-of", default=date.today().isoformat(),
                        help="Load-control date the calendar anchors on (default: today).")
    parser.add_argument("--schema",
                        help=f"Target schema. Defaults to <schema>_{SCHEMA_SUFFIX}, "
                             f"matching what macros/source.sql looks for.")
    parser.add_argument("--catalog", help="Target catalog. Defaults to $catalog.")
    parser.add_argument("--env-file", default=".env",
                        help="File to read connection variables from (default: .env).")
    parser.add_argument("--dry-run", action="store_true",
                        help="Print the SQL that would run and connect to nothing.")
    args = parser.parse_args()

    load_env_file(Path(args.env_file))

    catalog = args.catalog or require_env("catalog")
    schema = args.schema or f"{require_env('schema')}_{SCHEMA_SUFFIX}"
    tables = build_tables(date.fromisoformat(args.as_of))

    print(f"Loading {len(tables)} dummy a360 tables into {catalog}.{schema} "
          f"as of {args.as_of}")

    def statements_for(table: Table) -> list[str]:
        full_name = f"`{catalog}`.`{schema}`.`{table.name}`"
        # Dropped and recreated rather than truncated: the point of a rebuild is
        # that the column types come back exactly as declared, not as whatever
        # the previous load left behind.
        return [
            f"drop table if exists {full_name}",
            create_table_ddl(table, full_name),
            *insert_statements(table, full_name),
        ]

    create_schema = f"create schema if not exists `{catalog}`.`{schema}`"

    if args.dry_run:
        print(f"\n{create_schema}")
        for table in tables:
            for stmt in statements_for(table):
                print(f"\n{stmt[:1500]}")
        print("\nNothing was executed (--dry-run).")
        return

    try:
        from databricks import sql as databricks_sql
    except ImportError:
        sys.exit("databricks-sql-connector is not installed. "
                 "pip install databricks-sql-connector")

    connection = databricks_sql.connect(
        server_hostname=require_env("host"),
        http_path=require_env("http_path"),
        access_token=require_env("token"),
    )

    try:
        with connection.cursor() as cursor:
            cursor.execute(create_schema)
            for table in tables:
                for stmt in statements_for(table):
                    cursor.execute(stmt)
                print(f"  {table.name:<34} {len(table.rows):>6} rows")
    finally:
        connection.close()

    print(f"\nLoaded into {catalog}.{schema}.")
    print("Next: dbt build --vars '{use_dummy_data: true}'")


if __name__ == "__main__":
    main()
