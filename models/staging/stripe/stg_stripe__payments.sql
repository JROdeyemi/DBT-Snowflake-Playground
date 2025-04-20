SELECT 
    ID AS PaymentID,
    OrderID,
    PaymentMethod,
    Status,
    {{ cents_to_dollars('amount', 3) }} AS Amount,
    Created AS CreatedAt,
    Batched_At AS BatchedAt
FROM {{ source('stripe', 'payment') }}