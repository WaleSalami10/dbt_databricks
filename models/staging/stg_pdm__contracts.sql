with contracts as (
select
    cnt_id_nk,
    cnt_iss_cd_nk,
    plan_cd,
    lob_nm,
    cnt_eff_dt
from {{ pdm_relation('pdm', 'dim_contract') }}
where {{ pdm_as_of('dim_contract') }}
)
select * from contracts
