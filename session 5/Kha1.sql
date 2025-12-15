create database session5;
create schema baitap1;
set search_path to baitap1;

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

SELECT p.category,
       SUM(o.total_price) AS total_sales,
       SUM(o.quantity)    AS total_quantity
FROM products p
         JOIN
     orders o ON p.product_id = o.product_id
GROUP BY p.category
HAVING SUM(o.total_price) > 2000
ORDER BY total_sales DESC;


