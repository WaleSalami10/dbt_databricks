/*
    First-year commission per marketer, pivoted into the five reporting periods.

    The cross join to int_reporting_periods is safe because that model is
    guaranteed to be exactly one row (see tests/assert_single_reporting_period).
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

daily_fyc as (

    select * from {{ ref('stg_a360__daily_fyc') }}

)

select

      f.mktr_no

    , {{ period_buckets('f.mk_shr_fyc_am', 'f.fyc_smy_edt', 'fyc', dates='d') }}

from daily_fyc f
cross join dates d

-- Narrow the scan to the current year before bucketing. The buckets themselves
-- never look further back than cur_yr, so nothing is lost.
where f.fyc_smy_edt between d.cur_yr and d.cur_dt

group by f.mktr_no
