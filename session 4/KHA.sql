SET SEARCH_PATH TO baitap1;
CREATE TABLE if not exists students
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(50),
    age   INT,
    major VARCHAR(50),
    gpa   DECIMAL(3, 2)
);

INSERT INTO students (name, age, major, gpa)
VALUES ('An', 20, 'CNTT', 3.5),
       ('Bình', 21, 'Toán', 3.2),
       ('Cường', 22, 'CNTT', 3.8),
       ('Dương', 20, 'Vật lý', 3.0),
       ('Em', 21, 'CNTT', 2.9);

-- Thêm sinh viên mới: "Hùng", 23 tuổi, chuyên ngành "Hóa học", GPA 3.4
-- Cập nhật GPA của sinh viên "Bình" thành 3.6
-- Xóa sinh viên có GPA thấp hơn 3.0
-- Liệt kê tất cả sinh viên, chỉ hiển thị tên và chuyên ngành, sắp xếp theo GPA giảm dần
-- Liệt kê tên sinh viên duy nhất có chuyên ngành "CNTT"
-- Liệt kê sinh viên có GPA từ 3.0 đến 3.6
-- Liệt kê sinh viên có tên bắt đầu bằng chữ 'C' (sử dụng LIKE/ILIKE)
-- Hiển thị 3 sinh viên đầu tiên theo thứ tự tên tăng dần, hoặc lấy từ sinh viên thứ 2 đến thứ 4 bằng LIMIT và OFFSET

insert into students(name, age, major, gpa)
values ('Hùng', '23', 'HOAHOC', '3.4');

update students
set gpa = 3.60
where name = 'Bình';

delete
from students
where gpa < 3.00;

select major
from students
order by gpa desc;

select *
from students
where gpa between 3.00 and 3.60;

select *
from students
where name ILIKE 'C%';

select * from students
order by id
limit 3;

select distinct name from students
where gpa between 3.00 and 3.60 and major = 'CNTT';
