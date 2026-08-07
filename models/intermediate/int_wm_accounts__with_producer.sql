-- Original CTE: wm
--
-- As with the contract side, the original had two UNION ALL branches split by
-- product_nm purely so each could carry a different (commented-out) producer
-- role filter. The product_nm split is handled upstream in
-- stg_pdm__invest_sub_account, so one branch covers both.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Same fan-out caveat as int_contracts__with_producer -- see the header there.
-- The two branches used DIFFERENT roles, so uncommenting is per product family,
-- not all-or-nothing.
with accounts as (
    select * from {{ ref('int_wm_accounts') }}
),

owners as (
    select * from {{ ref('int_owners__by_invest_acct') }}
),

producers as (
    select * from {{ ref('stg_pdm__invest_account_producer') }}
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
        min(cn.invest_sub_acct_eff_dt)      as cnt_eff_dt
    from accounts cn
    inner join owners cl
        on cl.cnt_acct_id_nk = cn.invest_acct_id
    left join producers cp
        on  cp.invest_acct_id_nk = cn.invest_acct_id
        and cp.invest_acct_cd    = cn.invest_acct_cd
        -- EAGLE / NYLIFE SEC / MAINSTAY branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- NP MUTFNDS / NP529           branch:
        -- and cp.producer_cnt_role_nm = 'PRODUCER OF RECORD'
    -- Was `group by 1..8`; column 8 was the seed's preferred_producer_role_nm.
    -- Dropping it does not change the grouping -- it was functionally dependent
    -- on lob_nm, which is still column 1.
    group by 1, 2, 3, 4, 5, 6, 7
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
