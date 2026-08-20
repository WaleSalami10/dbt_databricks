/*
    The `trig` CTE of the CAP query: marketers whose recruiting credit triggered
    in the current year to date, with the contract type in force on the day it
    triggered and the name of the recruiter who gets the credit.

    "Triggered" is the whole point of the model, and it is the join to the
    calendar that defines it: rcr_elig_dt has to fall between the start of the
    current year and the as-of date. Everything downstream inherits that filter,
    which is why `ytd_trigger` in the mart can only ever be 'Y' -- see there.

    The original anchored this window on the load-control date but anchored
    `ytd_trigger` on current_date. Both anchor on cur_dt here, as everywhere
    else in this project; on a normal same-day run the two agree anyway, and on
    a late load or a backfill only this version is self-consistent.

    Every join is an inner join, as in the original. Three of them can drop
    marketers, and only the contract one is obvious:

      - no contract row covering rcr_elig_dt  -> dropped
      - contract type code missing from the lookup -> dropped
      - marketer absent from the master or the recruiter absent from the
        dashboard dimension -> dropped

    The marketer master (stg_a360__marketer) is joined for ea_pgm_ind alone, and
    is one of those silent filters.
*/

with dates as (

    select * from {{ ref('int_reporting_periods') }}

),

history as (

    select * from {{ ref('stg_a360__marketer_appointment') }}

)

select

      h.rcr_no
    , h.mktr_no
    , h.orig_org_unit_cd
    , h.split
    , h.rcr_elig_dt

    -- The recruiter's display name, built from the dashboard dimension exactly
    -- as the original built it. initcap() on already-trimmed staging columns.
    , concat(initcap(rcr.mk_fst_nm), ' ', initcap(rcr.mk_lst_nm)) as rcr_name

    , mk.ea_pgm_ind
    , tp.mk_cnt_tp_nm

from history h

cross join dates d

inner join {{ ref('stg_a360__contract_active') }} cnt
    on  cnt.mktr_no = h.mktr_no
    and h.rcr_elig_dt between cnt.mk_cnt_edt and cnt.mk_cnt_xdt

inner join {{ ref('stg_a360__contract_type') }} tp
    on tp.mk_cnt_tp_cd = cnt.mk_cnt_tp_cd

-- The RECRUITER's row in the dashboard dimension, not the marketer's: rcr_no is
-- the related marketer, and it is their name that appears on the report.
inner join {{ ref('stg_a360__marketer_dashboard') }} rcr
    on rcr.mktr_no = h.rcr_no

inner join {{ ref('stg_a360__marketer') }} mk
    on mk.mktr_no = h.mktr_no

-- The trigger window. Year to date, on the report's as-of date.
where h.rcr_elig_dt between date_trunc('year', d.cur_dt) and d.cur_dt
