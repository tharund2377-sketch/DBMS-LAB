-- ================================================================
-- DBMS LAB: SIMPLE, NESTED & SUBQUERIES
-- Experiment: Implementation of Simple Queries, Nested Queries
--             and Subqueries
-- DBMS: MySQL 8.0+
-- ================================================================

DROP DATABASE IF EXISTS dbms_query_lab;
CREATE DATABASE dbms_query_lab;
USE dbms_query_lab;

-- ================================================================
-- 1. TABLE CREATION
-- ================================================================

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Age INT NOT NULL
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50) NOT NULL
);

CREATE TABLE Enrollments (
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_enrollment_course
        FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- ================================================================
-- 2. SAMPLE DATA
-- ================================================================

INSERT INTO Students (StudentID, Name, Age) VALUES
(1, 'Alice', 20),
(2, 'Bob', 22),
(3, 'Charlie', 21),
(4, 'David', 19);

INSERT INTO Courses (CourseID, CourseName) VALUES
(101, 'Database Management'),
(102, 'Algorithms'),
(103, 'Web Development');

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 101),
(1, 102),
(2, 102),
(3, 101),
(3, 103),
(4, 103);

-- ================================================================
-- 3. SIMPLE QUERIES
-- ================================================================

-- 3.1 Retrieve all students
SELECT * FROM Students;

-- Expected Output:
-- +-----------+---------+-----+
-- | StudentID | Name    | Age |
-- +-----------+---------+-----+
-- |     1     | Alice   | 20  |
-- |     2     | Bob     | 22  |
-- |     3     | Charlie | 21  |
-- |     4     | David   | 19  |
-- +-----------+---------+-----+

-- 3.2 Retrieve names and ages of students older than 20
SELECT Name, Age
FROM Students
WHERE Age > 20;

-- Expected Output:
-- +---------+-----+
-- | Name    | Age |
-- +---------+-----+
-- | Bob     | 22  |
-- | Charlie | 21  |
-- +---------+-----+

-- ================================================================
-- 4. NESTED QUERIES
-- ================================================================

-- 4.1 Find students enrolled in 'Database Management'
SELECT Name
FROM Students
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollments
    WHERE CourseID = (
        SELECT CourseID
        FROM Courses
        WHERE CourseName = 'Database Management'
    )
);

-- Expected Output:
-- +---------+
-- | Name    |
-- +---------+
-- | Alice   |
-- | Charlie |
-- +---------+

-- 4.2 Retrieve courses having more than one student enrolled
SELECT CourseID, CourseName
FROM Courses
WHERE CourseID IN (
    SELECT CourseID
    FROM Enrollments
    GROUP BY CourseID
    HAVING COUNT(*) > 1
);

-- Expected Output:
-- +----------+---------------------+
-- | CourseID | CourseName          |
-- +----------+---------------------+
-- |   101    | Database Management  |
-- |   103    | Web Development     |
-- +----------+---------------------+

-- ================================================================
-- 5. SUBQUERIES
-- ================================================================

-- 5.1 Calculate the average age of all students
SELECT AVG(Age) AS AverageAge
FROM Students;

-- Expected Output:
-- +------------+
-- | AverageAge |
-- +------------+
-- |   20.5000  |
-- +------------+

-- 5.2 Find students whose age is greater than the average age
SELECT Name, Age
FROM Students
WHERE Age > (
    SELECT AVG(Age)
    FROM Students
);

-- Expected Output:
-- +---------+-----+
-- | Name    | Age |
-- +---------+-----+
-- | Bob     | 22  |
-- | Charlie | 21  |
-- +---------+-----+

-- ================================================================
-- 6. OPTIONAL VERIFICATION QUERIES
-- ================================================================

-- Verify table contents
SELECT * FROM Courses;
SELECT * FROM Enrollments;

-- Show the number of students enrolled in each course
SELECT
    c.CourseID,
    c.CourseName,
    COUNT(e.StudentID) AS StudentCount
FROM Courses c
LEFT JOIN Enrollments e
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY c.CourseID;

-- ================================================================
-- END OF EXPERIMENT
-- ================================================================
