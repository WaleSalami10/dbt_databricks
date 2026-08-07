/*
    "What class was this marketer on date X?" for each reporting date.

    Class history is a slowly-changing dimension: one row per class, valid
    between class_valid_from and class_valid_to. For each reporting date we pick
    the row whose window contains it.

    The active-status list comes from the `active_status_codes` seed, not a
    hardcoded IN list. The same seed is used by int_marketer_contract, so the
    two models cannot disagree about what "active" means.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

class_history as (

    select * from {{ ref('stg_a360__class_history') }}

),

active_status as (

    select s.*
    from {{ ref('stg_a360__marketer_status') }} s
    inner join {{ ref('active_status_codes') }} c
        on c.status_cd = s.status_cd

),

overlapping as (

    select
          h.mktr_no
        , h.class_cd
        , h.class_valid_from
        , h.class_valid_to

    from class_history h

    inner join active_status a
        on  a.mktr_no = h.mktr_no
        and h.class_valid_from between a.status_valid_from and a.status_valid_to

)

select

      o.mktr_no

    , {{ as_of_value('o.class_cd', 'd.cw_start_dt',     'o.class_valid_from', 'o.class_valid_to', 'cw_class') }}
    , {{ as_of_value('o.class_cd', 'd.prev_week_start', 'o.class_valid_from', 'o.class_valid_to', 'pw_class') }}
    , {{ as_of_value('o.class_cd', 'd.prv_me',          'o.class_valid_from', 'o.class_valid_to', 'prvme_class') }}
    , {{ as_of_value('o.class_cd', 'd.cur_dt',          'o.class_valid_from', 'o.class_valid_to', 'cur_class') }}

from overlapping o
cross join dates d

group by o.mktr_no
