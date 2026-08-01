{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'insert_overwrite',
        partition_by = ['month_end_date'],
        unique_key = ['month_end_date'],
        file_format = 'delta'
    )
}}

-- Original: cell 4, INSERT INTO prod_builder_fieldexperience.ppg.ppg_metrics_summ_monthly
--
-- One row per reporting month. Two independent halves joined on the month:
--   sales        -- YTD new business counts and penetration rates
--   breadth_depth-- multi-product breadth and depth across active clients
--
-- The original's ORDER BY is dropped. Ordering an insert into a Delta table
-- does nothing for the stored result and costs a shuffle.

with sales as (
    select * from {{ ref('int_summ__sales') }}
),

breadth_depth as (
    select * from {{ ref('int_summ__breadth_depth') }}
)

select
    s.month_end_date,

    s.gm_plan_sales,
    s.fp_plan_sales,
    s.overall_ppg_sales          as plan_sales,
    s.total_sales,
    s.ppg_sales_gm               as gm_led_sales,
    s.ppg_sales_fp               as fb_led_sales,
    s.ppg_sales,

    bd.breadth_val,
    bd.depth_val,
    bd.denominator,

    round(bd.breadth_val / nullif(bd.denominator, 0), 2)  as multi_product_breadth,
    round(bd.depth_val   / nullif(bd.denominator, 0), 2)  as multi_product_depth

from sales s
left join breadth_depth bd
    on s.month_end_date = bd.month_end_date
