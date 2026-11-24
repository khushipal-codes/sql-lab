DROP DATABASE IF EXISTS tuition_fee_db;
CREATE DATABASE tuition_fee_db;
USE tuition_fee_db;

-- task 1
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class VARCHAR(10),
    city VARCHAR(30)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    monthly_fee DECIMAL(8,2)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    amount DECIMAL(8,2),
    paid_on DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- task 2
INSERT INTO students (student_id, name, class, city) VALUES
(1, 'Kabir Shah', '10A', 'Ahmedabad'),
(2, 'Meera Joshi', '9B', 'Pune'),
(3, 'Nikhil Rao', '10A', 'Bengaluru'),
(4, 'Tara Singh', '8A', 'Jaipur'),
(5, 'Dev Patel', '9B', 'Surat');

INSERT INTO courses (course_id, course_name, monthly_fee) VALUES
(1, 'Maths', 1500.00),
(2, 'Science', 1200.00),
(3, 'English', 800.00);

INSERT INTO payments (student_id, course_id, amount, paid_on) VALUES
(1, 1, 1500.00, '2026-10-05'),
(2, 2, 1200.00, '2026-10-07'),
(3, 1, 1500.00, '2026-10-10'),
(4, 3, 800.00, '2026-10-12'),
(5, 2, 1200.00, '2026-10-15'),
(1, 2, 1200.00, '2026-11-03'),
(2, 1, 1500.00, '2026-11-05'),
(3, 3, 800.00, '2026-11-08'),
(4, 1, 1500.00, '2026-11-11'),
(5, 3, 800.00, '2026-11-14');

UPDATE courses SET monthly_fee = 2500.00 WHERE course_id = 1;

DELETE FROM payments WHERE payment_id = 10;

SELECT s.name AS student_name, c.course_name, p.amount, p.paid_on
FROM payments p
INNER JOIN students s ON p.student_id = s.student_id
INNER JOIN courses c ON p.course_id = c.course_id
ORDER BY p.paid_on;

-- task 3
DROP PROCEDURE IF EXISTS monthly_fee_summary;
DELIMITER $$

CREATE PROCEDURE monthly_fee_summary(IN p_month INT, IN p_year INT)
BEGIN
    SELECT c.course_name, COUNT(*) AS number_of_payments, SUM(p.amount) AS total_collected
    FROM payments p
    INNER JOIN courses c ON p.course_id = c.course_id
    WHERE MONTH(p.paid_on) = p_month AND YEAR(p.paid_on) = p_year
    GROUP BY c.course_name;
    SELECT SUM(p.amount) AS grand_total
    FROM payments p
    WHERE MONTH(p.paid_on) = p_month AND YEAR(p.paid_on) = p_year;
END $$

DELIMITER ;

-- task 4
-- hand addition of all 10 payments: 1500 + 1200 + 1500 + 800 + 1200 + 1200 + 1500 + 800 + 1500 + 800 = 12000
-- minus deleted payment (800): 12000 - 800 = 11200
-- month 1 (Oct 2026): 1500 + 1200 + 1500 + 800 + 1200 = 6200
-- month 2 (Nov 2026): 1200 + 1500 + 800 + 1500 = 5000
CALL monthly_fee_summary(10, 2026);
CALL monthly_fee_summary(11, 2026);
