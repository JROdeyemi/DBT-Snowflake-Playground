{{
    config(required_tests=None)
}}


SELECT Customer_ID,
    COUNT(Order_ID) AS Num_of_Orders
FROM {{ ref('stg_orders') }}
GROUP BY 1