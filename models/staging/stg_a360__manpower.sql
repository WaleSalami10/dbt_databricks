/*
    Manpower / headcount flags, one row per marketer.

    The original query joined this table twice on the same key to produce
    `prorata` and `prior_prorata`. With no predicate distinguishing the two
    joins, both columns always held the same value; only one join survives in
    the mart. See the README before wiring up a genuine prior-period version --
    it needs a snapshot date this table does not currently expose.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_manpower') }}

)

select

      cast(trim(mktr_no) as string) as mktr_no
    , cast(pro_rata_ind as int)     as pro_rata_ind
    , cast(cnt_atv_ind as int)      as count_active

from source
