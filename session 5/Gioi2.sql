
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           customer_name VARCHAR(100),
                           city VARCHAR(50)
);
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customers(customer_id),
                        order_date DATE,
                        total_amount NUMERIC(10, 2)
);
CREATE TABLE order_items (
                             item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id),
                             product_name VARCHAR(100),
                             quantity INT,
                             price NUMERIC(10, 2)
);

INSERT INTO customers (customer_name, city)
VALUES ('Nguyễn Văn An', 'Hà Nội'),
       ('Trần Thị Bình', 'TP. Hồ Chí Minh'),
       ('Lê Hoàng Cường', 'Đà Nẵng'),
       ('Phạm Minh Đức', 'Cần Thơ'),
       ('Đặng Kim Thoa', 'Hải Phòng');

INSERT INTO order_items (order_id, product_name, quantity, price)
VALUES (1, 'Điện thoại Samsung', 1, 1200000.00),
       (1, 'Ốp lưng bàn phím', 1, 300000.00),
       (2, 'Tai nghe Bluetooth', 1, 500000.00),
       (3, 'Màn hình Dell 24 inch', 1, 2300000.00),
       (5, 'Chuột không dây', 2, 600000.00);

INSERT INTO order_items (order_id, product_name, quantity, price)
VALUES (1, 'Điện thoại Samsung', 1, 1200000.00),
       (1, 'Ốp lưng bàn phím', 1, 300000.00),
       (2, 'Tai nghe Bluetooth', 1, 500000.00),
       (3, 'Màn hình Dell 24 inch', 1, 2300000.00),
       (5, 'Chuột không dây', 2, 600000.00);

SELECT
    c.customer_name AS "Tên khách",
    o.order_date AS "Ngày đặt hàng",
    o.total_amount AS "Tổng tiền"
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id;

SELECT
    SUM(total_amount) AS "Tổng doanh thu",
    AVG(total_amount) AS "Trung bình đơn hàng",
    MAX(total_amount) AS "Đơn hàng lớn nhất",
    MIN(total_amount) AS "Đơn hàng nhỏ nhất",
    COUNT(order_id) AS "Số lượng đơn hàng"
FROM orders;

SELECT
    c.city,
    SUM(o.total_amount) AS total_city_revenue
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

SELECT
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM customers c
         JOIN orders o ON c.customer_id = o.customer_id
         JOIN order_items oi ON o.order_id = oi.order_id;

SELECT customer_name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    ORDER BY SUM(total_amount) DESC
    LIMIT 1
);

SELECT city FROM customers
UNION
SELECT c.city FROM customers c JOIN orders o ON c.customer_id = o.customer_id;

SELECT city FROM customers
INTERSECT
SELECT c.city FROM customers c JOIN orders o ON c.customer_id = o.customer_id;