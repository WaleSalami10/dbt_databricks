{#
    Replaces the two near-identical row_number() blocks in the original query
    (core_clients and wm_clients). They differed only by rec_tp_cd.

    NOTE ON A LATENT BUG IN THE ORIGINAL:
    the window partitioned by cnt_acct_id_nk alone, but the downstream joins
    matched on BOTH cnt_acct_id_nk and iss_cd_nk. If one account id exists under
    two issue codes, the original silently dropped the second one. Set
    partition_by_iss_cd = true to partition by both, which is almost certainly
    what was intended. Left false to preserve current output byte-for-byte.
#}
{% macro dedupe_primary_owner(rec_tp_cd, partition_by_iss_cd=false) %}

select
    cnt_acct_id_nk,
    iss_cd_nk,
    primry_ownr_cl_id
from {{ ref('stg_pdm__primary_owner_derv') }}
where rec_tp_cd = '{{ rec_tp_cd }}'
qualify row_number() over (
    partition by cnt_acct_id_nk{% if partition_by_iss_cd %}, iss_cd_nk{% endif %}
    order by primry_ownr_cl_role_eff_dt asc, primry_ownr_cl_id asc
) = 1

{% endmacro %}
