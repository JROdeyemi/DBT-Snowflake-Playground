{% macro find_datatypes() %}
    {% set relation = adapter.get_relation(
        database=target.database,
        schema=target.schema,
        identifier='fct_orders'
    ) %}
    {% set cols = adapter.get_columns_in_relation(relation) %}

    {% set output = [] %}
    {% for col in cols %}
        {% do output.append("- name: " ~ col.name | lower ~ "\n  data_type: " ~ col.dtype | lower) %}
    {% endfor %}

    {{ print(output | join('\n')) }}
{% endmacro %}