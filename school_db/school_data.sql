-- Session 3: DML Operations
-- Insert, Update and Delete data in school_db
-- Run school_setup.sql first if the tables do not exist yet.

USE school_db;

-- Workbench Safe Updates refuses UPDATE/DELETE without a key column (Error 1175).
-- Switch it off for this script so the class-wide UPDATE works.
SET SQL_SAFE_UPDATES = 0;

-- Task 1: 8 students, one multi-row INSERT
INSERT INTO students (roll_no, name, class, city, email) VALUES
(1, 'Aarav Sharma', '9A', 'Ahmedabad', 'aarav.sharma@example.com'),
(2, 'Priya Nair', '9A', 'Kochi', 'priya.nair@example.com'),
(3, 'Rohan Verma', '9B', 'Delhi', 'rohan.verma@example.com'),
(4, 'Sneha Patil', '9B', 'Pune', 'sneha.patil@example.com'),
(5, 'Vikram Singh', '9A', 'Jaipur', 'vikram.singh@example.com'),
(6, 'Ananya Iyer', '9B', 'Chennai', 'ananya.iyer@example.com'),
(7, 'Arjun Mehta', '9A', 'Surat', 'arjun.mehta@example.com'),
(8, 'Divya Reddy', '9B', 'Hyderabad', 'divya.reddy@example.com');

-- Task 1: 5 subjects, one multi-row INSERT
INSERT INTO subjects (subject_id, subject_name, max_marks) VALUES
(1, 'Maths', 100),
(2, 'Science', 100),
(3, 'English', 100),
(4, 'Hindi', 100),
(5, 'Social Science', 100);

SELECT * FROM students;
SELECT * FROM subjects;

-- Task 2: 20 marks rows, students 1 to 5 in subjects 1 to 4 (subject 5 gets no marks)
INSERT INTO marks (roll_no, subject_id, marks_obtained) VALUES
(1, 1, 78), (1, 2, 85), (1, 3, 72), (1, 4, 88),
(2, 1, 92), (2, 2, 76), (2, 3, 81), (2, 4, 69),
(3, 1, 65), (3, 2, 71), (3, 3, 58), (3, 4, 74),
(4, 1, 88), (4, 2, 94), (4, 3, 79), (4, 4, 83),
(5, 1, 45), (5, 2, 52), (5, 3, 61), (5, 4, 39);

SELECT * FROM marks;

-- Task 3: promote every student of class 9A to 10A
UPDATE students SET class = '10A' WHERE class = '9A';
SELECT * FROM students WHERE class = '10A';

-- Task 3: correct one student's city
UPDATE students SET city = 'New Delhi' WHERE roll_no = 3;
SELECT * FROM students WHERE roll_no = 3;

-- Task 3: add 5 grace marks to one marks row
UPDATE marks SET marks_obtained = marks_obtained + 5 WHERE marks_id = 1;
SELECT * FROM marks WHERE marks_id = 1;

-- Task 4: first five marks rows BEFORE the deletions
SELECT * FROM marks LIMIT 5;

-- Task 4: add a duplicate marks row on purpose, then remove one copy
INSERT INTO marks (roll_no, subject_id, marks_obtained) VALUES (1, 2, 85);
DELETE FROM marks WHERE roll_no = 1 AND subject_id = 2 AND marks_obtained = 85 LIMIT 1;

-- Task 4: delete one student's marks first, then the student
DELETE FROM marks WHERE roll_no = 5;
DELETE FROM students WHERE roll_no = 5;

-- Task 4: first five marks rows AFTER the deletions
SELECT * FROM marks LIMIT 5;
