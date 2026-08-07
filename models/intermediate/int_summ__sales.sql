-- Original CTE: sales
-- Year-to-date new business for the reporting month: one row per month.
--
-- NOTE ON THE YTD FILTER
-- The original wrote it as
--     WHERE YEAR(cnt_eff_dt) = YEAR(month_end_date) AND cnt_eff_dt <= month_end_date
-- which is exactly equivalent to `cnt_eff_dt between ytd_begin_dt and month_end_date`
-- but wraps the column in YEAR(), so it cannot prune partitions. `ytd_begin_dt`
-- was already being computed in the dates CTE of all three cells and never used
-- anywhere -- presumably this is what it was for. Using the sargable form.
--
-- ytd_begin_dt is the one genuinely YTD-specific date: 1 January of the
-- reporting year. The other end of the window is just the reporting month end,
-- which is why it is named month_end_date rather than ytd_end_dt.
with dates as (
    select * from {{ ref('stg_pdm__dates') }}
),

ytd_sales as (
    select dtl.*
    from {{ ref('ppg_metrics_dtl') }} dtl
    inner join dates dt
        on dtl.month_end_date = dt.month_end_date
    where dtl.cnt_eff_dt >= dt.ytd_begin_dt
      and dtl.cnt_eff_dt <= dt.month_end_date
)

select
    month_end_date,

    count(distinct case when gm_flag = 'Y' then primry_ownr_cl_id end)
        as gm_plan_sales,
    count(distinct case when fp_flag = 'Y' then primry_ownr_cl_id end)
        as fp_plan_sales,
    count(distinct case when gm_flag = 'Y' or fp_flag = 'Y' then primry_ownr_cl_id end)
        as overall_ppg_sales,
    count(distinct primry_ownr_cl_id)
        as total_sales,

    -- nullif guards a divide-by-zero the original left open. It can only fire
    -- if every primry_ownr_cl_id in the month is null, which the not_null test
    -- on ppg_metrics_dtl should already prevent -- belt and braces.
    round(
        count(distinct case when gm_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales_gm,
    round(
        count(distinct case when fp_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales_fp,
    round(
        count(distinct case when gm_flag = 'Y' or fp_flag = 'Y' then primry_ownr_cl_id end) * 100.0
        / nullif(count(distinct primry_ownr_cl_id), 0), 1)
        as ppg_sales

from ytd_sales
group by 1
