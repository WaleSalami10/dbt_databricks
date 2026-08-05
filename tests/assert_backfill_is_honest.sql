{#
    Fails the build if you ask for a past reporting month while the PDM staging
    models are still pinned to current state.

    Without this guard, `--vars '{report_month: "2026-06-30"}'` silently
    produces TODAY's contracts, owners and producers stamped with June's month
    end, and writes them into June's partition. The output looks plausible,
    passes every other test, and is wrong -- which is the worst possible failure
    mode for a backfill, because nothing downstream can detect it.

    Resolve by either running the current month, or setting pdm_history_mode to
    scd2 or snapshot. Run analyses/diagnose_pdm_history.sql to find out which of
    those is actually available to you.

    Note that 'snapshot' does not make an ARBITRARY past month honest -- it only
    reaches back to the first `dbt snapshot` run. A month earlier than that
    yields no rows rather than wrong rows, which is the right failure, but it is
    a failure. Delta time travel, which used to cover exactly this gap, is not
    enabled on these sources.
#}

{% set is_backfill = ppg_var('report_month') != 'previous_month' %}
{% set mode = ppg_var('pdm_history_mode') %}

{% if is_backfill and mode == 'current' %}

    select
        '{{ ppg_var('report_month') }}'     as requested_report_month,
        '{{ mode }}'                    as pdm_history_mode,
        'Backfill requested but PDM sources are pinned to current state. '
        || 'This would write current data into a past partition. '
        || 'Set pdm_history_mode to scd2 or snapshot.'
                                        as failure_reason

{% else %}

    select 1 as requested_report_month, 1 as pdm_history_mode, 1 as failure_reason
    where false

{% endif %}
