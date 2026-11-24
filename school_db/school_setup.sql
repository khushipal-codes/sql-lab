DROP DATABASE IF EXISTS school_db;

-- Session 2: SQL Basics & Commands
-- School database: creates school_db, 3 tables, alters students, drops a scratch table

CREATE DATABASE IF NOT EXISTS school_db;
USE school_db;

-- Task 1: students table
CREATE TABLE students (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    class VARCHAR(10),
    city VARCHAR(30)
);
DESCRIBE students;

-- Task 2: two more tables (no foreign keys yet, they come in Session 5)
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

-- Task 3: add an email column to students, then show the table
ALTER TABLE students ADD COLUMN email VARCHAR(60);
DESCRIBE students;

-- Task 3: widen city to VARCHAR(50), then show the table
ALTER TABLE students MODIFY COLUMN city VARCHAR(50);
DESCRIBE students;

-- Task 4: scratch table, created and dropped inside the same script
CREATE TABLE temp_notes (
    note_id INT PRIMARY KEY,
    note_text VARCHAR(100)
);
DROP TABLE temp_notes;

-- Final check: must list exactly students, subjects and marks
SHOW TABLES;
