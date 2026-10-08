/*
    Marketer application history, EDH lake version. One row per version --
    int_fod_new_agents takes the distinct (marketer, original application
    date) pairs, same as the source query's subquery.
*/

with source as (

    select * from {{ source('lake_orap10', 'mk_history') }}

)

select

      cast(trim(mktr_id_nk) as string)  as mktr_no
    , cast(orig_appl_dt as timestamp)   as orig_appl_dt

from source
