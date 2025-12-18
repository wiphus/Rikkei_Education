set search_path to baitap3;
CREATE TABLE customers
(
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city          VARCHAR(50)
);
CREATE TABLE orders
(
    order_id    INT PRIMARY KEY,
    customer_id INT,
    order_date  DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);
CREATE TABLE order_items
(
    item_id    INT PRIMARY KEY,
    order_id   INT,
    product_id INT,
    quantity   INT,
    price      DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

INSERT INTO customers (customer_id, customer_name, city)
VALUES (1, 'Nguyễn Văn A', 'Hà Nội'),
       (2, 'Trần Thị B', 'Đà Nẵng'),
       (3, 'Lê Văn C', 'Hồ Chí Minh'),
       (4, 'Phạm Thị D', 'Hà Nội');
INSERT INTO orders (order_id, customer_id, order_date, total_price)
VALUES (101, 1, '2024-12-20', 3000.00),
       (102, 2, '2025-01-05', 1500.00),
       (103, 1, '2025-02-10', 2500.00),
       (104, 3, '2025-02-15', 4000.00),
       (105, 4, '2025-03-01', 800.00);
INSERT INTO order_items (item_id, order_id, product_id, quantity, price)
VALUES (1, 101, 1, 2, 1500.00),
       (2, 102, 2, 1, 1500.00),
       (3, 103, 3, 5, 500.00),
       (4, 104, 2, 4, 1000.00);

SELECT c.customer_id,
       c.customer_name,
       SUM(o.total_price) AS total_revenue,
       COUNT(o.order_id)  AS order_count
FROM customers c
         INNER JOIN
     orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;

SELECT c.customer_id,
       c.customer_name,
       SUM(o.total_price) AS total_revenue
FROM customers c
         INNER JOIN
     orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (
    -- Subquery: Tính doanh thu trung bình của tất cả khách hàng
    SELECT AVG(total_customer_revenue)
    FROM (SELECT SUM(total_price) AS total_customer_revenue
          FROM orders
          GROUP BY customer_id) AS customer_revenues);
SELECT c.city,
       SUM(o.total_price) AS total_city_revenue
FROM customers c
         INNER JOIN
     orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_city_revenue DESC
LIMIT 1;
SELECT c.customer_name,
       c.city,
       SUM(oi.quantity)            AS total_products_bought,
       SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
         INNER JOIN
     orders o ON c.customer_id = o.customer_id
         INNER JOIN
     order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name, c.city
ORDER BY total_spent DESC;