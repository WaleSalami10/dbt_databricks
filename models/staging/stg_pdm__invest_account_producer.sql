-- NB: the source column really is spelled `prodcuer_role_cd_desc`.
-- Renamed here so the typo stops leaking into every downstream model.
select
    invest_acct_id_nk,
    invest_acct_cd,
    producer_id_nk,
    trim(prodcuer_role_cd_desc) as producer_cnt_role_nm
from {{ source('pdm', 'fact_invest_account_producer_role') }}
where edh_record_status_in = 'A'
