SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(op.payment_value), 2) AS total_payment_value,
    ROUND(
        SUM(op.payment_value) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders AS o
INNER JOIN order_payments AS op
    ON o.order_id = op.order_id
GROUP BY o.order_status
ORDER BY total_payment_value DESC;


