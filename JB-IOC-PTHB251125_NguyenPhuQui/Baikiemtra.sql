CREATE SCHEMA IF NOT EXISTS QUANLYKHACHSAN;
SET SEARCH_PATH TO QUANLYKHACHSAN;

CREATE TABLE Customer
(
    customer_id        VARCHAR(5) PRIMARY KEY,
    customer_full_name VARCHAR(100) NOT NULL,
    customer_email     VARCHAR(100) NOT NULL UNIQUE,
    customer_phone     VARCHAR(15)  NOT NULL,
    customer_address   VARCHAR(255) NOT NULL
);

CREATE TABLE Room
(
    room_id     VARCHAR(5) PRIMARY KEY,
    room_type   VARCHAR(50)    NOT NULL,
    room_price  DECIMAL(10, 2) NOT NULL,
    room_status VARCHAR(20)    NOT NULL,
    room_area   INT            NOT NULL
);

CREATE TABLE Booking
(
    booking_id     SERIAL PRIMARY KEY,
    customer_id    VARCHAR(5) NOT NULL,
    room_id        VARCHAR(5) NOT NULL,
    check_in_date  DATE       NOT NULL,
    check_out_date DATE       NOT NULL,
    total_amount   DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id),
    FOREIGN KEY (room_id) REFERENCES Room (room_id)
);

CREATE TABLE Payment
(
    payment_id     SERIAL PRIMARY KEY,
    booking_id     INT            NOT NULL,
    payment_method VARCHAR(50)    NOT NULL,
    payment_date   DATE           NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking (booking_id)
);


INSERT INTO Customer
VALUES ('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0912345678', 'Hanoi, Vietnam'),
       ('C002', 'Tran Thi Mai', 'mai.tran@example.com', '0923456789', 'Ho Chi Minh, Vietnam'),
       ('C003', 'Le Minh Hoang', 'hoang.le@example.com', '0934567890', 'Danang, Vietnam'),
       ('C004', 'Pham Hoang Nam', 'nam.pham@example.com', '0945678901', 'Hue, Vietnam'),
       ('C005', 'Vu Minh Thu', 'thu.vu@example.com', '0956789012', 'Hai Phong, Vietnam');

INSERT INTO Room
VALUES ('R001', 'Single', 100.0, 'Available', 25),
       ('R002', 'Double', 150.0, 'Booked', 40),
       ('R003', 'Suite', 250.0, 'Available', 60),
       ('R004', 'Single', 120.0, 'Booked', 30),
       ('R005', 'Double', 160.0, 'Available', 35);


INSERT INTO Booking (customer_id, room_id, check_in_date, check_out_date, total_amount)
VALUES ('C001', 'R001', '2025-03-01', '2025-03-05', 400.0),
       ('C002', 'R002', '2025-03-02', '2025-03-06', 600.0),
       ('C003', 'R003', '2025-03-03', '2025-03-07', 1000.0),
       ('C004', 'R004', '2025-03-04', '2025-03-08', 480.0),
       ('C005', 'R005', '2025-03-05', '2025-03-09', 800.0);


INSERT INTO Payment (booking_id, payment_method, payment_date, payment_amount)
VALUES (1, 'Cash', '2025-03-05', 400.0),
       (2, 'Credit Card', '2025-03-06', 600.0),
       (3, 'Bank Transfer', '2025-03-07', 1000.0),
       (4, 'Cash', '2025-03-08', 480.0),
       (5, 'Credit Card', '2025-03-09', 800.0);

-- 3. Cập nhật dữ liệu (6 điểm) Viết câu lệnh UPDATE để cập nhật lại total_amount trong bảng Booking theo công thức: total_amount = total_amount * 0.9 cho những bản ghi có ngày check_in trước ngày 3/3/2025.
UPDATE Booking
SET total_amount = total_amount * 0.9
WHERE check_in_date < '2025-03-03';
-- 4. Xóa dữ liệu (6 điểm) Viết câu lệnh DELETE để xóa các thanh toán trong bảng Payment nếu:
--                                           - Phương thức thanh toán (payment_method) là "Cash".
--                                           - Và tổng tiền thanh toán (payment_amount) nhỏ hơn 500.
DELETE
FROM Payment
WHERE payment_method = 'Cash'
  AND payment_amount < 500;
-- Lấy thông tin khách hàng gồm: mã khách hàng, họ tên, email, số điện thoại được sắp xếp theo họ tên khách hàng giảm dần.
SELECT customer_id, customer_full_name, customer_email, customer_phone
FROM Customer
ORDER BY customer_full_name DESC;
-- Lấy thông tin các phòng khách sạn gồm: mã phòng, loại phòng, giá phòng và diện tích phòng, sắp xếp theo diện tích phòng tăng dần.
SELECT room_id, room_type, room_price, room_area
FROM Room
ORDER BY room_area;
-- Lấy thông tin khách hàng và phòng khách sạn đã đặt gồm: họ tên khách hàng, mã phòng, ngày nhận phòng và ngày trả phòng.
SELECT c.customer_full_name AS "Họ tên khách hàng",
       b.room_id            AS "Mã phòng",
       b.check_in_date      AS "Ngày nhận phòng",
       b.check_out_date     AS "Ngày trả phòng"
FROM Customer c
         JOIN
     Booking b ON b.customer_id = c.customer_id
         JOIN
     Room r ON b.room_id = r.room_id;
-- Lấy danh sách khách hàng và tổng tiền đã thanh toán khi đặt phòng, gồm mã khách hàng, họ tên khách hàng,
-- phương thức thanh toán và số tiền thanh toán, sắp xếp theo số tiền thanh toán tăng dần.
SELECT c.customer_id        AS "Mã khách hàng",
       c.customer_full_name AS "Họ tên khách hàng",
       p.payment_method     AS "Phương thức thanh toán",
       p.payment_amount     AS "Số tiền thanh toán"
FROM Customer c
         JOIN
     Booking b ON c.customer_id = b.customer_id
         JOIN
     Payment p ON b.booking_id = p.booking_id
ORDER BY p.payment_amount ASC;
-- Lấy tất cả thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong bảng Customer được sắp xếp theo tên khách hàng (Z-A).
SELECT *
FROM Customer
ORDER BY customer_full_name DESC
LIMIT 3 OFFSET 1;
-- Lấy danh sách khách hàng đã đặt ít nhất 2 phòng gồm : mã khách hàng, họ tên khách hàng và số lượng phòng đã đặt.
SELECT c.customer_id        AS "Mã khách hàng",
       c.customer_full_name AS "Họ tên khách hàng",
       COUNT(b.room_id)     AS "Số lượng phòng đã đặt"
FROM Customer c
         JOIN
     Booking b ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.customer_full_name
HAVING COUNT(b.room_id) >= 2;
-- Lấy danh sách các phòng từng có ít nhất 3 khách hàng đặt, gồm mã phòng, loại phòng, giá phòng và số lần đã đặt.
SELECT r.room_id           AS "Mã phòng",
       r.room_type         AS "Loại phòng",
       r.room_price        AS "Giá phòng",
       COUNT(b.booking_id) AS "Số lần đã đặt"
FROM Room r
         JOIN
     Booking b ON r.room_id = b.room_id
GROUP BY r.room_id, r.room_type, r.room_price
HAVING COUNT(b.booking_id) >= 3;
-- Lấy danh sách các khách hàng có tổng số tiền đã thanh toán lớn hơn 1000, gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng số tiền đã thanh toán.
SELECT c.customer_id         AS "Mã khách hàng",
       c.customer_full_name  AS "Họ tên khách hàng",
       b.room_id             AS "Mã phòng",
       SUM(p.payment_amount) AS "Tổng tiền đã thanh toán"
FROM Customer c
         JOIN
     Booking b ON c.customer_id = b.customer_id
         JOIN
     Payment p ON b.booking_id = p.booking_id
GROUP BY c.customer_id,
         c.customer_full_name,
         b.room_id
HAVING SUM(p.payment_amount) > 1000;
-- Lấy danh sách các khách hàng gồm : mã KH, Họ tên, email, sđt có họ tên chứa chữ "Minh" hoặc địa chỉ ở "Hanoi". Sắp xếp kết quả theo họ tên tăng dần.
SELECT customer_id,
       customer_full_name,
       customer_email,
       customer_phone
FROM Customer
WHERE customer_full_name LIKE '%Minh%'
   OR customer_address LIKE '%Hanoi%'
ORDER BY customer_full_name;
-- Lấy danh sách thông tin các phòng gồm : mã phòng, loại phòng, giá , sắp xếp theo giá phòng giảm dần.
-- Chỉ lấy 5 phòng và bỏ qua 5 phòng đầu tiên (tức là lấy kết quả của trang thứ 2, biết mỗi trang có 5 phòng).
SELECT room_id, room_type, room_price
FROM Room
ORDER BY room_price DESC
LIMIT 5 OFFSET 5;
-- Hãy tạo một view để lấy thông tin các phòng và khách hàng đã đặt, với điều kiện ngày nhận phòng nhỏ hơn ngày 2025-03-04.
-- Cần hiển thị các thông tin sau: Mã phòng, Loại phòng, Mã khách hàng, họ tên khách hàng
CREATE VIEW View1 AS
SELECT r.room_id            AS "Mã phòng",
       r.room_type          AS "Loại phòng",
       c.customer_id        AS "Mã khách hàng",
       c.customer_full_name AS "Họ tên khách hàng"
FROM Booking b
         JOIN
     Room r ON b.room_id = r.room_id
         JOIN
     Customer c ON b.customer_id = c.customer_id
WHERE b.check_in_date < '2025-03-04';
-- Hãy tạo một view để lấy thông tin khách hàng và phòng đã đặt, với điều kiện diện tích phòng lớn hơn 30 m².
-- Cần hiển thị các thông tin sau: Mã khách hàng, Họ tên khách hàng, Mã phòng, Diện tích phòng, Ngày nhận phòng
CREATE VIEW View2 AS
SELECT c.customer_id        AS "Mã khách hàng",
       c.customer_full_name AS "Họ tên khách hàng",
       r.room_id            AS "Mã phòng",
       r.room_area          AS "Diện tích phòng",
       b.check_in_date      AS "Ngày nhận phòng"
FROM Booking b
         JOIN
     Customer c ON b.customer_id = c.customer_id
         JOIN
     Room r ON b.room_id = r.room_id
WHERE r.room_area > 30;
-- Hãy tạo một trigger check_insert_booking để kiểm tra dữ liệu mối khi chèn vào bảng Booking.
-- Kiểm tra nếu ngày đặt phòng mà sau ngày trả phòng thì thông báo lỗi với nội dung “Ngày đặt phòng không thể sau ngày trả phòng được !” và hủy thao tác chèn dữ liệu vào bảng.
CREATE OR REPLACE FUNCTION TRIGGER1()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    IF NEW.check_in_date > NEW.check_out_date THEN
        RAISE EXCEPTION 'Ngày đặt phòng không thể sau ngày trả phòng được !';
    END IF;
    RETURN NEW;
END;
$$;
CREATE TRIGGER check_insert_booking
    BEFORE INSERT
    ON Booking
    FOR EACH ROW
EXECUTE FUNCTION TRIGGER1();
-- Hãy tạo một trigger có tên là update_room_status_on_booking để tự động cập nhật trạng thái phòng thành "Booked" khi một phòng được đặt (khi có bản ghi được INSERT vào bảng Booking).
CREATE OR REPLACE FUNCTION TRIGGER2()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE Room
    SET room_status = 'Booked'
    WHERE room_id = new.room_id;
    RETURN new;
END;
$$;
CREATE TRIGGER update_room_status_on_booking
    AFTER INSERT
    ON Booking
    FOR EACH ROW
EXECUTE FUNCTION TRIGGER2();
-- Viết store procedure có tên add_customer để thêm mới một khách hàng với đầy đủ các thông tin cần thiết.
CREATE OR REPLACE PROCEDURE add_customer(
    p_id VARCHAR,
    p_name VARCHAR,
    p_email VARCHAR,
    p_phone VARCHAR,
    p_address VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO Customer (customer_id, customer_full_name, customer_email, customer_phone, customer_address)
    VALUES (p_id, p_name, p_email, p_phone, p_address);
END;
$$;
-- Hãy tạo một Stored Procedure  có tên là add_payment để thực hiện việc thêm một thanh toán mới cho một lần đặt phòng.
-- Thay đổi sang Procedure theo yêu cầu của đề bài
CREATE OR REPLACE PROCEDURE add_payment(
    p_booking_id INT,
    p_payment_method VARCHAR(50),
    p_payment_amount DECIMAL(10, 2),
    p_payment_date DATE
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Booking WHERE booking_id = p_booking_id) THEN
        RAISE EXCEPTION 'Lỗi: Mã đặt phòng % không tồn tại trong hệ thống!', p_booking_id;
    END IF;
    INSERT INTO Payment (booking_id, payment_method, payment_date, payment_amount)
    VALUES (p_booking_id, p_payment_method, p_payment_date, p_payment_amount);
END;
$$;

