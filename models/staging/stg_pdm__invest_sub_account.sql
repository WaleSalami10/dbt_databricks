with invest_sub_account as (
select
    invest_sub_acct_id_nk,
    invest_sub_acct_iss_cd_nk,
    invest_sub_acct_eff_dt,
    plan_cd,
    product_nm
from {{ pdm_relation('pdm', 'dim_invest_sub_account') }}
where {{ pdm_as_of('dim_invest_sub_account') }}
  and product_nm in ('EAGLE', 'NYLIFE SEC', 'NP MUTFNDS', 'NP529', 'MAINSTAY')
)
select * from invest_sub_account
