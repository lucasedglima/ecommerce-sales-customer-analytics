CREATE TABLE order_payments(
    order_id char(32) NOT NULL,
    payment_sequential integer NOT NULL,
    payment_type varchar(20) NOT NULL,
    payment_installments integer NOT NULL,
    payment_value NUMERIC(10,2) NOT NULL,

    PRIMARY KEY(order_id, payment_sequential),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);