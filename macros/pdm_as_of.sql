{#
    Replaces a bare `where edh_record_status_in = 'A'` in the PDM staging models.

    THE PROBLEM THIS SOLVES
    edh_record_status_in is a CURRENT-STATE flag, not a temporal one. 'A' means
    "this is the row that is live right now". It carries no information about
    what was live at a past month end. So no combination of status values can
    reconstruct history -- filtering to 'I' gives you rows that are dead now,
    not rows that were alive then, and you cannot tell WHEN they died.

    Point-in-time reconstruction needs a validity INTERVAL per row. Three modes:

    'current'      -- today's truth (the original behaviour). Backfills are
                      refused by tests/assert_backfill_is_honest.sql, because
                      they would stamp today's data with a past month.

    'scd2'         -- the real answer, and the one to aim for. All eight PDM
                      tables carry edh_record_start_ts / edh_record_end_ts, so
                      the columns needed to swap the status flag for a validity
                      interval exist and are already set in vars.

                      Having the columns is NOT the same as having history:
                      steps 2 and 3 of analyses/diagnose_pdm_history.sql still
                      have to confirm that multiple versions per key are
                      actually retained and that their intervals tile. Until
                      then this mode is available but unproven, which is why
                      the project default is still 'current'.

    'snapshot'     -- read from the dbt snapshots in snapshots/, which build
                      real SCD2 history going forward from the day you start
                      running them. The only option that works when the source
                      overwrites in place.

    NO DELTA TIME TRAVEL. A fourth mode used to sit between these two, reading
    the source with TIMESTAMP AS OF. It has been removed: time travel is not
    enabled on the PDM sources, so there is no version log to read. This is
    worth knowing rather than merely noting, because time travel was the only
    option that required no modelling work AND could reach backwards. Without
    it the choice narrows hard -- either the source is Type 2 and 'scd2' works,
    or history starts the day you run `dbt snapshot` for the first time. There
    is no third path and no way to recover a month that has already passed.

    TABLE ARGUMENT
    The table name is required, not decorative. Only the three tables in
    ppg_var('pdm_snapshotted_tables') have snapshots, so in 'snapshot' mode the
    other five must keep the plain status predicate -- emitting dbt_valid_from
    against a live source that has no such column is a runtime error, and
    silently reverting them to current state without saying so would be worse.
    See the caveat under 'snapshot' below.
#}

{% macro pdm_as_of(table_name, alias=none) %}
    {%- set p = (alias ~ '.') if alias else '' -%}
    {%- set mode = ppg_var('pdm_history_mode') -%}

    {%- if mode == 'current' -%}
        {{ p }}edh_record_status_in = 'A'

    {%- elif mode == 'scd2' -%}
        {%- set eff = ppg_var('pdm_eff_col') -%}
        {%- set exp = ppg_var('pdm_exp_col') -%}
        {#-
            DO NOT ADD `and edh_record_status_in = 'A'` HERE. This is not a
            style preference and it is not an oversight -- it is measured.

            Step 3b of analyses/diagnose_pdm_history.sql returned
            closed_but_active = 0: across the whole table, 'A' never appears on
            a closed version. Every superseded version is stamped 'I' when the
            next one is written, so the flag marks the LATEST VERSION rather
            than recording a business status per version.

            ANDing it with the interval therefore selects "the version live at
            the as-of instant AND the current version", which for any past month
            is either nothing or today's row. That is the precise bug this whole
            mode exists to eliminate, and it fails silently: the backfill
            succeeds, the tests pass, and the numbers are current data wearing a
            past month's date.

            The cost of the finding: business active/inactive status as of a
            past month is NOT RECOVERABLE from this table. It was never stored
            per version. If a report ever needs "was this contract active in
            March", that question cannot be answered from PDM history and needs
            a different source.
        -#}
        {{ p }}{{ eff }} <= {{ pdm_as_of_instant() }}
        and coalesce({{ p }}{{ exp }}, timestamp'9999-12-31') >= {{ pdm_as_of_instant() }}

    {%- elif mode == 'snapshot' -%}
        {%- if table_name in ppg_var('pdm_snapshotted_tables') -%}
            {#-
                Two separate conditions, and both are needed:
                  dbt_valid_from/to    -- which VERSION of the row was live then
                  edh_record_status_in -- whether that version was ACTIVE then
                The snapshots capture the status flag as a column, so its value
                here is the value the source held on that date, not today's.
            -#}
            {#-
                dbt's own snapshot intervals ARE half-open (dbt_valid_to of one
                row equals dbt_valid_from of the next), unlike the PDM columns
                above. `from <= T and to >= T` would therefore match two rows
                for a version boundary landing exactly on T. Strict `>` on the
                upper bound is correct here and only here.
            -#}
            {{ p }}dbt_valid_from <= {{ pdm_as_of_instant() }}
            and coalesce({{ p }}dbt_valid_to, timestamp'9999-12-31') > {{ pdm_as_of_instant() }}
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

    {%- else -%}
        {{ exceptions.raise_compiler_error(
            "pdm_history_mode must be one of: current, scd2, snapshot. Got: " ~ mode
            ~ ". ('time_travel' was removed -- the PDM sources have no version log.)") }}
    {%- endif -%}
{% endmacro %}


{#
    Wraps source() so that snapshot mode reads the snapshot instead of the live
    table. A passthrough in every other mode.
#}
{% macro pdm_relation(source_name, table_name) %}
    {%- set mode = ppg_var('pdm_history_mode') -%}

    {%- if mode == 'snapshot' and table_name in ppg_var('pdm_snapshotted_tables') -%}
        {{ ref('snap_pdm__' ~ table_name) }}
    {%- else -%}
        {{ source(source_name, table_name) }}
    {%- endif -%}
{% endmacro %}
