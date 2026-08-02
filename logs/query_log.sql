-- created_at: 2026-08-02T02:24:18.907229+00:00
-- finished_at: 2026-08-02T02:24:20.564756+00:00
-- elapsed: 1.7s
-- outcome: success
-- dialect: databricks
-- node_id: not available
-- query_id: not available
-- desc: dbt run query

  
  with __dbt__cte__int_wm_accounts as (
-- Original CTE: wm_accounts
select distinct
    wlth.invest_sub_acct_id_nk,
    wlth.invest_sub_acct_iss_cd_nk,
    wlth.invest_sub_acct_eff_dt,
    wlth.plan_cd,
    wlth.product_nm,
    acc.invest_acct_id,
    prnt.invest_acct_cd
from `dbt-dev-catalog`.`dbt_osalami_staging`.`stg_pdm__invest_sub_account` wlth
inner join `dbt-dev-catalog`.`dbt_osalami_staging`.`stg_pdm__invest_account_sub_account` acc
    on acc.invest_sub_acct_id_nk = wlth.invest_sub_acct_id_nk
left join `dbt-dev-catalog`.`dbt_osalami_staging`.`stg_pdm__invest_account` prnt
    on prnt.invest_acct_id_nk = acc.invest_sub_acct_id_nk
), __dbt__cte__int_owners__by_invest_acct as (
-- Original CTE: wm_clients


select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from `dbt-dev-catalog`.`dbt_osalami_staging`.`stg_pdm__primary_owner_derv`
where rec_tp_cd = 'INVEST_ACCT'
qualify row_number() over (
    partition by cnt_acct_id_nk
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1


)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (
-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. Seed-driven single branch here.
with accounts as (
    select * from __dbt__cte__int_wm_accounts
),

owners as (
    select * from __dbt__cte__int_owners__by_invest_acct
),

producers as (
    select * from `dbt-dev-catalog`.`dbt_osalami_staging`.`stg_pdm__invest_account_producer`
),

roles as (
    select * from `dbt-dev-catalog`.`dbt_osalami_seeds`.`lob_producer_role`
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
--EPHEMERAL-SELECT-WRAPPER-END
)
  
  limit 5
;
