{% macro limit_data_in_dev(column_name, days_of_data = 3) %}
    {%- if target.name == 'default' -%}

        WHERE {{ column_name }} = DATEADD('day', - {{ days_of_data }}, current_timestamp)

    {%- endif -%}

{% endmacro %}