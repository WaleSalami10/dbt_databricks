{#
    edh_record_status_in = 'A' must remain exactly equivalent to "this is the
    open-ended version".

    Measured on dim_contract: 'A' never appears on a closed version (step 3b of
    analyses/diagnose_pdm_history.sql) and 'I' never appears on an open one
    (step 3c). The flag carries no information the validity interval does not
    already carry.

    That equivalence is load-bearing in two directions:

      - It is why 'current' and 'scd2' return identical rows for the CURRENT
        month, which is the reconciliation used to validate the switch. If it
        breaks, the two modes diverge and the divergence looks like a scd2 bug.

      - It is why switching to scd2 loses no business filtering. `where
        edh_record_status_in = 'A'` has always meant "latest version", never
        "not lapsed" -- see the note in models/intermediate/int_contracts__scoped.sql.

    The realistic way this breaks is EDH introducing soft-deletes: an open-ended
    version stamped 'I'. Then 'current' silently starts excluding records that
    'scd2' includes. This test fails the build on the first such row rather than
    letting the modes drift apart unnoticed.
#}

select
    count(*)                                                        as mismatched_rows,
    sum(case when edh_record_status_in = 'A' then 1 else 0 end)     as active_but_closed,
    sum(case when edh_record_status_in <> 'A' then 1 else 0 end)    as inactive_but_open
from {{ source('pdm', 'dim_contract') }}
where (edh_record_status_in = 'A')
   <> (edh_record_end_ts >= timestamp'9999-01-01')
having count(*) > 0
