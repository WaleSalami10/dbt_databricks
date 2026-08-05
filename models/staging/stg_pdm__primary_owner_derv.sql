with primary_owner_derv as (
select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id,
    primry_ownr_cl_role_eff_dt,
    rec_tp_cd
from {{ pdm_relation('pdm', 'fact_primary_owner_derv') }}
where {{ pdm_as_of('fact_primary_owner_derv') }}
)
select * from primary_owner_derv
