with contract_producer as (
select
    cnt_id_nk,
    cnt_iss_cd_nk,
    producer_id_nk,
    trim(producer_cnt_role_nm) as producer_cnt_role_nm
from {{ source('pdm', 'fact_contract_cmpnt_producer') }}
where {{ pdm_as_of() }}
)

select*
from contract_producer
