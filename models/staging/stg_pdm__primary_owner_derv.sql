select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id,
    primry_ownr_cl_role_eff_dt,
    rec_tp_cd
from {{ source('pdm', 'fact_primary_owner_derv') }}
where edh_record_status_in = 'A'
