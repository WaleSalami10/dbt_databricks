select
    invest_sub_acct_id_nk,
    invest_acct_id
from {{ source('pdm', 'fact_invest_account_sub_account') }}
where edh_record_status_in = 'A'
