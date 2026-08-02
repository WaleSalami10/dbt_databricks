with invest_account_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_acct_id
from {{ source('pdm', 'fact_invest_account_sub_account') }}
where edh_record_status_in = 'A'
)
select * from invest_account_sub_account
