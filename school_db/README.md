# school_db

School database for Sessions 2 to 5.

## Session 2 – school_setup.sql
Question: write school_setup.sql in a new folder school_db. Create
database school_db and a students table (roll_no, name, class, city).
Add subjects and marks tables, with no foreign keys. ALTER students
to add an email column, then change city to VARCHAR(50). Create and
drop a scratch table temp_notes. Start with DROP DATABASE IF EXISTS
and end with SHOW TABLES.

Screenshot: show_tables.png

## Session 3 – school_data.sql
Question: write school_data.sql. Insert 8 students and 5 subjects
with two INSERT statements. Insert 20 marks rows for students 1-5
and subjects 1-4. UPDATEs: promote class 9A to 10A, correct one
student's city, add 5 grace marks to one marks row. DELETE a
duplicate marks row, then one student's marks and the student.
Every UPDATE and DELETE has a WHERE clause.

## Session 4 – school_queries.sql
Question: write school_queries.sql. SELECTs: students of class 10A
sorted by name, marks 80 and above highest first, three highest
marks, student names shown as student_name. SUM, AVG and COUNT:
total marks of roll 1, average marks of subject 1, number of
students in class 10A. GROUP BY: average marks per subject, total
marks per student highest first, marks rows per subject. Topper
query: roll_no with the highest total, LIMIT 1.

Topper: roll_no 4 with total 344.
Screenshot: topper.png

## Session 5 – school_joins.sql
Question: write school_joins.sql. Add two foreign keys named
fk_marks_student and fk_marks_subject. Try to insert a marks row
for roll_no 99 and keep the error text as a comment. INNER JOIN:
report card of roll 1 with name, subject, marks and max marks,
sorted by subject name. Add a new student with no marks, then
LEFT JOIN to list only students with no marks. RIGHT JOIN: every
subject with a COUNT of its marks, including subject 5 at 0.

Error 1452 on the roll 99 insert proves the foreign key works.
