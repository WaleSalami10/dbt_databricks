with contract_producer as (
select
    cnt_id_nk,
    cnt_iss_cd_nk,
    producer_id_nk,
    trim(producer_cnt_role_nm) as producer_cnt_role_nm
from {{ source('pdm', 'fact_contract_cmpnt_producer') }}
where edh_record_status_in = 'A'
)

select*
from contract_producer
