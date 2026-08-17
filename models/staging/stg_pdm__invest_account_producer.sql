-- NB: the source column really is spelled `prodcuer_role_cd_desc`.
-- Renamed here so the typo stops leaking into every downstream model.
--
-- LATEST-ASSIGNMENT-YEAR FILTER -- HISTORICAL LOADS ONLY
-- An investment account accumulates producer rows over time. On a historical
-- load, keep only the producers whose assignment STARTED in the most recent
-- year present for that account as of the reporting month.
--
-- Gated on pdm_history_mode: 'scd2' is a historical load, 'current' is the
-- normal monthly run. In current mode this model compiles to exactly what it
-- did before -- no window function, no extra CTE, same rows. Check with:
--     dbt compile -s stg_pdm__invest_account_producer
--
-- The source query used `edh_record_end_ts >= current_timestamp`, which means
-- "live right now" -- a hardcoded special case of pdm_as_of(). Left as-is it
-- would return TODAY's producers for a past month. The macro generalises it:
-- current mode -> edh_record_status_in = 'A'; scd2 mode -> the validity
-- interval as of the reporting month end.
--
-- ORDER MATTERS: max_year is computed AFTER the as-of filter, so it is the
-- latest year *as of the reporting month*, not the latest that has ever
-- existed. Computing it first would leak later assignments into a backfill.
--
-- ⚠ Two things preserved exactly from the source query, both worth confirming:
--   1. PARTITION BY invest_acct_id_nk only. Downstream joins on
--      (invest_acct_id_nk, invest_acct_cd), so if one account id exists under
--      two codes this mixes them and one code's max year can suppress every
--      producer of the other.
--   2. YEAR granularity is discontinuous: assignments one day apart across a
--      new year are split, while eleven months apart inside one year are kept
--      together. Right if the intent is "everyone assigned in the same year as
--      the most recent"; wrong if it is "the single most recent assignment".

{% set is_historical_load = ppg_var('pdm_history_mode') == 'scd2' %}

with as_of as (

    select
        invest_acct_id_nk,
        invest_acct_cd,
        producer_id_nk,
        trim(prodcuer_role_cd_desc) as producer_cnt_role_nm
        {%- if is_historical_load %},
        edh_record_start_ts
        {%- endif %}
    from {{ source('pdm', 'fact_invest_account_producer_role') }}
    where {{ pdm_as_of() }}

)

{%- if is_historical_load %}

, ranked as (

    select
        *,
        year(edh_record_start_ts)                                            as start_year,
        max(year(edh_record_start_ts)) over (partition by invest_acct_id_nk) as max_year
    from as_of

)

select
    invest_acct_id_nk,
    invest_acct_cd,
    producer_id_nk,
    producer_cnt_role_nm
from ranked
where start_year = max_year

{%- else %}

select * from as_of

{%- endif %}
