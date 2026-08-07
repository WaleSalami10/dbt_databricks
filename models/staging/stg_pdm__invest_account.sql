with invest_account as (
select
    invest_acct_id_nk,
    invest_acct_cd
from {{ source('pdm', 'dim_invest_account') }}
where {{ pdm_as_of() }}
)
select * from invest_account
