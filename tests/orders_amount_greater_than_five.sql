
SELECT amount
FROM {{ ref('stg_orders') }}
WHERE amount <= 5