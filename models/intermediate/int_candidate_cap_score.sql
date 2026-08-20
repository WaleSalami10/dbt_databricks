/*
    The candidate side of the CAP query: everything hanging off a producer
    number, from the EPM case through to the candidate's assessment score and
    their marketer's current contract.

    The original wrote this chain as five left joins off the `trig` CTE. It is
    rooted at the producer bridge here instead, which is the same result -- a
    left-deep chain of left joins re-roots without changing rows -- and it lets
    the whole chain be inspected on its own:

        dbt run --select int_candidate_cap_score

    The joins stay LEFT so this model is not the thing that decides which
    candidates exist. The mart's `fit_score_val is not null` filter is what
    makes them effectively inner; keeping them left here means a producer with
    no candidate shows up as a null row you can count rather than a row you
    never see.

    GRAIN: one row per producer per EPM case per live lead per live assessment.
    A candidate who has been assessed twice contributes two rows, and both reach
    the mart. If the report is meant to show only the latest assessment, that
    rule goes here -- a qualify/row_number over cmpl_dt -- and not in the mart.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

producer as (

    select * from {{ ref('stg_aurora__epm_producer') }}
    -- A blank producer_num normalises to null upstream and can never match a
    -- marketer, so it is dropped here rather than carried through five joins.
    where producer_mktr_no is not null

)

select

      p.producer_mktr_no
    , p.epm_case_id

    , lead.can_id_nk        as candidate_id
    , lead.can_mktr_id
    , lead.recrt_mktr_id
    , lead.can_recrt_nm
    , lead.can_full_nm_protected
    , lead.can_stg_nm

    , score.fit_score_val
    , score.fit_score_val_num
    , cast(score.cmpl_dt as date)   as cap_date

    -- FOD/CAP query line: `case when cast(fit_score_val as decimal(10,2)) >= 75
    -- then 'Y' else 'N' end`. A score that will not cast to a number comes back
    -- null from staging and lands on 'N', same as the original's silent
    -- coercion did.
    , case when score.fit_score_val_num >= 75 then 'Y' else 'N' end
                                    as cap_score_75plus

    , ctr.cnt_eff_dt                as pts_date

from producer p

cross join dates d

left join {{ ref('stg_aurora__epm_candidate') }} ec
    on ec.epm_case_id = p.epm_case_id

-- 'A' is EDH's live-row flag. It sits in the join, not in a where clause: as a
-- where clause it would turn these left joins into inner ones and drop
-- producers whose only lead is superseded.
left join {{ ref('stg_lake_aurora__agent_candidate_lead') }} lead
    on  lead.can_id_nk = ec.candidate_id
    and lead.edh_record_status_in = 'A'

left join {{ ref('stg_lake_aurora__candidate_assessment_score') }} score
    on  score.can_id_nk = lead.can_id_nk
    and score.edh_record_status_in = 'A'

-- The contract in force NOW. The original said current_date; this says cur_dt,
-- for the same reason int_marketer_contract does.
left join {{ ref('stg_aurora__marketer_contract') }} ctr
    on  ctr.mktr_id = lead.can_mktr_id
    and d.cur_dt between ctr.cnt_eff_dt and ctr.cnt_exp_dt
