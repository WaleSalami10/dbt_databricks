{#
    EVERY TUNABLE IN THIS PROJECT LIVES HERE.

    dbt only reads a `vars:` block from dbt_project.yml or from --vars on the
    command line; there is no supported way to point it at a separate vars file.
    So to keep dbt_project.yml to structure only, the defaults live in this
    macro instead and models call ppg_var('name') rather than var('name').

    Overriding still works exactly as before, because ppg_var falls through to
    var() with the default below:

        dbt build --vars '{report_month: "2026-06-30"}'
        dbt build --vars '{pdm_history_mode: scd2}'

    A name not listed here raises a compiler error rather than silently
    returning none, which is the main thing a bare var() call gets wrong: a typo
    in a var name reads as "undefined" and quietly takes the false branch.

    Built with `do d.update(...)` rather than one dict literal because Jinja
    comments cannot appear inside an expression, and these defaults are worth
    more documented than compact.
#}

{% macro ppg_defaults() %}

    {% set d = {} %}

    {#
        WHICH MONTH IS BEING REPORTED. This is a monthly report: the reporting
        grain is a calendar month and every mart is partitioned by
        month_end_date.

          'previous_month'  -- the normal run: most recent complete month.
          'YYYY-MM-DD'      -- ANY day inside the month you want. The month end
                               is resolved from dim_date, so '2026-07-01',
                               '2026-07-14' and '2026-07-31' all mean the July
                               2026 report.

        Backfilling a past month is REFUSED while pdm_history_mode is
        'current' -- see tests/assert_backfill_is_honest.sql for why.
    #}
    {% do d.update({'report_month': 'previous_month'}) %}

    {#
        How the PDM staging models resolve "what was true at month end".
          current  -- today's state only. Backfill refused. (default)
          scd2     -- point-in-time, using the two validity columns below.

        Those are the only two. Delta time travel is not enabled on the PDM
        sources, and dbt-snapshot mode was removed once the source was confirmed
        Type 2 -- see the header of macros/pdm_as_of.sql.

        Note that 'current' is approximate even for the normal run: a report
        built on 5 August for the July month end reads 5 August's contract
        state. Only scd2 is exact.
    #}
    {% do d.update({'pdm_history_mode': 'current'}) %}

    {#
        Only used when pdm_history_mode = 'scd2'. Confirmed present on all eight
        PDM tables by step 1 of analyses/diagnose_pdm_history.sql. These are
        RECORD validity timestamps -- when this version of the row was true --
        as distinct from business dates like cnt_eff_dt.

        They are TIMESTAMPS, not dates, and the intervals are CLOSED with a
        one-second gap. The as-of predicate is built from pdm_as_of_instant()
        accordingly; see macros/report_dates.sql.
    #}
    {% do d.update({'pdm_eff_col': 'edh_record_start_ts'}) %}
    {% do d.update({'pdm_exp_col': 'edh_record_end_ts'}) %}

    {#
        true  -- a client with no planning record, or one whose plan completed
                 after the reporting month, gets 'N' flags
        false -- reproduce the original NULLs
    #}
    {% do d.update({'coalesce_planning_flags': true}) %}

    {#
        One-time fold-in of pre-migration history from ppg_metrics_dtl_hist.
        Leave false for normal runs; see the ppg_metrics_monthly header.
    #}
    {% do d.update({'include_historical_load': false}) %}
    {% do d.update({'historical_load_from': none}) %}

    {#
        Product types that collapse to a single unit when computing depth in
        ppg_metrics_summ_monthly. These must be values emitted by
        seeds/product_category_map.csv;
        tests/assert_depth_collapse_types_exist.sql enforces that.
    #}
    {% do d.update({'depth_collapse_product_types': [
        'Level Term and Level Convertible_Renewable Term',
        'Yearly Convertible_Renewable Term'
    ]}) %}

    {{ return(d) }}

{% endmacro %}


{% macro ppg_var(name) %}
    {%- set defaults = ppg_defaults() -%}
    {%- if name not in defaults -%}
        {{ exceptions.raise_compiler_error(
            "Unknown ppg var: '" ~ name ~ "'. Known vars: "
            ~ (defaults.keys() | list | sort | join(', '))) }}
    {%- endif -%}
    {{ return(var(name, defaults[name])) }}
{% endmacro %}
