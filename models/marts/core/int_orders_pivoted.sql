/* WITH payments AS (
    SELECT *
    FROM {{ ref('stg_stripe__payments') }}
)
,
pivoted AS (
    SELECT OrderID,
        SUM(CASE WHEN PaymentMethod = 'bank_transfer' THEN Amount ELSE 0 END) AS bank_transfer_amount,
        SUM(CASE WHEN PaymentMethod = 'coupon' THEN Amount ELSE 0 END) AS coupon_amount,
        SUM(CASE WHEN PaymentMethod = 'credit_card' THEN Amount ELSE 0 END) AS credit_card_amount,
        SUM(CASE WHEN PaymentMethod = 'gift_card' THEN Amount ELSE 0 END) AS gift_card_amount
    FROM payments
    WHERE Status = 'success'
    GROUP BY OrderID
)

SELECT *
FROM pivoted */

{{
    config(required_tests=None)
}}


{% set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}

WITH payments AS (
    SELECT *
    FROM {{ ref('stg_stripe__payments') }}
)
,
pivoted AS (
    SELECT OrderID,
        {% for payment_method in payment_methods -%}     
            SUM(CASE WHEN PaymentMethod = '{{ payment_method }}' THEN Amount ELSE 0 END) AS {{ payment_method }}_amount
            {%- if not loop.last -%}
                ,
            {%- endif %}
        {% endfor -%}

    FROM payments
    WHERE Status = 'success'
    GROUP BY OrderID
)

SELECT *
FROM pivoted