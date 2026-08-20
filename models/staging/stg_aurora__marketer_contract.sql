/*
    Contract windows keyed by the ODS marketer id (mktr_id), which is a
    different key from a360's mktr_no -- it joins to agent_candidate_lead's
    can_mktr_id, not to anything in the a360 models.

    Named for its source table. The similarly-named int_marketer_contract is
    unrelated: that one resolves a360's 9999 sentinel for the production report.
*/

with source as (

    select * from {{ source('ext_aurora_ods_producer2', 'marketer_contract') }}

)

select

      cast(trim(mktr_id) as string)     as mktr_id
    , cast(cnt_eff_dt as timestamp)     as cnt_eff_dt
    , cast(cnt_exp_dt as timestamp)     as cnt_exp_dt

from source
