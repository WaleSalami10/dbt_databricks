-- NB: the source column really is spelled `prodcuer_role_cd_desc`.
-- Renamed here so the typo stops leaking into every downstream model.
with invest_account_producer as (
select
    invest_acct_id_nk,
    invest_acct_cd,
    producer_id_nk,
    trim(prodcuer_role_cd_desc) as producer_cnt_role_nm
from {{ pdm_relation('pdm', 'fact_invest_account_producer_role') }}
where {{ pdm_as_of('fact_invest_account_producer_role') }}
)
select * from invest_account_producer
