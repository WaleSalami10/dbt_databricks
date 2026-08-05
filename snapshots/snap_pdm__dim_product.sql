{#
    Small, slow-moving, and drives every product_type value in the mapping
    table. Cheap to snapshot and the one most likely to explain "why did this
    contract change category last month".
#}

{% snapshot snap_pdm__dim_product %}
{{
    config(
        target_schema = 'snapshots',
        unique_key = 'plan_cd_nk',
        strategy = 'check',
        check_cols = ['product_ln_cd', 'product_grp_nm', 'product_nm', 'edh_record_status_in'],
        invalidate_hard_deletes = True
    )
}}

select
    plan_cd_nk,
    product_ln_cd,
    product_grp_nm,
    product_nm,
    edh_record_status_in
from {{ source('pdm', 'dim_product') }}

{% endsnapshot %}
