{#
    The original left-joined the producer facts with no role filter (every
    `and ... producer_cnt_role_nm = '...'` line was commented out) and then
    leaned on `select distinct` to hide the fan-out. distinct does not help:
    if a contract has three producers in three roles, you get three rows.

    This macro makes the choice explicit and configurable:
      apply_producer_role_filter = false -> current behaviour, all roles kept
      apply_producer_role_filter = true  -> keep the role configured per LOB in
                                            seeds/lob_producer_role.csv, and if
                                            no row matches that role, fall back
                                            to any role rather than losing the
                                            contract.
#}
{% macro pick_producer(source_key) %}

{% if var('apply_producer_role_filter') %}
qualify row_number() over (
    partition by {{ source_key }}
    order by
        case when producer_cnt_role_nm = preferred_producer_role_nm then 0 else 1 end,
        producer_id_nk
) = 1
{% endif %}

{% endmacro %}
