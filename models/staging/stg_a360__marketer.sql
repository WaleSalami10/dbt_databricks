/*
    Marketer master. The CAP query joins it for one column, ea_pgm_ind, but the
    join is an inner one, so it also decides which marketers can appear at all.
*/

with source as (

    select * from {{ source('a360', 'orap10_marketer') }}

)

select

      cast(trim(mktr_no) as string)     as mktr_no
    , cast(trim(ea_pgm_ind) as string)  as ea_pgm_ind

from source
