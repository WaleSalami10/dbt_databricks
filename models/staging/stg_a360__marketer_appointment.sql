/*
    Marketer history: the original appointment date, and the recruiting
    relationship that goes with it.

    One model, not two, because the project's rule is one thin model per source
    table and both sets of columns come off orap10_mk_history. The name is
    unchanged so that fct_marketer_production's refs keep working; read it as
    "marketer history" rather than as "only the appointment date".

    The mart inner-joins this on mktr_no and expects one row per marketer -- the
    six-month new-agent window and every "was this marketer active on date X"
    flag are computed from orig_appt_dt. If the source ever carries more than
    one history row per marketer, this model fans the mart out. It fans out
    int_triggered_marketers too, and that one has no distinct to hide behind.

    The unique test on mktr_no in _staging.yml is where that surfaces. It is
    deliberately an error, not a warning: the fix is an intermediate model that
    picks the correct row (earliest appointment, most likely), and that is a
    business decision, not something to paper over with a distinct.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_history') }}

)

select

      cast(trim(mktr_no) as string)         as mktr_no
    , cast(orig_appt_dt as timestamp)       as orig_appt_dt

    -- Recruiting side. Unqualified in the original query's `trig` CTE, which
    -- joined five tables at once; they are read as mk_history's here because
    -- that is the table the recruiting relationship belongs to. Confirm against
    -- the source's DDL before anyone reconciles a split against this column.
    , cast(trim(rel_mktr_no) as string)     as rcr_no
    , cast(trim(orig_org_unit_cd) as string) as orig_org_unit_cd
    , split                                 as split
    , cast(rcr_elig_dt as timestamp)        as rcr_elig_dt

from source
