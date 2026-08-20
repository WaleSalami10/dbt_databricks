/*
    CAP assessment scores, one row per candidate per completed assessment (and
    per version of it -- edh_record_status_in again).

    fit_score_val is exposed twice. The source stores it as text, and the
    original query treated it both ways: it REPORTED the raw value and it
    compared `cast(fit_score_val as decimal(10,2)) >= 75`. Both are kept, so the
    mart reports exactly what the source holds while the threshold compares
    numbers to numbers.

    A non-numeric score casts to null rather than raising, so it lands on the
    'N' side of the 75+ flag while still being reported. The not_null test on
    fit_score_val_num in _staging.yml is what makes that visible.
*/

with source as (

    select * from {{ source('ext_lake_aurora_ods_producer2', 'candidate_assessment_score') }}

)

select

      cast(trim(can_id_nk) as string)           as can_id_nk
    , cast(trim(fit_score_val) as string)       as fit_score_val
    , cast(trim(fit_score_val) as decimal(10,2)) as fit_score_val_num
    , cast(cmpl_dt as timestamp)                as cmpl_dt
    , cast(trim(edh_record_status_in) as string) as edh_record_status_in

from source
