/*
    The report must actually contain marketers who are under contract and
    producing.

    Written after a real failure during the dummy-data build: a code-format
    mismatch made the join to active_status_codes match nothing, so every
    marketer came out with a null contract, every active_* flag came out 0, and
    every six-month flag came out 'N'. Every other test in the project passed --
    not_null, unique, accepted_values and relationships are all satisfied by a
    column that is uniformly wrong in the "empty" direction.

    That is the failure mode this catches: joins that resolve to nothing.
    A report showing zero active marketers is never right, and it is exactly the
    kind of wrong that gets published rather than noticed.

    Each row returned is one failed assertion, named.
*/

with mart as (

    select * from {{ ref('fct_marketer_production') }}

),

assertions as (

    select 'no marketers on the report'          as assertion, count(*)                    as observed from mart
    union all
    select 'no marketer under contract',         count(contract_end_dt)                    from mart
    union all
    select 'no marketer active on the as-of date', sum(active_mtd)                         from mart
    union all
    select 'no marketer with year-to-date commission',
           sum(case when fyc_ytd != 0 then 1 else 0 end)                                   from mart
    union all
    select 'no marketer with year-to-date paid cases',
           sum(case when cases_ytd != 0 then 1 else 0 end)                                 from mart
    union all
    select 'no marketer with a class label',     count(class_label)                        from mart

)

select
      assertion
    , observed

from assertions

where coalesce(observed, 0) = 0
