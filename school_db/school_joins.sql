USE school_db;

-- task 1
ALTER TABLE marks ADD CONSTRAINT fk_marks_student FOREIGN KEY (roll_no) REFERENCES students(roll_no);
ALTER TABLE marks ADD CONSTRAINT fk_marks_subject FOREIGN KEY (subject_id) REFERENCES subjects(subject_id);
INSERT INTO marks (roll_no, subject_id, marks_obtained) VALUES (99, 1, 50);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`school_db`.`marks`, CONSTRAINT `fk_marks_student` FOREIGN KEY (`roll_no`) REFERENCES `students` (`roll_no`))

-- task 2
SELECT s.name, sub.subject_name, m.marks_obtained, sub.max_marks
FROM students s
INNER JOIN marks m ON s.roll_no = m.roll_no
INNER JOIN subjects sub ON m.subject_id = sub.subject_id
WHERE s.roll_no = 1
ORDER BY sub.subject_name;

-- task 3
INSERT INTO students (roll_no, name, class, city, email) VALUES (9, 'Kavya Desai', '9B', 'Indore', 'kavya.desai@example.com');
SELECT s.roll_no, s.name, s.class
FROM students s
LEFT JOIN marks m ON s.roll_no = m.roll_no
WHERE m.marks_id IS NULL;

-- task 4
SELECT sub.subject_id, sub.subject_name, COUNT(m.marks_id) AS number_of_marks
FROM marks m
RIGHT JOIN subjects sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_id, sub.subject_name;
