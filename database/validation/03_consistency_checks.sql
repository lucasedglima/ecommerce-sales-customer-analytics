-- Datas ausentes separadas por status do pedido
SELECT
    order_status,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (
        WHERE order_approved_at IS NULL
    ) AS missing_approved_at,
    COUNT(*) FILTER (
        WHERE order_delivered_carrier_date IS NULL
    ) AS missing_carrier_date,
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date IS NULL
    ) AS missing_customer_delivery_date
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Duplicações nos identificadores das avaliações
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT review_id) AS distinct_review_ids,
    COUNT(*) - COUNT(DISTINCT review_id)
        AS repeated_review_id_occurrences,
    COUNT(DISTINCT order_id) AS distinct_order_ids,
    COUNT(*) - COUNT(DISTINCT order_id)
        AS repeated_order_id_occurrences
FROM order_reviews;


-- Repetição da combinação review_id + order_id
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT (review_id, order_id)) AS distinct_pairs,
    COUNT(*) - COUNT(DISTINCT (review_id, order_id))
        AS repeated_pair_occurrences
FROM order_reviews;