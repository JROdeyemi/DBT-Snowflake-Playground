{{
    config(
        severity= "warn"
    )
}}


SELECT customer_id,
        AVG(amount) AS average_amount
FROM {{ ref('fct_orders') }}
GROUP BY customer_id
HAVING COUNT(customer_id) > 1 
    AND average_amount < 1