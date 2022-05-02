with payments as (
    select amount, order_id as id from {{ ref('stg_payments') }} where status_payment = 'success'
)

select
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    payments.amount
from {{ source('jaffle_shop','orders')}}
left join payments using(id)
