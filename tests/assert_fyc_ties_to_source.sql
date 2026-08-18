/*
    The mart's year-to-date commission must equal the raw daily table, summed
    over the same window, for every marketer on the report.

    This is the check the comment on line 167 of the original query was worried
    about. It is an end-to-end reconciliation: it goes past the staging model,
    past the bucketing macro and past six joins, straight from the fact table
    back to the source rows, and catches the whole class of bugs where a join
    quietly drops or duplicates commission.

    Compared per marketer rather than in total, so a failure names the marketer
    instead of just a number that is off.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

from_mart as (

    select
          mktr_no
        , fyc_ytd

    from {{ ref('fct_marketer_production') }}

),

from_source as (

    select
          f.mktr_no
        , sum(f.mk_shr_fyc_am) as fyc_ytd

    from {{ ref('stg_a360__daily_fyc') }} f
    cross join dates d

    where f.fyc_smy_edt between d.cur_yr and d.cur_dt

    group by f.mktr_no

)

select
      m.mktr_no
    , m.fyc_ytd                                     as mart_fyc_ytd
    , coalesce(s.fyc_ytd, 0)                        as source_fyc_ytd
    , m.fyc_ytd - coalesce(s.fyc_ytd, 0)            as difference

from from_mart m

-- Left join: a marketer on the report with no source rows at all should still
-- be checked. Their mart value must be zero, and coalesce makes that comparable.
left join from_source s
    on s.mktr_no = m.mktr_no

where m.fyc_ytd != coalesce(s.fyc_ytd, 0)
