{{
    config(
        materialized = 'table'
    )
}}

/*
    ONE ROW. This is the report's calendar.

    Everything downstream cross-joins to this so that "today", "this week" and
    "start of year" mean exactly the same thing in every model. The anchor is
    the load date from the control table -- deliberately NOT current_date, so a
    late or re-run load produces a self-consistent report rather than a mix of
    two different "todays".

    The original query had a few duplicate columns (prv_me == prv_month_end_dt,
    cur_mnst == currentmonth). They are consolidated here to one name each.
*/

with load_control as (

    select load_dt from {{ ref('stg_a360__load_control') }}

)

select

      load_dt                                                as cur_dt

    -- Year boundaries
    , add_months(date_trunc('year', load_dt), -36)           as yr_start_dt
    , dateadd(day, -1,
        dateadd(year, 1, date_trunc('year', load_dt)))       as yr_end_dt
    , date_trunc('year', load_dt)                            as cur_yr

    -- Month boundaries
    , add_months(date_trunc('month', load_dt), -1)           as prv_mnst
    , date_trunc('month', load_dt) - interval 1 day          as prv_me
    , date_trunc('month', load_dt)                           as cur_mnst
    , cast(last_day(load_dt) as timestamp)                   as cur_month_end_dt

    /*
        Week boundaries.

        date_trunc('week', ...) in Databricks snaps to MONDAY. The +1/-1 day
        shuffle below moves that to a SUNDAY-start week, which is what the
        business reports on. Do not "simplify" it away.
    */
    , date_trunc('week', load_dt + interval '1 day')
        - interval '1 day'                                   as cw_start_dt
    , date_trunc('week', load_dt + interval '1 day')
        - interval '1 day' + interval 6 day                  as cw_end_dt
    , date_trunc('week', load_dt + interval '1 day')
        - interval '8 days'                                  as prev_week_start
    , date_trunc('week', load_dt + interval '1 day')
        - interval '8 days' + interval 6 day                 as prev_week_end

from load_control
