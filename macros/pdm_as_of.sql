{#
    Replaces a bare `where edh_record_status_in = 'A'` in the PDM staging models.

    THE PROBLEM THIS SOLVES
    edh_record_status_in is a CURRENT-STATE flag, not a temporal one. 'A' means
    "this is the row that is live right now". It carries no information about
    what was live at a past month end. So no combination of status values can
    reconstruct history -- filtering to 'I' gives you rows that are dead now,
    not rows that were alive then, and you cannot tell WHEN they died.

    Point-in-time reconstruction needs a validity INTERVAL per row. Four modes:

    'current'      -- today's truth (the original behaviour). Backfills are
                      refused by tests/assert_backfill_is_honest.sql, because
                      they would stamp today's data with a past month.

    'scd2'         -- the real answer, IF the PDM tables are Type 2. Swap the
                      status flag for `eff <= as_of < exp`. Set the two column
                      names in vars once you have confirmed them with
                      analyses/diagnose_pdm_history.sql.

    'time_travel'  -- Delta's own version log. Correct without any modelling
                      work, but only reaches back as far as retention (30 days
                      by default). Good for last month, not for 2025.

    'snapshot'     -- read from the dbt snapshots in snapshots/, which build
                      real SCD2 history going forward from the day you start
                      running them. The only option that works when the source
                      overwrites in place.

    TABLE ARGUMENT
    The table name is required, not decorative. Only the three tables in
    var('pdm_snapshotted_tables') have snapshots, so in 'snapshot' mode the
    other five must keep the plain status predicate -- emitting dbt_valid_from
    against a live source that has no such column is a runtime error, and
    silently reverting them to current state without saying so would be worse.
    See the caveat under 'snapshot' below.
#}

{% macro pdm_as_of(table_name, alias=none) %}
    {%- set p = (alias ~ '.') if alias else '' -%}
    {%- set mode = var('pdm_history_mode', 'current') -%}

    {%- if mode == 'current' -%}
        {{ p }}edh_record_status_in = 'A'

    {%- elif mode == 'scd2' -%}
        {%- set eff = var('pdm_eff_col') -%}
        {%- set exp = var('pdm_exp_col') -%}
        {#-
            DELIBERATELY does not also require edh_record_status_in = 'A'.
            In most EDH Type 2 designs that flag marks the LATEST version of a
            key, so ANDing it with the interval collapses you back to current
            state and history silently disappears -- the exact bug this mode
            exists to fix.

            But the semantics are not universal: in some designs 'A' means
            "not soft-deleted" and is safe to combine. Confirm with step 3 of
            analyses/diagnose_pdm_history.sql before trusting this. If your
            table is the second kind, add the status predicate here.
        -#}
        {{ p }}{{ eff }} <= {{ pdm_as_of_date() }}
        and coalesce({{ p }}{{ exp }}, date'9999-12-31') > {{ pdm_as_of_date() }}

    {%- elif mode == 'snapshot' -%}
        {%- if table_name in var('pdm_snapshotted_tables', []) -%}
            {#-
                Two separate conditions, and both are needed:
                  dbt_valid_from/to    -- which VERSION of the row was live then
                  edh_record_status_in -- whether that version was ACTIVE then
                The snapshots capture the status flag as a column, so its value
                here is the value the source held on that date, not today's.
            -#}
            {{ p }}dbt_valid_from <= {{ pdm_as_of_date() }}
            and coalesce({{ p }}dbt_valid_to, date'9999-12-31') > {{ pdm_as_of_date() }}
            and {{ p }}edh_record_status_in = 'A'
        {%- else -%}
            {#-
                No snapshot exists for this table, so this predicate is CURRENT
                STATE inside an otherwise point-in-time run. A backfilled month
                is therefore a hybrid: snapshotted contracts and producers as
                they were, but owners, investment accounts and sub-accounts as
                they are today. Add a snapshot for this table before treating a
                'snapshot' mode backfill as audit-grade.
            -#}
            {{ p }}edh_record_status_in = 'A'
        {%- endif -%}

    {%- elif mode == 'time_travel' -%}
        {#- The temporal filter is on the relation itself; see pdm_relation() -#}
        {{ p }}edh_record_status_in = 'A'

    {%- else -%}
        {{ exceptions.raise_compiler_error(
            "pdm_history_mode must be one of: current, scd2, snapshot, time_travel. Got: " ~ mode) }}
    {%- endif -%}
{% endmacro %}


{#
    Wraps source()/ref() so that snapshot mode redirects to the snapshot and
    time_travel mode appends a TIMESTAMP AS OF clause. Otherwise a passthrough.
#}
{% macro pdm_relation(source_name, table_name) %}
    {%- set mode = var('pdm_history_mode', 'current') -%}

    {%- if mode == 'snapshot' and table_name in var('pdm_snapshotted_tables', []) -%}
        {{ ref('snap_pdm__' ~ table_name) }}

    {%- elif mode == 'time_travel' -%}
        {#-
            TIMESTAMP AS OF needs a literal, so 'previous_month' has to be
            resolved at compile time rather than by the warehouse. modules
            .datetime gives the same month end last_day() would.
        -#}
        {%- if var('report_month') == 'previous_month' -%}
            {%- set today = modules.datetime.date.today() -%}
            {%- set as_of = today.replace(day=1) - modules.datetime.timedelta(days=1) -%}
        {%- else -%}
            {%- set d = modules.datetime.date(*var('report_month').split('-') | map('int')) -%}
            {%- set nxt = (d.replace(day=28) + modules.datetime.timedelta(days=4)).replace(day=1) -%}
            {%- set as_of = nxt - modules.datetime.timedelta(days=1) -%}
        {%- endif -%}
        {#- End of the month end day, so the whole of that day is included. -#}
        {{ source(source_name, table_name) }} timestamp as of '{{ as_of }} 23:59:59'

    {%- else -%}
        {{ source(source_name, table_name) }}
    {%- endif -%}
{% endmacro %}
