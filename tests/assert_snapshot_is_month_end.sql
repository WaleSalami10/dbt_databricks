{{ config(severity = 'warn') }}

{#
    Warns when the month was observed after it ended.

    This is the small version of the backfill problem, and it fires on ordinary
    runs. In 'current' mode PDM only holds today's state, so a report built on
    4 August for the July month end describes 31 July using 4 August's
    contracts, producers and owners. Four days of new business, lapses and
    producer reassignments leak into July's numbers.

    That is usually tolerable and it is how the original notebook always
    behaved, so this warns rather than fails. It is an error only in the sense
    that the number is not reproducible: rerun the same month a week later in
    'current' mode and you get a different answer.

    Any other pdm_history_mode reads the month end itself, so snapshot_date
    equals month_end_date and this is silent. The drift figure below is the
    honest measure of how approximate the month is.
#}

select
    month_end_date,
    max(snapshot_date)                              as observed_at,
    datediff(max(snapshot_date), month_end_date)    as days_of_drift
from {{ ref('ppg_stg_cnt_prd_mapping') }}
group by month_end_date
having max(snapshot_date) > month_end_date
