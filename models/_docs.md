{#
    Shared column descriptions.

    Columns that appear in half a dozen models -- mktr_no above all -- are
    described once here and referenced with {{ doc('name') }} from the yml
    files. Copy-pasted descriptions drift; these cannot.
#}

{% docs mktr_no %}
Marketer number. The natural key for a marketer across every a360 table, and the
grain of the mart.
{% enddocs %}

{% docs valid_from %}
Start of the validity window, inclusive. Type-2 history: the row describes the
marketer's state from this timestamp until the matching end date.
{% enddocs %}

{% docs product_cd %}
Product code. Joins the daily paid-case summary to the product dimension, which
is where the product line ('LF' for life) lives.
{% enddocs %}

{% docs org_unit_cd %}
Organisational unit code. Resolves a marketer to their general office and zone.
{% enddocs %}

{% docs title_cd %}
Job title code. The robust way to identify a title -- the report matches on the
display text instead, which is the fragility described in the README.
{% enddocs %}
