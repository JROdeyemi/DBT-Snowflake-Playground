with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('fct_orders') }}

),

employees AS (
    SELECT *
    FROM {{ ref('employees') }}
),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        SUM(Amount) AS Lifetime_value
    from orders
    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        e.Employee_ID IS NOT NULL AS Is_Employee,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        COALESCE(customer_orders.Lifetime_value, 0) AS Lifetime_value

    from customers

    left join customer_orders using (customer_id)
    LEFT JOIN employees AS e USING (customer_id)

)

select * from final