-- Replaces the `dates` CTE in cells 2, 3 and 4.
--
-- This used to be a SECOND, INDEPENDENT computation of the month end: cell 1
-- derived it as mth_begin_dt - 1 from CURRENT_DATE, cell 2 read mth_end_dt
-- from ADD_MONTHS(CURRENT_DATE, -1). They agreed on every date I checked, but
-- nothing enforced it, so _staging.yml carried a relationships test between
-- them to catch a drift that should never have been possible in the first
-- place.
--
-- Now that the reporting month is an explicit input rather than something each
-- cell re-derives from the run date, there is nothing left to compute. This is
-- a renaming view over the one date spine, kept so the models that read
-- ytd_end_dt do not all have to change.
select
    snapshot_date,
    ytd_begin_dt,
    month_end_date      as ytd_end_dt,
    month_end_dim_sqn   as ytd_end_dim_sqn
from {{ ref('stg_pdm__dates') }}
