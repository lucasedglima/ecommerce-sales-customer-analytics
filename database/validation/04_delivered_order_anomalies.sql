SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM orders
WHERE order_status = 'delivered'
  AND (
      order_approved_at IS NULL
      OR order_delivered_carrier_date IS NULL
      OR order_delivered_customer_date IS NULL
  )
ORDER BY order_purchase_timestamp;