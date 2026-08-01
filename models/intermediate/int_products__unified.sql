-- Original CTE: core_wm
--
-- This is the contract between the insurance side and the wealth side. Any
-- column added to one branch must be added to the other. Grain and tests are
-- declared in _intermediate.yml -- test here, not only at the mart.
select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'CONTRACT' as source_domain
from {{ ref('int_contracts__with_producer') }}

union all

select
    lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt,
    primry_ownr_cl_id,
    producer_id_nk,
    producer_cnt_role_nm,
    'INVEST_ACCT' as source_domain
from {{ ref('int_wm_accounts__with_producer') }}
