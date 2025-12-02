set search_path to baitap2;

CREATE TABLE if not exists products
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(50),
    category VARCHAR(50),
    price    DECIMAL(10, 2),
    stock    INT
);

INSERT INTO products (name, category, price, stock)
VALUES ('Laptop Dell', 'Electronics', 1500.00, 5),
       ('Chuột Logitech', 'Electronics', 25.50, 50),
       ('Bàn phím Razer', 'Electronics', 120.00, 20),
       ('Tủ lạnh LG', 'Home Appliances', 800.00, 3),
       ('Máy giặt Samsung', 'Home Appliances', 600.00, 2);


-- Thêm sản phẩm mới: 'Điều hòa Panasonic', category 'Home Appliances', giá 400.00, stock 10
-- Cập nhật stock của 'Laptop Dell' thành 7
-- Xóa các sản phẩm có stock bằng 0 (nếu có)
-- Liệt kê tất cả sản phẩm theo giá tăng dần
-- Liệt kê danh mục duy nhất của các sản phẩm (DISTINCT)
-- Liệt kê sản phẩm có giá từ 100 đến 1000
-- Liệt kê các sản phẩm có tên chứa từ 'LG' hoặc 'Samsung' (sử dụng LIKE/ILIKE)
-- Hiển thị 2 sản phẩm đầu tiên theo giá giảm dần, hoặc lấy sản phẩm thứ 2 đến thứ 3 bằng LIMIT và OFFSET

insert into products (name, category, price, stock)
VALUES ('Điều hòa Panasonic', 'Home Appliances', '400.00', '10');

update products
set stock = 7
where name = 'Laptop Dell';

delete from products
where stock = 0;

select * from products
order by price;

select distinct category from products;

select * from products
where price between 100 and 1000
order by price;

select * from products
where name ilike '%LG%' or name ilike '%Samsung%'
order by stock;

select * from products
order by price desc
limit 2;







