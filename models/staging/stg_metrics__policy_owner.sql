-- Source for get_active_cl_eop.
--
-- The original carried a commented-out alternate source:
--   prod_builder_enterprise_silver.lake_oracle_orap18_esda01rpt.rpt_fct_mk_cnt_cmpnt_po_all
-- Preserved as a comment here so the lineage decision stays visible, but the
-- live table is the metrics marketplace one.
with policy_owner as (
select
    po_client_id    as po_client_id_nk,
    dt_key,
    dim_po_status_sk
from {{ source('metrics_marketplace', 'rpt_fct_mk_cnt_cmpnt_po_all') }}
where dim_po_status_sk in (1, 2, 3)
)
select * from policy_owner
