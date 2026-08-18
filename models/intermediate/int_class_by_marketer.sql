/*
    "What class was this marketer on date X?" for each reporting date.

    Class history is a slowly-changing dimension: one row per class, valid
    between mk_cls_edt and mk_cls_xdt. For each reporting date we pick
    the row whose window contains it.

    The active-status IN list below is FOD_query.sql lines 71-73, verbatim.

    KEEP IT IN SYNC WITH int_marketer_contract. The same ten codes appear there
    (they were lines 169-171 of the original). Nothing enforces that the two
    match -- if they drift, a marketer counts as active for their class lookup
    but not for their contract, or the reverse, and the report is quietly wrong
    rather than broken. Change one, change the other.

    Codes are QUOTED because they are zero-padded text and one of them is '1C'.
    Unquoted, '01' becomes the integer 1, the list matches nothing, and every
    marketer comes back with no contract -- silently. See
    tests/assert_report_is_not_vacuous.sql.
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
    where s.mk_sts_tp_cd in ('01', '04', '05', '07', '08', '09', '0A', '0B', '0C', '1C')

),

overlapping as (

    select
          h.mktr_no
        , h.mk_cls_tp_cd
        , h.mk_cls_edt
        , h.mk_cls_xdt

    from class_history h

    inner join active_status a
        on  a.mktr_no = h.mktr_no
        and h.mk_cls_edt between a.mk_sts_atv_edt and a.mk_sts_atv_xdt

)

select

      o.mktr_no

    , {{ as_of_value('o.mk_cls_tp_cd', 'd.cw_start_dt',     'o.mk_cls_edt', 'o.mk_cls_xdt', 'cw_class') }}
    , {{ as_of_value('o.mk_cls_tp_cd', 'd.prev_week_start', 'o.mk_cls_edt', 'o.mk_cls_xdt', 'pw_class') }}
    , {{ as_of_value('o.mk_cls_tp_cd', 'd.prv_me',          'o.mk_cls_edt', 'o.mk_cls_xdt', 'prvme_class') }}
    , {{ as_of_value('o.mk_cls_tp_cd', 'd.cur_dt',          'o.mk_cls_edt', 'o.mk_cls_xdt', 'cur_class') }}

from overlapping o
cross join dates d

group by o.mktr_no
