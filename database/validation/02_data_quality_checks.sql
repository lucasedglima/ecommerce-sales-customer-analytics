-- Quantidade de pedidos por status
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Valores ausentes nas datas dos pedidos
SELECT
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL)
        AS missing_approved_at,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL)
        AS missing_carrier_date,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL)
        AS missing_customer_delivery_date
FROM orders;


-- Validação das notas das avaliações
SELECT
    MIN(review_score) AS minimum_score,
    MAX(review_score) AS maximum_score,
    COUNT(*) FILTER (
        WHERE review_score NOT BETWEEN 1 AND 5
    ) AS invalid_scores
FROM order_reviews;


-- Produtos sem categoria preenchida
SELECT
    COUNT(*) AS products_without_category
FROM products
WHERE product_category_name IS NULL;


-- Categorias de produtos sem tradução
SELECT
    p.product_category_name,
    COUNT(*) AS total_products
FROM products AS p
LEFT JOIN product_category_translation AS t
    ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND t.product_category_name IS NULL
GROUP BY p.product_category_name
ORDER BY total_products DESC;