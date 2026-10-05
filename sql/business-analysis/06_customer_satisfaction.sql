SELECT
    c.customer_state,
    COUNT(*) AS total_reviews,
    ROUND( AVG(r.review_score), 2) AS average_review_score,
    COUNT(*) FILTER ( WHERE r.review_score <= 2) AS negative_reviews,
    ROUND(100.0 * COUNT(*) FILTER ( WHERE r.review_score <= 2 )/ COUNT(*), 2) AS negative_reviews_percentage
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_reviews AS r
    ON o.order_id = r.order_id

GROUP BY c.customer_state
ORDER BY average_review_score ASC;