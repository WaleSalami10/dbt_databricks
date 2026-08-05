with invest_account as (
select
    invest_acct_id_nk,
    invest_acct_cd
from {{ pdm_relation('pdm', 'dim_invest_account') }}
where {{ pdm_as_of('dim_invest_account') }}
)
select * from invest_account
