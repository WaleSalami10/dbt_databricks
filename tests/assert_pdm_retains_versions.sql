{#
    In scd2 mode, fails if dim_contract does not actually retain multiple
    versions per key.

    WHY THIS EXISTS
    edh_record_start_ts / edh_record_end_ts being present proves the SCHEMA is
    Type 2. It does not prove the TABLE is. A table can carry validity columns
    and still hold exactly one row per key -- start_ts set to the last load,
    end_ts null -- if the loader overwrites rather than versions.

    That case is dangerous precisely because it looks fine. The as-of predicate
    matches the single current row for every past month, so a backfill of March
    returns today's contracts, silently, with every downstream test passing.
    It is the exact failure assert_backfill_is_honest.sql prevents in 'current'
    mode, reappearing through the mode that is supposed to fix it.

    1.05 is deliberately just above 1.0: a genuinely versioned dimension of this
    size will be well clear of it, and a soft-deleting one sits at exactly 1.0.
    If this fails, do not raise the threshold -- go back to
    analyses/diagnose_pdm_history.sql step 2.
#}

{% if ppg_var('pdm_history_mode') == 'scd2' %}

    select
        count(*)                                                as total_rows,
        count(distinct cnt_id_nk, cnt_iss_cd_nk)                as distinct_keys,
        count(*) / count(distinct cnt_id_nk, cnt_iss_cd_nk)     as rows_per_key
    from {{ source('pdm', 'dim_contract') }}
    having count(*) / count(distinct cnt_id_nk, cnt_iss_cd_nk) < 1.05

{% else %}

    select 1 as total_rows, 1 as distinct_keys, 1 as rows_per_key
    where false

{% endif %}
