-- THE DATE SPINE. Exactly one row, and every other model derives its dates
-- from here.
--
-- WHAT CHANGED AND WHY
-- This is a MONTHLY report, but the pipeline used to be anchored on a day.
-- The original `dates` CTE in cell 1 filtered dim_date to CURRENT_DATE and
-- cell 2 filtered it independently to ADD_MONTHS(CURRENT_DATE, -1). Both
-- always collapsed to the same previous month end no matter which day you ran
-- them, so the daily anchor carried no information -- it only made
-- ppg_stg_cnt_prd_mapping write one partition per day, and made a rerun on a
-- different day silently change an already-published month.
--
-- The reporting month is now an explicit input, ppg_var('report_month'), and it
-- accepts any day inside the target month. month_end_date is resolved from
-- dim_date, so it is a real calendar date rather than an arithmetic guess.
--
-- snapshot_date is NOT a key. It records when PDM was observed, so that a
-- month captured four days late is distinguishable from one captured on time.
-- See macros/report_dates.sql for why the two dates are separate.
with dates as (
    select distinct
        {{ pdm_as_of_date() }}                       as snapshot_date,
        mth_end_dt                                   as month_end_date,
        to_date(date_trunc('year', mth_end_dt))      as ytd_begin_dt,
        date_format(mth_end_dt, 'yyyyMMdd')          as month_end_dim_sqn
    from {{ source('pdm', 'dim_date') }}
    where clndr_dt = {{ report_month_anchor() }}
)
select * from dates
