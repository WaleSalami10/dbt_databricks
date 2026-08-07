{#
    Overrides dbt's built-in source().

    With `use_dummy_data: true`, every source('a360', 'x') resolves to

        <target catalog>.<target schema>_dummy_a360.x

    instead of prod_execution_rs.ext_agy_a360_mart.x. Only the catalog and
    schema change: the TABLE NAME is identical, because the stand-in tables are
    named after the real ones. Nothing downstream is aware of the switch --
    staging models say source(), and this macro decides what that means.

        python scripts/load_dummy_data.py             # load the stand-ins once
        dbt build --vars '{use_dummy_data: true}'     # simulated
        dbt build                                     # real sources

    The stand-ins are TABLES, loaded outside dbt, not seeds. A source is
    something that exists before dbt runs, and this macro keeps them in that
    role: they are outside the DAG, dbt does not create or own them, and their
    column types are declared by the loader rather than inferred from CSV text.

    Override the schema with the `dummy_schema` var if you need to point at
    someone else's copy. Like use_dummy_data, it is read at parse time, so it
    has to come from --vars or dbt_project.yml, not mid-run.

    Note that `dbt source freshness` is unaffected: it reads the source config
    directly and never calls this macro. Do not run it against dummy data.
#}

{% macro source(source_name, table_name) %}

    {% if var('use_dummy_data', false) %}

        {% set dummy_schema = var('dummy_schema', target.schema ~ '_dummy_a360') %}

        {{ return(api.Relation.create(
              database   = target.database,
              schema     = dummy_schema,
              identifier = table_name
        )) }}

    {% else %}
        {{ return(builtins.source(source_name, table_name)) }}
    {% endif %}

{% endmacro %}
