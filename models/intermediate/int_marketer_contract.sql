/*
    Resolves the 9999 "open ended" sentinel in the contract end date into a real
    timestamp, so downstream BETWEEN comparisons behave.

    The original used current_date here while the rest of the query used the
    load date. That inconsistency is fixed -- everything now anchors to cur_dt.

    The active-status IN list below is FOD_query.sql lines 169-171, verbatim.

    KEEP IT IN SYNC WITH int_class_by_marketer, which carries the same ten
    codes. Nothing enforces the match; see that model's header for what drift
    costs.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

status as (

    select s.*
    from {{ ref('stg_a360__marketer_status') }} s
    where s.mk_sts_tp_cd in ('01', '04', '05', '07', '08', '09', '0A', '0B', '0C', '1C')

)

select

      s.mktr_no
    , s.mk_sts_tp_cd
    , s.mk_sts_atv_edt

    , case
        when s.mk_sts_atv_xdt_raw like '%9999%'
            then dateadd(day, -1, dateadd(year, 1, date_trunc('year', d.cur_dt)))
        else cast(s.mk_sts_atv_xdt_raw as timestamp)
      end as contractenddate

from status s
cross join dates d

-- Keep only the status row in force at the start of the reporting month. The
-- comparison is against mk_sts_atv_xdt (the typed column, sentinel already
-- resolved to 9999-12-31), not the raw string -- comparing a timestamp to a
-- string is a coin toss about which side gets coerced.
where date_trunc('month', d.cur_dt)
      between s.mk_sts_atv_edt and s.mk_sts_atv_xdt
