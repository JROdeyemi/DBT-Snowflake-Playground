{{
    config(
        store_failures = true
    )
}}



WITH payments AS (
    SELECT *
    FROM {{ ref('stg_stripe__payments') }}
)

SELECT OrderID,
        SUM(Amount) AS Total_Amount
FROM payments 
GROUP BY OrderID 
HAVING Total_Amount < 0