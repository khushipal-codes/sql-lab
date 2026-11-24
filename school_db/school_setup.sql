DROP DATABASE IF EXISTS school_db;
CREATE DATABASE IF NOT EXISTS school_db;
USE school_db;

-- task 1
CREATE TABLE students (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class VARCHAR(10),
    city VARCHAR(30)
);
DESCRIBE students;

-- task 2
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(40) NOT NULL,
    max_marks INT
);
CREATE TABLE marks (
    marks_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no INT,
    subject_id INT,
    marks_obtained INT
);

-- task 3
ALTER TABLE students ADD COLUMN email VARCHAR(60);
DESCRIBE students;
ALTER TABLE students MODIFY COLUMN city VARCHAR(50);
DESCRIBE students;

-- task 4
CREATE TABLE temp_notes (
    note_id INT PRIMARY KEY,
    note_text VARCHAR(100)
);
DROP TABLE temp_notes;
SHOW TABLES;
