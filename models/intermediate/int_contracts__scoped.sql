-- Original CTE: core_contracts
-- Contracts in scope for PPG, with the IDI override applied to lob_nm.
--
-- WHAT "IN SCOPE" DOES AND DOES NOT MEAN
-- The upstream `edh_record_status_in = 'A'` filter has always meant "the latest
-- version of this row", never "not lapsed" -- 'A' is exactly equivalent to the
-- open-ended validity interval, and no lapse or cancellation status is recorded
-- in that column at all. Confirmed by steps 3b and 3c of
-- analyses/diagnose_pdm_history.sql and enforced by
-- tests/assert_pdm_status_matches_version.sql.
--
-- So nothing upstream of here removes terminated contracts. The only thing that
-- narrows the population to live business is the inner join to
-- int_clients__active_eop in ppg_metrics_dtl, which comes from the metrics
-- marketplace policy-owner fact (dim_po_status_sk in (1,2,3)) -- a different
-- source entirely.
--
-- If a contract-level lapse filter is ever wanted, it belongs here, and it
-- needs a column that actually carries that meaning.
with scoped_contracts as (
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
)
select * from scoped_contracts