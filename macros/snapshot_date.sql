{#
    Single source of truth for "what day is this run anchored to".
    Every model that needs the run date calls this instead of hard-coding
    CURRENT_DATE, which is what made the original notebook un-backfillable.
#}
{% macro snapshot_date() %}
    {%- if var('snapshot_date') == 'current_date' -%}
        current_date
    {%- else -%}
        date'{{ var('snapshot_date') }}'
    {%- endif -%}
{% endmacro %}
