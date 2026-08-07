-- Original CTE: core
--
-- The original wrote this as three near-identical UNION ALL branches that
-- differed only by (a) which LOBs they let through and (b) which producer-role
-- filter was commented out. The LOB split is handled upstream in
-- int_contracts__scoped, so one branch covers all three.
--
-- ⚠ THE PRODUCER ROLE FILTERS ARE OFF, exactly as in the original ⚠
-- Every `and cp.producer_cnt_role_nm = '...'` line below is commented out,
-- verbatim from the notebook. With them off, a contract carrying three
-- producers in three roles produces THREE ROWS, and `select distinct` does not
-- collapse them because the producer columns differ. That fan-out reaches
-- ppg_metrics_dtl and ppg_metrics_monthly, so contract counts there are
-- inflated wherever a contract has more than one producer.
--
-- It does NOT reach ppg_metrics_summ_monthly -- every figure there is a
-- count(distinct client) or count(distinct contract), so duplicate producer
-- rows collapse. The summary is safe; the two detail tables are the ones to
-- check.
--
-- Uncomment the line for a LOB to restore that filter. Note they are per-LOB
-- because the original applied a different role to each branch, so switching
-- one on does not imply the others.
with contracts as (
    select * from {{ ref('int_contracts__scoped') }}
),

owners as (
    select * from {{ ref('int_owners__by_contract') }}
),

producers as (
    select * from {{ ref('stg_pdm__contract_producer') }}
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
        cp.producer_cnt_role_nm
    from contracts cn
    inner join owners cl
        on  cl.cnt_acct_id_nk = cn.cnt_id_nk
        and cl.iss_cd_nk      = cn.cnt_iss_cd_nk
    left join producers cp
        on  cp.cnt_id_nk      = cn.cnt_id_nk
        and cp.cnt_iss_cd_nk  = cn.cnt_iss_cd_nk
        -- LIFE INSURANCE  branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- ANNUITIES       branch:
        -- and cp.producer_cnt_role_nm = 'ORIGINAL PRODUCER'
        -- LONG TERM CARE  branch:
        -- and cp.producer_cnt_role_nm = 'PERMANENT SERVICING PRODUCER'
        -- IDI             branch:
        -- and cp.producer_cnt_role_nm = 'UNKNOWN'
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
