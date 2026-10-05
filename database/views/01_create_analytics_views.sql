CREATE OR REPLACE VIEW vw_order_summary AS

WITH payment_summary AS (
    SELECT
        order_id,
        COUNT(*) AS payment_count,
        SUM(payment_value) AS total_payment_value
    FROM order_payments
    GROUP BY order_id
),

item_summary AS (
    SELECT
        order_id,
        COUNT(*) AS item_count,
        SUM(price) AS total_product_value,
        SUM(freight_value) AS total_freight_value
    FROM order_items
    GROUP BY order_id
),

review_summary AS (
    SELECT
        order_id,
        COUNT(*) AS review_count,
        AVG(review_score) AS average_review_score
    FROM order_reviews
    GROUP BY order_id
)

SELECT
    o.order_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    o.order_status,

    o.order_purchase_timestamp,
    o.order_purchase_timestamp::date AS purchase_date,
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp
    )::date AS purchase_month,

    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    CASE
        WHEN o.order_delivered_customer_date IS NOT NULL
        THEN
            o.order_delivered_customer_date::date
            - o.order_purchase_timestamp::date
    END AS delivery_days,

    CASE
        WHEN o.order_delivered_customer_date IS NOT NULL
            AND o.order_estimated_delivery_date IS NOT NULL
        THEN
            o.order_delivered_customer_date
            > o.order_estimated_delivery_date
    END AS is_delayed,

    COALESCE(ps.payment_count, 0) AS payment_count,
    COALESCE(ps.total_payment_value, 0) AS total_payment_value,

    COALESCE(its.item_count, 0) AS item_count,
    COALESCE(its.total_product_value, 0) AS total_product_value,
    COALESCE(its.total_freight_value, 0) AS total_freight_value,

    COALESCE(rs.review_count, 0) AS review_count,
    ROUND(rs.average_review_score, 2) AS average_review_score

FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
LEFT JOIN payment_summary AS ps
    ON o.order_id = ps.order_id
LEFT JOIN item_summary AS its
    ON o.order_id = its.order_id
LEFT JOIN review_summary AS rs
    ON o.order_id = rs.order_id;


CREATE OR REPLACE VIEW vw_product_sales AS

SELECT
    o.order_id,
    oi.order_item_id,
    o.order_status,
    o.order_purchase_timestamp::date AS purchase_date,
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp
    )::date AS purchase_month,

    c.customer_state,

    oi.product_id,
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,

    oi.seller_id,
    s.seller_state,

    oi.price,
    oi.freight_value

FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN products AS p
    ON oi.product_id = p.product_id
JOIN sellers AS s
    ON oi.seller_id = s.seller_id
LEFT JOIN product_category_translation AS pct
    ON p.product_category_name = pct.product_category_name;