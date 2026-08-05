{#
    Build real SCD2 history going forward.

    Use this when diagnose_pdm_history.sql shows the PDM tables overwrite in
    place -- i.e. rows_per_key is ~1.0 and there are no validity columns. In
    that case the past is genuinely unrecoverable beyond Delta's retention
    window, and the only honest move is to start accumulating from today.

    Run DAILY and BEFORE the models, on its own schedule:
        dbt snapshot
        dbt build

    A missed day is a permanent hole -- dbt records the change when it next
    sees it, so an edit made and reverted between runs is invisible. Snapshots
    are also append-only and never rebuilt; if you drop the table you cannot
    recreate the history.

    Scope note: the `where` narrows to PPG-relevant contracts so this does not
    accumulate the entire enterprise contract dimension. Widen it if the LOB
    list in int_contracts__scoped ever grows, or you will have a gap.
#}

{% snapshot snap_pdm__dim_contract %}
{{
    config(
        target_schema = 'snapshots',
        unique_key = "cnt_id_nk || '~' || cnt_iss_cd_nk",
        strategy = 'check',
        check_cols = ['plan_cd', 'lob_nm', 'cnt_eff_dt', 'edh_record_status_in'],
        invalidate_hard_deletes = True
    )
}}

select
    cnt_id_nk,
    cnt_iss_cd_nk,
    plan_cd,
    lob_nm,
    cnt_eff_dt,
    edh_record_status_in
from {{ source('pdm', 'dim_contract') }}
where lob_nm in ('LIFE INSURANCE', 'ANNUITIES', 'LONG TERM CARE')
   or cnt_iss_cd_nk = 'IDI'

{% endsnapshot %}
