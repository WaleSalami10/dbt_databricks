-- Original CTE: breadth_depth
-- Rolls the per-client figures up to one row per month.
select
    month_end_date,
    sum(breadth_count)                  as breadth_val,
    sum(depth_count)                    as depth_val,
    count(distinct primry_ownr_cl_id)   as denominator
from {{ ref('int_summ__client_breadth_depth') }}
group by 1
