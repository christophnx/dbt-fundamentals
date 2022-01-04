with orders as (
select * from {{ ref('stg_orders') }}
),

payment as (
    select * from {{ ref('stg_payments') }}
)

select orders.customer_id, orders.order_id, payment.amount from orders
left join payment using(order_id)

