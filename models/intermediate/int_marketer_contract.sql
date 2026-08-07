/*
    Resolves the 9999 "open ended" sentinel in the contract end date into a real
    timestamp, so downstream BETWEEN comparisons behave.

    The original used current_date here while the rest of the query used the
    load date. That inconsistency is fixed -- everything now anchors to cur_dt.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

status as (

    select s.*
    from {{ ref('stg_a360__marketer_status') }} s
    inner join {{ ref('active_status_codes') }} c
        on c.status_cd = s.status_cd

)

select

      s.mktr_no
    , s.status_cd
    , s.status_valid_from

    , case
        when s.status_valid_to_raw like '%9999%'
            then dateadd(day, -1, dateadd(year, 1, date_trunc('year', d.cur_dt)))
        else cast(s.status_valid_to_raw as timestamp)
      end as contract_end_dt

from status s
cross join dates d

-- Keep only the status row in force at the start of the reporting month. The
-- comparison is against status_valid_to (the typed column, sentinel already
-- resolved to 9999-12-31), not the raw string -- comparing a timestamp to a
-- string is a coin toss about which side gets coerced.
where date_trunc('month', d.cur_dt)
      between s.status_valid_from and s.status_valid_to
