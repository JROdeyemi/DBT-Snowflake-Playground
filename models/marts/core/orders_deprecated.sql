{{
    config(required_tests=None)
}}




with orders as  (

    select * from {{ ref('stg_orders' )}}

),

payments as (

    select * from {{ ref('stg_stripe__payments') }}
    
),

order_payments as (

    select

        orderid,
        sum(case when status = 'success' then amount end) as amount_usd

    from payments
    group by 1
),

final as (

    select
    
        orders.order_id,
        case
            when orders.customer_id = 1
            then orders.customer_id +1000
            else orders.customer_id 
        end as customer_id,
        orders.order_date,
        coalesce(order_payments.amount_usd, 0) as amount

    FROM Orders
    LEFT JOIN Order_Payments
        ON orders.Order_ID = order_payments.OrderID
)

select * from final