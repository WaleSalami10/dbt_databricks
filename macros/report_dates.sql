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
    {%- if ppg_var('report_month') == 'previous_month' -%}
        add_months(current_date, -1)
    {%- else -%}
        date'{{ ppg_var('report_month') }}'
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
    {%- if ppg_var('pdm_history_mode') == 'current' -%}
        current_date
    {%- else -%}
        last_day({{ report_month_anchor() }})
    {%- endif -%}
{% endmacro %}


{#
    The as-of INSTANT, for comparing against validity timestamps.

    The PDM validity columns (edh_record_start_ts / edh_record_end_ts) and dbt's
    own dbt_valid_from / dbt_valid_to are timestamps, not dates. Comparing them
    to a bare date is the classic silent error: `edh_record_end_ts > date'2026-06-30'`
    casts the date to 2026-06-30 00:00:00, so it asks for state at the START of
    the month end day and drops every change made during the last day of the
    month. Reliably wrong, never loudly wrong.

    This returns the LAST SECOND of the month end day -- 2026-06-30 23:59:59 --
    used with an inclusive comparison on both sides:

        start_ts <= T  and  coalesce(end_ts, '9999') >= T

    THE INTERVALS ARE CLOSED, NOT HALF-OPEN. Observed in the source:

        I   2019-11-01 04:00:00   2022-01-04 10:57:04
        I   2022-01-04 10:57:05   2022-01-05 09:12:06
        A   2022-01-05 09:12:07   9999-12-31 05:00:00

    Each version ends one second BEFORE the next begins, so end_ts is the last
    instant the version was valid rather than the instant its successor took
    over. There is a one-second hole between consecutive versions.

    That hole is why this is 23:59:59 and not the next day's midnight. With
    T = midnight, a version ending 23:59:59 on the 30th fails `end_ts >= T`
    while its successor starting 00:00:00 on the 1st fails `start_ts < T`, and
    the key vanishes from the month entirely -- no row, no error. Not
    hypothetical: the 04:00:00Z and 05:00:00Z values above are midnight
    US/Eastern, so this source demonstrably writes changes on midnight
    boundaries. Anchoring on 23:59:59 puts the comparison inside the version
    rather than inside the hole.

    TIMEZONE. Those same values say the source thinks in Eastern while storing
    UTC. T is built with last_day(), which resolves in the SESSION timezone, so
    a session running in UTC would evaluate "end of 30 June" as 23:59:59Z --
    19:59:59 Eastern, four hours early, quietly attributing the last evening of
    the month to the next one. Step 0 of analyses/diagnose_pdm_history.sql
    checks this. If the warehouse session is not Eastern, set it explicitly on
    the profile rather than compensating here.
#}
{% macro pdm_as_of_instant() %}
    cast(date_add(last_day({{ report_month_anchor() }}), 1) as timestamp) - interval 1 second
{% endmacro %}
