WITH payments AS (
     select * from {{ ref('stg_stripe__payments') }} 
     ), 
     
aggregated AS ( 
    select sum(amount) as total_revenue from payments 
    where status = 'success' 
) 

select * from aggregated