-- Salesforce account -> CASE client id crosswalk.
-- The original applied `case_cl_id is not null and case_cl_id <> ''` inside the
-- ON clause of an inner join, which is a WHERE in disguise. Made explicit here
-- so it is applied once rather than in each of the three places the subquery
-- was pasted.
select distinct
    acct_id_nk,
    case_cl_id
from {{ source('crm', 'sf_account') }}
where case_cl_id is not null
  and case_cl_id <> ''
