{#
    dim_date.mth_end_dt must be the calendar month end.

    macros/report_dates.sql computes the PDM as-of date with last_day() rather
    than by reading this model, because reading it would be circular. That is
    only safe while dim_date agrees with the calendar. If PDM ever switches
    mth_end_dt to a fiscal or accounting calendar, the partition key and the
    as-of predicate would silently point at different days -- contracts read as
    of one date, filed under another.

    Cheap to check, and the failure it prevents is invisible.
#}

select
    month_end_date,
    last_day(month_end_date)    as calendar_month_end
from {{ ref('stg_pdm__dates') }}
where month_end_date <> last_day(month_end_date)
