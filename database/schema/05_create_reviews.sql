CREATE TABLE order_reviews (
    review_record_id BIGSERIAL PRIMARY KEY,
    review_id CHAR(32) NOT NULL,
    order_id CHAR(32) NOT NULL,
    review_score INTEGER NOT NULL,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);