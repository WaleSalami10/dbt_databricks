/*
    Paid cases per marketer, same five reporting periods as FYC.

    NOTE: the original query filtered on m.alt_prdt_line_cd = 'LF' via a LEFT
    JOIN to the product table. A predicate on the right-hand side of a left join
    silently turns it into an inner join. That behaviour is preserved here but
    made explicit -- if you actually want to keep unmatched products, move the
    filter into the join condition instead.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

daily_cases as (

    select * from {{ ref('stg_a360__daily_paid_cases') }}

),

products as (

    select * from {{ ref('stg_a360__product') }}

)

select

      c.mktr_no

    , {{ period_buckets('c.cases_qty', 'c.paid_dt', 'cases', dates='d') }}

from daily_cases c
cross join dates d

-- Inner, not left. This is the behaviour described in the header made
-- explicit: a case whose product code is not in the product dimension does not
-- count, because we cannot tell whether it is a life product.
inner join products pr
    on pr.product_cd = c.product_cd

where c.paid_dt between d.cur_yr and d.cur_dt
  and pr.product_line_cd = 'LF'

group by c.mktr_no
