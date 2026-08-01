select
    cnt_id_nk,
    cnt_iss_cd_nk,
    plan_cd,
    lob_nm,
    cnt_eff_dt
from {{ source('pdm', 'dim_contract') }}
where edh_record_status_in = 'A'
