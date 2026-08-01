-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. Seed-driven single branch here.
with accounts as (
    select * from {{ ref('int_wm_accounts') }}
),

owners as (
    select * from {{ ref('int_owners__by_invest_acct') }}
),

producers as (
    select * from {{ ref('stg_pdm__invest_account_producer') }}
),

roles as (
    select * from {{ ref('lob_producer_role') }}
),

joined as (
    select
        cn.product_nm                       as lob_nm,
        cn.plan_cd,
        cn.invest_acct_id                   as cnt_id_nk,
        cn.invest_acct_cd                   as cnt_iss_cd_nk,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm,
        rl.preferred_producer_role_nm,
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
    left join roles rl
        on rl.lob_nm = cn.product_nm
    group by 1, 2, 3, 4, 5, 6, 7, 8
    {{ pick_producer('cnt_id_nk, cnt_iss_cd_nk') }}
)

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
