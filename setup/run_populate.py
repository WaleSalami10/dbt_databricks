"""Execute setup/populate_sources.sql against Databricks.

Uses the same environment variables as ~/.dbt/profiles.yml:
    host, http_path, token

Usage:
    pip install databricks-sql-connector
    python setup/run_populate.py
"""

import os
import sys
from pathlib import Path

from databricks import sql

SCRIPT = Path(__file__).with_name("populate_sources.sql")


def statements(text: str):
    for raw in text.split(";"):
        stmt = "\n".join(
            line for line in raw.splitlines() if not line.strip().startswith("--")
        ).strip()
        if stmt:
            yield stmt


def main() -> int:
    missing = [v for v in ("host", "http_path", "token") if not os.environ.get(v)]
    if missing:
        print(f"Missing environment variables: {', '.join(missing)}")
        return 1

    stmts = list(statements(SCRIPT.read_text()))
    with sql.connect(
        server_hostname=os.environ["host"],
        http_path=os.environ["http_path"],
        access_token=os.environ["token"],
    ) as conn:
        with conn.cursor() as cur:
            for i, stmt in enumerate(stmts, 1):
                first_line = stmt.splitlines()[0]
                print(f"[{i}/{len(stmts)}] {first_line}")
                cur.execute(stmt)
    print("Done: all source tables created and populated.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
