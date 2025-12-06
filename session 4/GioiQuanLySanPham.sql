create schema if not exists baitap5;

set search_path to baitap5;

CREATE TABLE if not exists products
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(100)   NOT NULL,
    category     VARCHAR(50)    NOT NULL,
    price        NUMERIC(15, 2) NOT NULL CHECK (price >= 0),
    stock        INTEGER CHECK (stock >= 0),
    manufacturer VARCHAR(50)
);

INSERT INTO products (name, category, price, stock, manufacturer)
VALUES ('Laptop Dell XPS 13', 'Laptop', 25000000.00, 12, 'Dell'),
       ('Chuột Logitech M90', 'Phụ kiện', 150000.00, 50, 'Logitech'),
       ('Bàn phím cơ Razer', 'Phụ kiện', 2200000.00, 0, 'Razer'),
       ('Macbook Air M2', 'Laptop', 32000000.00, 7, 'Apple'),
       ('iPhone 14 Pro Max', 'Điện thoại', 35000000.00, 15, 'Apple'),
       ('Laptop Dell XPS 13', 'Laptop', 25000000.00, 12, 'Dell'),
       ('Tai nghe AirPods 3', 'Phụ kiện', 4500000.00, NULL, 'Apple');


-- Chèn dữ liệu mới:
-- Thêm sản phẩm “Chuột không dây Logitech M170”, loại Phụ kiện, giá 300000, tồn kho 20, hãng Logitech
-- Cập nhật dữ liệu:
-- Tăng giá tất cả sản phẩm của Apple thêm 10%
-- Xóa dữ liệu:
-- Xóa sản phẩm có stock = 0
-- Lọc theo điều kiện:
-- Hiển thị sản phẩm có price BETWEEN 1000000 AND 30000000
-- Lọc giá trị NULL:
-- Hiển thị sản phẩm có stock IS NULL
-- Loại bỏ trùng:
-- Liệt kê danh sách hãng sản xuất duy nhất
-- Sắp xếp dữ liệu
-- Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
-- Tìm kiếm (LIKE và ILIKE):
-- Tìm sản phẩm có tên chứa từ “laptop” (không phân biệt hoa thường)
-- Giới hạn kết quả:
-- Chỉ hiển thị 2 sản phẩm đầu tiên sau khi sắp xếp

insert into products(name, category, price, stock, manufacturer)
values ('Chuột không dây Logitech M170','Phụ kiện','300000','20','Logitech');

update products
set price = price*1.1
where id >= 1;

delete from products
where stock = 0;

-- Lọc theo điều kiện:
-- Hiển thị sản phẩm có price BETWEEN 1000000 AND 30000000
-- Lọc giá trị NULL:
-- Hiển thị sản phẩm có stock IS NULL
-- Loại bỏ trùng:
-- Liệt kê danh sách hãng sản xuất duy nhất
-- Sắp xếp dữ liệu
-- Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
-- Tìm kiếm (LIKE và ILIKE):
-- Tìm sản phẩm có tên chứa từ “laptop” (không phân biệt hoa thường)
-- Giới hạn kết quả:
-- Chỉ hiển thị 2 sản phẩm đầu tiên sau khi sắp xếp

select * from products
where price between 1000000 AND 30000000;

select * from products
where stock isnull ;

select distinct manufacturer from products;

select * from products
order by price desc , name;

select name from products
where name ilike '%laptop%';

select * from products
order by price desc , name
limit 2;


