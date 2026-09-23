-- =====================================================================
-- DBMS LAB - EXPERIMENTS 2 & 3
-- =====================================================================
-- Experiment 2 : Implementation of SQL Commands for JOIN Queries
-- Experiment 3 : Create VIEW and INDEX for Database Tables
--                with a Large Number of Records
--
-- DBMS        : MySQL 8.0+
-- File        : DBMS_Experiments_2_3.sql
-- =====================================================================

DROP DATABASE IF EXISTS dbms_experiments_2_3;
CREATE DATABASE dbms_experiments_2_3;
USE dbms_experiments_2_3;

-- =====================================================================
-- EXPERIMENT 2
-- IMPLEMENTATION OF SQL COMMANDS FOR JOIN QUERIES
-- =====================================================================

-- AIM:
-- To execute and verify the SQL commands for JOIN queries.

-- ---------------------------------------------------------------------
-- 1. TABLE CREATION
-- ---------------------------------------------------------------------

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Age INT NOT NULL
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(20) NOT NULL
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Grade VARCHAR(5),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- ---------------------------------------------------------------------
-- 2. INSERT SAMPLE DATA
-- ---------------------------------------------------------------------

INSERT INTO Students (StudentID, Name, Age) VALUES
(1, 'Alice', 20),
(2, 'Bob', 22),
(3, 'Charlie', 21);

-- The source document's displayed Courses table uses CourseID 1, 2, 3.
INSERT INTO Courses (CourseID, CourseName) VALUES
(1, 'Math'),
(2, 'English'),
(3, 'History');

INSERT INTO Enrollments
    (EnrollmentID, StudentID, CourseID, Grade)
VALUES
(1, 1, 1, 'A'),
(2, 1, 2, 'B'),
(3, 2, 1, 'A-'),
(4, 3, 3, 'B+'),
(5, 3, 2, 'A');

-- ---------------------------------------------------------------------
-- 3. INNER JOIN
-- Get student's enrollments with course details
-- ---------------------------------------------------------------------

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students AS s
INNER JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
INNER JOIN Courses AS c
    ON e.CourseID = c.CourseID
ORDER BY e.EnrollmentID;

-- Expected Output:
-- +-----------+---------+-----+----------+------------+-------+
-- | StudentID | Name    | Age | CourseID | CourseName | Grade |
-- +-----------+---------+-----+----------+------------+-------+
-- |     1     | Alice   | 20  |    1     | Math       | A     |
-- |     1     | Alice   | 20  |    2     | English    | B     |
-- |     2     | Bob     | 22  |    1     | Math       | A-    |
-- |     3     | Charlie | 21  |    3     | History    | B+    |
-- |     3     | Charlie | 21  |    2     | English    | A     |
-- +-----------+---------+-----+----------+------------+-------+

-- ---------------------------------------------------------------------
-- 4. LEFT JOIN
-- Get all students and their enrollments, including students
-- with no enrollments.
-- ---------------------------------------------------------------------

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students AS s
LEFT JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses AS c
    ON e.CourseID = c.CourseID
ORDER BY s.StudentID, e.EnrollmentID;

-- Expected Output:
-- With the sample data above, every student has at least one
-- enrollment, so the result contains the same five enrollment rows
-- as the INNER JOIN.

-- ---------------------------------------------------------------------
-- 5. RIGHT JOIN
-- Get all courses and their enrollments, including courses with
-- no enrollments.
-- ---------------------------------------------------------------------

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students AS s
RIGHT JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
RIGHT JOIN Courses AS c
    ON e.CourseID = c.CourseID
ORDER BY c.CourseID, e.EnrollmentID;

-- Expected Output:
-- +-----------+---------+-----+----------+------------+-------+
-- | StudentID | Name    | Age | CourseID | CourseName | Grade |
-- +-----------+---------+-----+----------+------------+-------+
-- |     1     | Alice   | 20  |    1     | Math       | A     |
-- |     2     | Bob     | 22  |    1     | Math       | A-    |
-- |     1     | Alice   | 20  |    2     | English    | B     |
-- |     3     | Charlie | 21  |    2     | English    | A     |
-- |     3     | Charlie | 21  |    3     | History    | B+    |
-- +-----------+---------+-----+----------+------------+-------+

-- ---------------------------------------------------------------------
-- 6. FULL OUTER JOIN
-- MySQL does not provide FULL OUTER JOIN directly.
-- The equivalent result is produced using LEFT JOIN + RIGHT JOIN
-- with UNION.
-- ---------------------------------------------------------------------

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students AS s
LEFT JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
LEFT JOIN Courses AS c
    ON e.CourseID = c.CourseID

UNION

SELECT
    s.StudentID,
    s.Name,
    s.Age,
    c.CourseID,
    c.CourseName,
    e.Grade
FROM Students AS s
RIGHT JOIN Enrollments AS e
    ON s.StudentID = e.StudentID
RIGHT JOIN Courses AS c
    ON e.CourseID = c.CourseID;

-- ---------------------------------------------------------------------
-- 7. RESULT - EXPERIMENT 2
-- ---------------------------------------------------------------------
-- SQL JOIN queries successfully retrieve related information from
-- Students, Courses and Enrollments using INNER JOIN, LEFT JOIN,
-- RIGHT JOIN and a MySQL-compatible FULL OUTER JOIN equivalent.

-- =====================================================================
-- END OF EXPERIMENT 2
-- =====================================================================
