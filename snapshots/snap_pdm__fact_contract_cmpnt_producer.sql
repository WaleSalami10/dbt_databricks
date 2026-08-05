{#
    Producer assignments change more often than contracts do -- a servicing
    producer reassignment is exactly the kind of edit that overwrites in place
    and leaves no trace. If you snapshot only one table, snapshot this one.
#}

{% snapshot snap_pdm__fact_contract_cmpnt_producer %}
{{
    config(
        target_schema = 'snapshots',
        unique_key = "cnt_id_nk || '~' || cnt_iss_cd_nk || '~' || producer_id_nk",
        strategy = 'check',
        check_cols = ['producer_cnt_role_nm', 'edh_record_status_in'],
        invalidate_hard_deletes = True
    )
}}

select
    cnt_id_nk,
    cnt_iss_cd_nk,
    producer_id_nk,
    trim(producer_cnt_role_nm) as producer_cnt_role_nm,
    edh_record_status_in
from {{ source('pdm', 'fact_contract_cmpnt_producer') }}
-- Current version only: the source is Type 2, and snapshotting every version
-- at once duplicates the unique_key. See snap_pdm__dim_contract.
where edh_record_status_in = 'A'

{% endsnapshot %}
