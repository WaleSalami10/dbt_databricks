/*
    Producer side of the EPM case -- the bridge from an a360 marketer number to
    an EPM case.

    producer_num is text on this table and mktr_no is text everywhere in this
    project, but they are not comparable as text: the original query joined them
    as `t.mktr_no = cast(nullif(trim(ep.producer_num), '') as integer)`, which
    throws away leading zeros and any other padding. That normalisation happens
    here, once, and comes out as producer_mktr_no -- cast back to string so it
    joins to the a360 models without another implicit coercion.

    Rows whose producer_num is blank normalise to null and simply never match,
    which is what nullif() was there for.
*/

with source as (

    select * from {{ source('ext_aurora_ods_producer2', 'epm_producer') }}

)

select

      cast(trim(epm_case_id) as string)     as epm_case_id
    , cast(trim(producer_num) as string)    as producer_num
    , cast(cast(nullif(trim(producer_num), '') as int) as string)
                                            as producer_mktr_no

from source
