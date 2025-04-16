SELECT 
    ID AS PaymentID,
    OrderID,
    PaymentMethod,
    Status,
    Amount / 100 AS Amount,
    Created AS CreatedAt,
    Batched_At AS BatchedAt
FROM {{ source('stripe', 'payment') }}