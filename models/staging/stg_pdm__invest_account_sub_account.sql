with invest_account_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_acct_id
from {{ pdm_relation('pdm', 'fact_invest_account_sub_account') }}
where {{ pdm_as_of('fact_invest_account_sub_account') }}
)
select * from invest_account_sub_account
