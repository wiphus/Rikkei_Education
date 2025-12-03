create schema baitap4;

set search_path to baitap4;

-- Tạo bảng students
CREATE TABLE if not exists students
(
    ID    SERIAL PRIMARY KEY,
    name  VARCHAR(50),
    age   INT,
    major VARCHAR(50),
    gpa   DECIMAL(3, 2)
);

-- Tạo bảng scholarships
CREATE TABLE if not exists scholarships
(
    id         SERIAL PRIMARY KEY,
    student_id INT REFERENCES students (ID),
    name       VARCHAR(50),
    amount     DECIMAL(10, 2),
    year       INT
);

-- Chèn dữ liệu vào bảng students
INSERT INTO students (name, age, major, gpa)
VALUES ('An', 20, 'CNTT', 3.5),
       ('Bình', 21, 'Toán', 3.2),
       ('Cường', 22, 'CNTT', 3.8),
       ('Dương', 20, 'Vật lý', 3.0),
       ('Em', 21, 'CNTT', 2.9);

-- Chèn dữ liệu vào bảng scholarships
INSERT INTO scholarships (student_id, name, amount, year)
VALUES (1, 'Học bổng xuất sắc', 1000, 2025),
       (3, 'Học bổng xuất sắc', 1200, 2025),
       (2, 'Học bổng khuyến khích', 500, 2025),
       (4, 'Học bổng khuyến khích', 400, 2025);

-- Thêm học bổng mới cho sinh viên "Em" với tên "Học bổng khuyến khích" và giá trị 450 cho năm 2025
-- Cập nhật GPA của sinh viên có học bổng "Học bổng xuất sắc" lên 4.0
-- Xóa các học bổng của sinh viên có GPA < 3.0
-- Liệt kê tên sinh viên, chuyên ngành, tên học bổng và số tiền của các học bổng năm 2025, sắp xếp theo số tiền giảm dần
-- Liệt kê các sinh viên có nhiều hơn 1 học bổng (sử dụng GROUP BY và HAVING)
-- Liệt kê sinh viên có tên chứa chữ 'C' và nhận học bổng > 1000
-- Hiển thị 2 sinh viên đầu tiên theo GPA giảm dần, sử dụng LIMIT/OFFSET

insert into scholarships (student_id, name, amount, year)
VALUES (5, 'Học bổng khuyến khích', 450, 2025);


update students
set gpa = 4.00
where id in (select student_id from scholarships
                     where name = 'Học bổng xuất sắc');

delete from scholarships
where student_id in(
select id from students
where gpa < 3.00);

select
    st.name as tensinhvien,
    st.major as chuyennganh,
    sch.name as tenhocbong,
    sch.amount as sotien
from students st,
     scholarships sch
where st.id = sch.student_id
and sch.year = 2025
order by
    sch.amount desc ;

-- Liệt kê các sinh viên có nhiều hơn 1 học bổng (sử dụng GROUP BY và HAVING)
-- Liệt kê sinh viên có tên chứa chữ 'C' và nhận học bổng > 1000
-- Hiển thị 2 sinh viên đầu tiên theo GPA giảm dần, sử dụng LIMIT/OFFSET

select
    st.name as tensinhvien,
    count(s.id) as sohocbong
from students st
inner join scholarships s on st.ID = s.student_id
group by st.ID, st.name
having count(s.id) > 1;

select st.name as tensinhvien
from students st
inner join scholarships s on st.ID = s.student_id
where st.name ilike 'C%' and s.amount > 1000;

select * from students
order by gpa desc
limit 2
offset 0;

