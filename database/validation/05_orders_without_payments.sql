SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp
FROM orders AS o
LEFT JOIN order_payments AS op
    ON o.order_id = op.order_id
WHERE op.order_id IS NULL
ORDER BY o.order_purchase_timestamp;