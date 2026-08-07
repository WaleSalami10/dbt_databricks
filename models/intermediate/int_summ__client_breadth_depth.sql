-- Original CTE: base
-- Breadth and depth per client per month. Kept as its own model because
-- client-level breadth/depth is useful on its own, not only as an input to the
-- monthly rollup.
--
-- DEPTH RULE: all term products collapse to a single unit. A client with five
-- term policies and two whole life contracts has depth 3, not 7. The product
-- types that collapse are in ppg_var('depth_collapse_product_types') -- they are
-- values produced by seeds/product_category_map.csv, and
-- tests/assert_depth_collapse_types_exist.sql fails the build if the two ever
-- drift apart.
{% set term_types = ppg_var('depth_collapse_product_types') %}

with dates as (
    select * from {{ ref('stg_pdm__dates') }}
),

active_clients as (
    select * from {{ ref('int_summ__active_clients') }}
),

scoped as (
    -- The original read ppg_metrics_dtl here with no month predicate at all and
    -- relied on the join to active_clients to constrain it. That worked, but
    -- only by accident: it scans every retained month before filtering. The
    -- explicit month filter lets the partition prune.
    select ppg.*
    from {{ ref('ppg_metrics_dtl') }} ppg
    inner join dates dt
        on ppg.month_end_date = dt.month_end_date
)

select
    ppg.month_end_date,
    ppg.primry_ownr_cl_id,

    count(distinct ppg.product_category_need_based_by_product)
        as breadth_count,

    count(distinct
        case
            when ppg.product_type in (
                {%- for t in term_types %}
                '{{ t }}'{% if not loop.last %},{% endif %}
                {%- endfor %}
            )
            then 'TERM'
            else ppg.cnt_id_nk
        end
    ) as depth_count

from scoped ppg
inner join active_clients ac
    on  ppg.primry_ownr_cl_id = ac.primry_ownr_cl_id
    and ppg.month_end_date    = ac.month_end_date
group by 1, 2
