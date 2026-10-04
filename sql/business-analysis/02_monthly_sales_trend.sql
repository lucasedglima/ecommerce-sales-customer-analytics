select date_trunc('month', o.order_purchase_timestamp) :: DATE as purchase_month,
    count(distinct o.order_id) as total_orders,
    round(sum(op.payment_value), 2) as total_payment_value,
    round(sum(op.payment_value) / count(distinct o.order_id), 2) as average_order_value
from orders as o
join order_payments as op 
    on o.order_id = op.order_id
where o.order_status = 'delivered'
group by purchase_month
order by purchase_month;