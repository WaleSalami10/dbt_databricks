/*
    Contract type lookup, one row per contract type code.

    mk_cnt_tp_nm is left in the source's own casing. fct_cap_candidate matches
    `like '%TAS%'` against it, and unlike the title lookup that match is
    case-SENSITIVE and substring-based, so initcap()'ing here would silently
    change which rows qualify. Both columns are exposed so the mart can be moved
    onto the code once someone confirms which codes '%TAS%' is standing in for.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_cnt_tp') }}

)

select

      cast(trim(mk_cnt_tp_cd) as string)    as mk_cnt_tp_cd
    , cast(trim(mk_cnt_tp_nm) as string)    as mk_cnt_tp_nm

from source
