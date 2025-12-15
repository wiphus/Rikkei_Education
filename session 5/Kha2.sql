create schema baitap2;

CREATE TABLE products
(
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50)  NOT NULL
);

CREATE TABLE orders
(
    order_id    INT PRIMARY KEY,
    product_id  INT            NOT NULL,
    quantity    INT            NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);


INSERT INTO products (product_id, product_name, category)
VALUES (1, 'Laptop Dell', 'Electronics'),
       (2, 'IPhone 15', 'Electronics'),
       (3, 'Bàn học gỗ', 'Furniture'),
       (4, 'Ghế xoay', 'Furniture');

INSERT INTO orders (order_id, product_id, quantity, total_price)
VALUES (101, 1, 2, 2200),
       (102, 2, 3, 3300),
       (103, 3, 5, 2500),
       (104, 4, 4, 1600),
       (105, 1, 1, 1100);

SELECT p.product_name,
       t1.total_revenue
FROM products p
         JOIN (SELECT product_id,
                      SUM(total_price) AS total_revenue
               FROM orders
               GROUP BY product_id
               ORDER BY total_revenue DESC
               LIMIT 1) t1 ON p.product_id = t1.product_id;

SELECT category
FROM products
WHERE product_id IN (SELECT product_id
                     FROM orders
                     GROUP BY product_id
                     ORDER BY SUM(total_price) DESC
                     LIMIT 1)

INTERSECT
SELECT p.category
FROM products p
         JOIN
     orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 3000;