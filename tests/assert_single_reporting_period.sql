/*
    int_reporting_periods must contain EXACTLY ONE ROW.

    Every fact model cross-joins to it. Two rows there does not raise an error
    anywhere -- it silently doubles every marketer, every commission total and
    every case count in the mart. Zero rows silently empties them.

    A unique test on cur_dt would catch the duplicate but not the empty case,
    which is why this is a singular test: it fails on any count other than one.
*/

select
      count(*) as period_row_count
    , 'int_reporting_periods must have exactly one row' as failure_reason

from {{ ref('int_reporting_periods') }}

having count(*) != 1
