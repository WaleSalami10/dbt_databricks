{#
    period_buckets()

    The original query repeats the same five conditional sums twice -- once for
    commission, once for paid cases. Same windows, same shape, different measure.
    This macro writes them once.

        measure    the column (or expression) being summed
        date_col   the transaction date being bucketed
        prefix     column-name prefix, e.g. 'fyc' -> fyc_me, fyc_ytd, ...
        dates      alias of the joined reporting-period table

    Usage:

        select
              mktr_no
            , {{ period_buckets('mk_shr_fyc_am', 'fyc_smy_edt', 'fyc') }}
        from ...
        group by mktr_no

    The buckets are:
        _me     year-to-date through the END of the prior month
        _ytd    year-to-date through the as-of date
        _mtd    current month through the as-of date
        _cw     current week
        _pw     prior week
#}

{% macro period_buckets(measure, date_col, prefix, dates='d') %}

      sum(case when {{ date_col }} between {{ dates }}.cur_yr
                                       and {{ dates }}.prv_me
               then {{ measure }} end)                     as {{ prefix }}_me

    , sum(case when {{ date_col }} between {{ dates }}.cur_yr
                                       and {{ dates }}.cur_dt
               then {{ measure }} end)                     as {{ prefix }}_ytd

    , sum(case when {{ date_col }} between {{ dates }}.cur_mnst
                                       and {{ dates }}.cur_dt
               then {{ measure }} end)                     as {{ prefix }}_mtd

    , sum(case when {{ date_col }} between {{ dates }}.cw_start_dt
                                       and {{ dates }}.cw_end_dt
               then {{ measure }} end)                     as {{ prefix }}_cw

    , sum(case when {{ date_col }} between {{ dates }}.prev_week_start
                                       and {{ dates }}.prev_week_end
               then {{ measure }} end)                     as {{ prefix }}_pw

{% endmacro %}


{#
    as_of_value()

    Point-in-time lookup against a validity window -- "what was this column on
    date X?". Wraps the max(case when ... between edt and xdt ...) trick used by
    the class-history block.
#}

{% macro as_of_value(value_col, as_of_expr, valid_from, valid_to, alias) %}
    max(case
          when {{ as_of_expr }} between {{ valid_from }} and {{ valid_to }}
          then {{ value_col }}
        end) as {{ alias }}
{% endmacro %}
