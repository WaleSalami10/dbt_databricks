/*
    Original appointment date per marketer, from marketer history.

    The mart inner-joins this on mktr_no and expects one row per marketer -- the
    six-month new-agent window and every "was this marketer active on date X"
    flag are computed from orig_appt_dt. If the source ever carries more than
    one history row per marketer, this model fans the mart out.

    The unique test on mktr_no in _staging.yml is where that surfaces. It is
    deliberately an error, not a warning: the fix is an intermediate model that
    picks the correct row (earliest appointment, most likely), and that is a
    business decision, not something to paper over with a distinct.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_history') }}

)

select

      cast(trim(mktr_no) as string)     as mktr_no
    , cast(orig_appt_dt as timestamp)   as orig_appt_dt

from source
