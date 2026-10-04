SELECT pct.product_category_name_english AS category,
    COUNT(oi.order_item_id) AS item_count,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.price) AS total_revenue    
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY pct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;