-- Original CTE: wm_accounts

with wm_accounts as (
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from {{ ref('stg_pdm__invest_sub_account') }} wlth
inner join {{ ref('stg_pdm__invest_account_sub_account') }} acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join {{ ref('stg_pdm__invest_account') }} prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
)
select * from wm_accounts
