{#
    Single source of truth for the two dates this pipeline runs on. Every model
    calls these instead of hard-coding CURRENT_DATE, which is what made the
    original notebook un-backfillable.

    THE TWO DATES ARE NOT THE SAME THING, and conflating them was the original
    design flaw:

      report_month_anchor()  WHAT the report is about. Any day inside the
                             reporting month; stg_pdm__dates turns it into
                             month_end_date, which is the partition key and the
                             grain of every mart.

      pdm_as_of_date()       WHEN the source was observed. Lands in the
                             snapshot_date column as audit metadata only -- it
                             is not a key and nothing joins on it.

    In 'current' mode these differ: a run on 4 August reports July but observes
    August. That drift is real and tests/assert_snapshot_is_month_end.sql warns
    about it. In every other mode PDM is read as of the month end itself and the
    two dates coincide.
#}

{% macro report_month_anchor() %}
    {%- if var('report_month') == 'previous_month' -%}
        add_months(current_date, -1)
    {%- else -%}
        date'{{ var('report_month') }}'
    {%- endif -%}
{% endmacro %}


{#
    The date at which PDM state is read.

    In 'current' mode there is no choice: the source only holds today's truth,
    so today is what we get. Every other mode can read the month end exactly,
    which is what makes those modes correct rather than merely close.

    Uses last_day() rather than ref('stg_pdm__dates').month_end_date, which
    would be circular: stg_pdm__dates stamps its own snapshot_date with this
    macro. The two must agree, and tests/assert_month_end_is_calendar.sql
    fails the build if dim_date's month end ever diverges from last_day() --
    which is what would happen if dim_date were switched to a fiscal calendar.
#}
{% macro pdm_as_of_date() %}
    {%- if var('pdm_history_mode', 'current') == 'current' -%}
        current_date
    {%- else -%}
        last_day({{ report_month_anchor() }})
    {%- endif -%}
{% endmacro %}
