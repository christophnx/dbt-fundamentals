{% set payment_methods = ["credit_card","bank_transfer","coupon","gift_card"] %}

with payments as (
    select * from {{ ref('stg_payments') }}
),

pivoted as (
    select payment_id,
    {% for method in payment_methods -%}
    sum(case when payment_method = '{{method}}' then amount else 0 end) as {{method}}
    {% if not loop.last -%}
    ,
    {% endif -%}
    {% endfor %}
    from payments
    group by payment_id
)

select * from pivoted order by payment_id