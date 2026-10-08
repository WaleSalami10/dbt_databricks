/*
    Salesforce user / CRM bridge. Ties an a360 marketer number (as text) to
    the Salesforce owner id sf_event is keyed on, and carries the user's
    title.
*/

with source as (

    select * from {{ source('a360_fod', 'trf_cs_user') }}

)

select

      cast(trim(case_marketer_id_c) as string) as case_marketer_id_c
    , cast(trim(acf2id_c) as string)            as acf2id_c
    , cast(trim(user_title) as string)          as user_title

from source
