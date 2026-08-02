-- Original CTE: get_active_cl_eop
-- Clients with an active policy-owner record as of the reporting month end.

with active_cl_eop as (
select distinct
    po.po_client_id_nk,
    dt.ytd_end_dt
from {{ ref('stg_metrics__policy_owner') }} po
inner join {{ ref('stg_pdm__ytd_dates') }} dt
    on po.dt_key = dt.ytd_end_dim_sqn
)
select * from active_cl_eop
