with invest_account as (
select
    invest_acct_id_nk,
    invest_acct_cd
from {{ source('pdm', 'dim_invest_account') }}
where edh_record_status_in = 'A'
)
select * from invest_account
