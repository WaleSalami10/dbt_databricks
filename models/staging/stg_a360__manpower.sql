/*
    Manpower / headcount flags, one row per marketer.

    The mart joins this table TWICE on the same key (mp / mpr), reproducing the
    original query, to produce `prorata` and `prior_prorata`. With no predicate
    distinguishing the two joins, those two columns always hold the same value.

    A genuine prior-period version needs a snapshot date, and this table exposes
    no column to write one against -- there is no effective-date or as-of column
    here, only the current flags. That is the blocker, not the join. See the
    README before attempting it.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_manpower') }}

)

select

      cast(trim(mktr_no) as string) as mktr_no
    , cast(pro_rata_ind as int)     as pro_rata_ind
    , cast(count_active as int)     as count_active

from source
