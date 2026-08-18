/*
    ONE ROW: the date the whole report is "as of".

    The load-control table holds a row per (target system, data subject). Only
    the DASHBOARD / 'Life Premium/Paid Cases' row matters here -- that is the
    feed the marketer tables land on -- so this model filters to it and reduces
    to a single load date.

    Two things this model is deliberately doing:

      1. It anchors on the FEED's load date, not current_date. A load that runs
         late, or is re-run, then produces a self-consistent report rather than
         one where "today" and "the data" disagree.

      2. It honours the `snapshot_date` var. Leave it as 'current_date' for the
         normal daily run and the load date wins. Set it to a 'YYYY-MM-DD'
         string to rebuild the report as of some past day:

             dbt build --vars '{snapshot_date: "2026-06-30"}'

         Note that this only moves the CALENDAR. The source tables are still
         read at their current state, so a backfill is only as faithful as the
         source's own history.
*/

{%- set backfill_date = var('snapshot_date', 'current_date') -%}

with source as (

    select * from {{ source('a360', 'orap10_data_src_load_ctrl') }}

),

dashboard_feed as (

    select
        cast(ld_dt as timestamp) as ld_dt

    from source

    where upper(trim(tgt_sys_nm))      = 'DASHBOARD'
      and upper(trim(common_data_name)) = 'LIFE PREMIUM/PAID CASES'

)

select

{% if backfill_date == 'current_date' %}
      max(ld_dt)                                  as ld_dt
{% else %}
    -- Backfill run: pinned by the snapshot_date var, not by the feed. Still
    -- wrapped in max() so that this model returns exactly one row either way,
    -- however many rows the feed has.
      max(cast('{{ backfill_date }}' as timestamp)) as ld_dt
{% endif %}

from dashboard_feed
