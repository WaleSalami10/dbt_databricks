{{ config(tags=['intermediate', 'monthly']) }}

/*
    The `mk` CTE from the FOD query. Marketers who are (a) live on the EDH
    lake dashboard and (b) have an application on file on or after the FOD
    program's 2024-01-01 inception date.

    2024-01-01 is a fixed inception date, not a rolling window -- unlike the
    year filter in int_fod_events, it does not need to move with the as-of
    date, so it stays a literal.
*/

with dashboard as (

    select * from {{ ref('stg_lake_orap10__marketer') }}
    where edh_record_status_in = 'A'

),

appl_history as (

    -- select distinct, same as the source query's subquery: application
    -- history carries one row per version and only the (marketer, date)
    -- pair matters here.
    select distinct
          mktr_no
        , orig_appl_dt
    from {{ ref('stg_lake_orap10__marketer_appl_history') }}
    where orig_appl_dt >= '2024-01-01'

)

select

      d.mktr_no
    , d.rcr_no

from dashboard d

inner join appl_history h
    on d.mktr_no = h.mktr_no
