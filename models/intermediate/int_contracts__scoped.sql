-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
select distinct
    case
        when cnt_iss_cd_nk = 'IDI' then 'IDI'
        else lob_nm
    end                 as lob_nm,
    plan_cd,
    cnt_id_nk,
    cnt_iss_cd_nk,
    cnt_eff_dt
from {{ ref('stg_pdm__contracts') }}
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'
