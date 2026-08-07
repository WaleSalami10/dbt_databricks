{#
    Replaces a bare `where edh_record_status_in = 'A'` in the PDM staging models.

    THE PROBLEM THIS SOLVES
    edh_record_status_in is a CURRENT-STATE flag, not a temporal one. 'A' means
    "this is the row that is live right now". It carries no information about
    what was live at a past month end. So no combination of status values can
    reconstruct history -- filtering to 'I' gives you rows that are dead now,
    not rows that were alive then, and you cannot tell WHEN they died.

    Point-in-time reconstruction needs a validity INTERVAL per row. Two modes:

    'current'   -- today's truth (the original behaviour). Backfills are refused
                   by tests/assert_backfill_is_honest.sql, because they would
                   stamp today's data with a past month.

    'scd2'      -- point-in-time. All eight PDM tables carry
                   edh_record_start_ts / edh_record_end_ts and the source is
                   confirmed Type 2, so the interval replaces the status flag
                   entirely.

    WHY THERE ARE ONLY TWO
    Two further modes lived here while the source was being characterised. Both
    were removed once it was:

      time_travel -- read the source with TIMESTAMP AS OF. Removed: Delta time
                     travel is not enabled on the PDM tables, so there is no
                     version log to read.

      snapshot    -- accumulate SCD2 history forward with dbt snapshots.
                     Removed: that was the fallback for a source that overwrites
                     in place, and PDM does not. It reached back only as far as
                     the first snapshot run, needed its own daily schedule, and
                     covered three of the eight tables -- so a snapshot-mode
                     backfill was always a hybrid of real history and current
                     state. scd2 supersedes it on every axis.

                     It is in git history if the source ever stops versioning,
                     but note that restoring the code would not restore any
                     history: snapshots only accumulate forward from the first
                     run. If that risk ever needs covering, the answer is to
                     start running them, not to keep the branch dormant.
#}

{% macro pdm_as_of(alias=none) %}
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

    {%- else -%}
        {{ exceptions.raise_compiler_error(
            "pdm_history_mode must be 'current' or 'scd2'. Got: " ~ mode
            ~ ". ('time_travel' and 'snapshot' were both removed -- see the "
            ~ "header of macros/pdm_as_of.sql for why.)") }}
    {%- endif -%}
{% endmacro %}
