-- Original CTE: core
--
-- The original wrote this as three near-identical UNION ALL branches that
-- differed only by (a) which LOBs they let through and (b) which producer-role
-- filter was commented out. One branch driven by a seed replaces all three.
with contracts as (
    select * from {{ ref('int_contracts__scoped') }}
),

owners as (
    select * from {{ ref('int_owners__by_contract') }}
),

producers as (
    select * from {{ ref('stg_pdm__contract_producer') }}
),

roles as (
    select * from {{ ref('lob_producer_role') }}
),

joined as (
    select
        cn.lob_nm,
        cn.plan_cd,
        cn.cnt_id_nk,
        cn.cnt_iss_cd_nk,
        cn.cnt_eff_dt,
        cl.primry_ownr_cl_id,
        cp.producer_id_nk,
        cp.producer_cnt_role_nm,
        rl.preferred_producer_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
    left join roles rl
        on  rl.lob_nm = cn.lob_nm
    {{ pick_producer('cn.cnt_id_nk, cn.cnt_iss_cd_nk') }}
)

select distinct
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm
from joined
