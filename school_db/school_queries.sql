USE school_db;

-- task 1
SELECT * FROM students WHERE class = '10A' ORDER BY name;
SELECT marks_id, roll_no, subject_id, marks_obtained AS marks FROM marks WHERE marks_obtained >= 80 ORDER BY marks_obtained DESC;
SELECT * FROM marks ORDER BY marks_obtained DESC LIMIT 3;
SELECT name AS student_name FROM students;

-- task 2
SELECT SUM(marks_obtained) AS total_marks FROM marks WHERE roll_no = 1;
SELECT ROUND(AVG(marks_obtained), 2) AS average_marks FROM marks WHERE subject_id = 1;
SELECT COUNT(*) AS number_of_students FROM students WHERE class = '10A';

-- task 3
SELECT subject_id, ROUND(AVG(marks_obtained), 2) AS average_marks FROM marks GROUP BY subject_id;
SELECT roll_no, SUM(marks_obtained) AS total_marks FROM marks GROUP BY roll_no ORDER BY total_marks DESC;
SELECT subject_id, COUNT(*) AS number_of_rows FROM marks GROUP BY subject_id;

-- task 4
SELECT roll_no, SUM(marks_obtained) AS total FROM marks GROUP BY roll_no ORDER BY total DESC LIMIT 1;
