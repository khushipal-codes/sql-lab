# Mini Project 3 – tuition_fee_db

Tuition fee database. Everything is in one file, tuition_fee_db.sql.

Question: create tuition_fee_db with students (student_id, name,
class, city), courses (course_id, course_name, monthly_fee) and
payments (payment_id, student_id, course_id, amount, paid_on).
payments has foreign keys to students and courses. Insert 5
students, 3 courses with fees from 800 to 2500, and 10 payments
dated in two different months. Update one course's fee, delete one
payment, and finish with a JOIN listing student name, course name,
amount and date sorted by date. Add a procedure monthly_fee_summary
that prints, for one month, each course with its number of payments
and total collected, and a grand total in its own SELECT.

The file runs top to bottom twice without an error.
- October 2026 total: 6200.00
- November 2026 total: 5000.00

Screenshots: summary_month1.png, summary_month2.png
