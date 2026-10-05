SELECT
    c.customer_state,

    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(o.order_delivered_customer_date::date - o.order_purchase_timestamp::date), 2) AS average_delivery_days,
    COUNT(*) FILTER ( WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date) AS delayed_orders,
    ROUND(100.0 * COUNT(*) FILTER (WHERE o.order_delivered_customer_date > o.order_estimated_delivery_date ) / COUNT(DISTINCT o.order_id),2) AS delayed_orders_percentage
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
    AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY delayed_orders_percentage DESC;