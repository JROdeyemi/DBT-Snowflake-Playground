{{
    config(required_tests=None)
}}




WITH Orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),

Payments AS (
    SELECT *
    FROM {{ ref('stg_stripe__payments') }}
),
Order_Payments AS (
    SELECT OrderID,
        SUM(CASE WHEN Status = 'success' THEN Amount END) AS Amount 
    FROM Payments 
    GROUP BY OrderID
)
,
fct_orders AS (
    SELECT o.Order_ID,
        o.Customer_ID,
        o.order_date,
        COALESCE(op.Amount, 0) AS Amount
    FROM Orders AS o 
    LEFT JOIN Order_Payments AS op 
        ON o.Order_ID = op.OrderID
)

SELECT *
FROM fct_orders