-- int_summ__client_breadth_depth collapses a hard-coded set of product_type
-- values into a single 'TERM' unit when computing depth. Those strings are
-- produced by seeds/product_category_map.csv. If somebody renames a product
-- type in the seed, the depth rule silently stops collapsing and every client
-- with term policies gets a higher depth, with no error anywhere.
--
-- This test fails if any configured value no longer exists in the seed.
{% set term_types = ppg_var('depth_collapse_product_types') %}

with expected as (
    {% for t in term_types %}
    select '{{ t }}' as product_type
    {% if not loop.last %}union all{% endif %}
    {% endfor %}
)

select e.product_type
from expected e
left join {{ ref('product_category_map') }} m
    on m.product_type = e.product_type
where m.product_type is null
