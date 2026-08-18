/*
    The report must actually contain marketers who are under contract and
    producing.

    Written after a real failure during the dummy-data build: a code-format
    mismatch made the active-status filter match nothing, so every
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
    select 'no marketer under contract',         count(contractenddate)                    from mart
    union all
    select 'no marketer active on the as-of date', sum(active_mtd)                         from mart
    union all
    select 'no marketer with year-to-date commission',
           sum(case when fyc_ytd != 0 then 1 else 0 end)                                   from mart
    union all
    select 'no marketer with year-to-date paid cases',
           sum(case when cases_ytd != 0 then 1 else 0 end)                                 from mart
    union all
    -- Counts RECOGNISED labels, not non-null ones. cls_copy falls back to
    -- 'Other' for an unmapped code, so count(cls_copy) can no longer be zero
    -- and would assert nothing -- a report where every marketer came out
    -- 'Other' is exactly the silent-failure shape this test exists to catch.
    select 'no marketer with a recognised class label',
           sum(case when cls_copy != 'Other' then 1 else 0 end)                          from mart

)

select
      assertion
    , observed

from assertions

where coalesce(observed, 0) = 0
