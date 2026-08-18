/*
    Job title lookup, one row per title code.

    ttl_nm is initcap()'d, carried over from the original query, which matched
    the reportable-title list against the display text rather than the code.
    initcap() plus trim() makes that matching as robust as it can be given the
    approach ('MANAGING PARTNER ' and 'managing partner' both land on
    'Managing Partner'), but it is still text matching: a title renamed to
    'Managing Partner (Field)' drops those marketers from the report silently.

    The fix is to match on mk_ttl_tp_cd instead -- see the README. Both columns
    are exposed here so the swap is a one-line change in the mart.
*/

with source as (

    select * from {{ source('a360', 'orap10_mk_ttl_tp') }}

)

select

      cast(trim(mk_ttl_tp_cd) as string)    as mk_ttl_tp_cd
    , initcap(trim(mk_ttl_tp_nm))           as ttl_nm

from source
