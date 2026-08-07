{#
    Fails the build if the requested reporting month is not the one that
    current-state data can honestly describe.

    WHY THIS EXISTS
    In 'current' mode the PDM staging models return today's contracts, owners
    and producers. Stamping those with an earlier month end and writing them
    into that month's partition produces output that looks plausible, passes
    every other test, and is wrong -- the worst possible failure mode, because
    nothing downstream can detect it.

    Resolve by either running the month that is actually current, or setting
    pdm_history_mode to 'scd2', which reconstructs the month from the PDM
    validity intervals. 'scd2' is the only alternative: Delta time travel is not
    enabled on these sources and dbt-snapshot mode was removed once the source
    was confirmed Type 2.

    WHAT COUNTS AS "NOT CURRENT"
    This used to compare var('report_month') against the literal string
    'previous_month', which meant ANY explicit date tripped it -- including the
    current reporting month written out longhand, e.g.

        dbt build --vars '{report_month: "2026-07-30"}'

    run during August. That is a false positive: 30 July resolves to the same
    month end as 'previous_month' does, so the data would have been exactly what
    the default run produces. Pinning the month explicitly is a reasonable thing
    to do for a reproducible run, and it should not require switching modes.

    So both sides are now resolved to a month END date and compared as dates.
    The comparison is `!=` rather than `<` on purpose: a FUTURE month is equally
    dishonest -- it stamps today's state with a month that has not happened yet,
    which is what a mistyped year looks like. The old string test caught that by
    accident; this one catches it deliberately.
#}

{% set rm = ppg_var('report_month') %}
{% set mode = ppg_var('pdm_history_mode') %}

{#- The month end 'previous_month' resolves to: last day of the prior month. -#}
{% set today = modules.datetime.date.today() %}
{% set default_month_end = today.replace(day=1) - modules.datetime.timedelta(days=1) %}

{% if rm == 'previous_month' %}
    {% set requested_month_end = default_month_end %}
{% else %}
    {%- set parts = rm.split('-') -%}
    {%- if parts | length != 3 -%}
        {{ exceptions.raise_compiler_error(
            "report_month must be 'previous_month' or 'YYYY-MM-DD'. Got: '" ~ rm ~ "'") }}
    {%- endif -%}
    {%- set d = modules.datetime.date(*parts | map('int')) -%}
    {#- Last day of d's month: jump into the next month, then step back one day.
        Works for every month length, February included. -#}
    {% set requested_month_end =
        (d.replace(day=28) + modules.datetime.timedelta(days=4)).replace(day=1)
        - modules.datetime.timedelta(days=1) %}
{% endif %}

{% if mode == 'current' and requested_month_end != default_month_end %}

    select
        '{{ rm }}'                          as requested_report_month,
        date'{{ requested_month_end }}'     as requested_month_end,
        date'{{ default_month_end }}'       as current_month_end,
        '{{ mode }}'                        as pdm_history_mode,
        '{{ "Requested month is in the future"
              if requested_month_end > default_month_end
              else "Backfill requested" }}'
        || ' but PDM sources are pinned to current state. '
        || 'This would stamp today''s data with a month it does not describe. '
        || 'Set pdm_history_mode to scd2.'  as failure_reason

{% else %}

    select
        1 as requested_report_month, 1 as requested_month_end,
        1 as current_month_end, 1 as pdm_history_mode, 1 as failure_reason
    where false

{% endif %}
