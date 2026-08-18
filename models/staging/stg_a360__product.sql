/*
    Product dimension. One row per product code.

    Its only job in this report is to carry the product LINE code, which is what
    the 'LF' (life) filter on paid cases keys off.
*/

with source as (

    select * from {{ source('a360', 'orap10_dash_alt_prdt_mv') }}

)

select

      cast(trim(alt_prdt_cd) as string)         as alt_prdt_cd
    , upper(trim(alt_prdt_line_cd))             as alt_prdt_line_cd

from source
