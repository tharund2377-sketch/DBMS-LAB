-- =====================================================================
-- DBMS LAB - EXPERIMENT 3
-- =====================================================================
-- CREATE VIEW AND INDEX FOR DATABASE TABLES
-- WITH A LARGE NUMBER OF RECORDS
--
-- DBMS : MySQL 8.0+
-- File : DBMS_Experiment_3_View_and_Index.sql
-- =====================================================================

DROP DATABASE IF EXISTS dbms_experiment_3;
CREATE DATABASE dbms_experiment_3;
USE dbms_experiment_3;

-- =====================================================================
-- AIM
-- =====================================================================
-- To execute and verify SQL commands for creating and using
-- VIEW and INDEX in database tables.

-- =====================================================================
-- 1. CREATE STUDENTS TABLE
-- =====================================================================

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL
);

-- =====================================================================
-- 2. INSERT SAMPLE DATA
-- =====================================================================

INSERT INTO students (student_name, student_email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');

-- Verify table contents
SELECT * FROM students;

-- Expected Output:
-- +------------+---------------+---------------------+
-- | student_id | student_name  | student_email       |
-- +------------+---------------+---------------------+
-- |     1      | Alice Johnson | alice@example.com   |
-- |     2      | Bob Smith     | bob@example.com     |
-- |     3      | Charlie Brown | charlie@example.com |
-- +------------+---------------+---------------------+

-- =====================================================================
-- 3. CREATE VIEW
-- =====================================================================

CREATE OR REPLACE VIEW student_view AS
SELECT
    student_id,
    student_name,
    student_email
FROM students;

-- Verify the view
SELECT * FROM student_view;

-- =====================================================================
-- 4. INSERT A NEW RECORD
-- =====================================================================

INSERT INTO students (student_name, student_email)
VALUES ('Diana Prince', 'diana@example.com');

-- =====================================================================
-- 5. UPDATE AN EXISTING RECORD
-- =====================================================================

UPDATE students
SET student_email = 'new_bob@example.com'
WHERE student_name = 'Bob Smith';

-- =====================================================================
-- 6. DELETE A RECORD
-- =====================================================================

DELETE FROM students
WHERE student_name = 'Charlie Brown';

-- =====================================================================
-- 7. VERIFY CHANGES THROUGH THE VIEW
-- =====================================================================

SELECT * FROM student_view
ORDER BY student_id;

-- Expected Output:
-- +------------+---------------+-----------------------+
-- | student_id | student_name  | student_email         |
-- +------------+---------------+-----------------------+
-- |      1     | Alice Johnson | alice@example.com     |
-- |      2     | Bob Smith     | new_bob@example.com   |
-- |      4     | Diana Prince  | diana@example.com     |
-- +------------+---------------+-----------------------+

-- =====================================================================
-- 8. CREATE INDEX ON STUDENT EMAIL
-- =====================================================================

CREATE INDEX idx_student_email
ON students (student_email);

-- =====================================================================
-- 9. VERIFY INDEX
-- =====================================================================

SHOW INDEX FROM students;

-- =====================================================================
-- 10. TEST QUERY USING THE INDEXED COLUMN
-- =====================================================================

SELECT
    student_id,
    student_name,
    student_email
FROM students
WHERE student_email = 'alice@example.com';

-- Expected Output:
-- +------------+---------------+-------------------+
-- | student_id | student_name  | student_email     |
-- +------------+---------------+-------------------+
-- |      1     | Alice Johnson | alice@example.com |
-- +------------+---------------+-------------------+

-- =====================================================================
-- RESULT
-- =====================================================================
-- The student VIEW was successfully created and verified.
-- INSERT, UPDATE and DELETE operations were executed on the base table,
-- and the changes were reflected through the VIEW.
-- An INDEX on the student_email column was successfully created
-- and verified.

-- =====================================================================
-- END OF EXPERIMENT 3
-- =====================================================================
