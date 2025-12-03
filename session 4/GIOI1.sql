create schema baitap3;

set search_path to baitap3;

CREATE TABLE if not exists sinhvien
  (
      id         SERIAL PRIMARY KEY,
      full_name  TEXT NOT NULL,
      gender     VARCHAR(10),
      birth_year INTEGER,
      major      VARCHAR(50),
      gpa        NUMERIC(3, 2)
  );

INSERT INTO sinhvien (full_name, gender, birth_year, major, gpa)
VALUES ('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
       ('Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
       ('Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
       ('Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
       ('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
       ('Lưu Đức Tài', NULL, 2004, 'Cơ khí', NULL),
       ('Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);
-- Chèn dữ liệu mới:
-- Thêm sinh viên “Phan Hoàng Nam”, giới tính Nam, sinh năm 2003, ngành CNTT, GPA 3.8
-- Cập nhật dữ liệu:
-- Sinh viên “Lê Quốc Cường” vừa cải thiện học lực, cập nhật gpa = 3.4
-- Xóa dữ liệu:
-- Xóa tất cả sinh viên có gpa IS NULL
-- Truy vấn cơ bản:
-- Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
-- Loại bỏ trùng lặp:
-- Liệt kê danh sách ngành học duy nhất
-- Sắp xếp:
-- Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
-- Tìm kiếm:
-- Tìm sinh viên có tên bắt đầu bằng “Nguyễn”
-- Khoảng giá trị:
-- Hiển thị sinh viên có năm sinh từ 2001 đến 2003

insert into sinhvien(full_name, gender, birth_year, major, gpa)
VALUES ('Phan Hoàng Nam', 'Nam', '2003', 'CNTT', '3.80');

update sinhvien
set gpa = 3.40
where full_name = 'Lê Quốc Cường';

delete from sinhvien
where gpa isnull ;

select * from sinhvien
where major = 'CNTT' and gpa >= 3.00
limit 3;

select distinct major from sinhvien;

delete
from sinhvien
where id in
      (select id
       from sinhvien
       where full_name = (select full_name
                          from sinhvien
                          where major = 'CNTT'
                          group by full_name, gpa
                          having count(id) >= 2
                          order by gpa desc, full_name)
       limit 1);

select * from sinhvien
where full_name ILIKE 'Nguyễn%';

select * from sinhvien
where birth_year between 2001 and 2003;



