/* ==========================================
   PERSONAL INFORMATION SYSTEM
   ========================================== */

SET SERVEROUTPUT ON;
SET LINESIZE 120;
SET PAGESIZE 50;


/* ==========================================
   DROP OLD TABLES
   ========================================== */

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Employment CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Education CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Addresses CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Persons CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


/* ==========================================
   DROP OLD VIEW
   ========================================== */

BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW PersonDetails';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


/* ==========================================
   TABLE 1 : PERSONS
   ========================================== */

CREATE TABLE Persons (
    PersonID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Gender VARCHAR2(10),
    DOB DATE,
    Phone VARCHAR2(15),
    Email VARCHAR2(100)
);


/* ==========================================
   TABLE 2 : ADDRESSES
   ========================================== */

CREATE TABLE Addresses (
    AddressID NUMBER PRIMARY KEY,
    PersonID NUMBER,
    Street VARCHAR2(100),
    City VARCHAR2(50),
    State VARCHAR2(50),
    Pincode VARCHAR2(10),
    CONSTRAINT fk_person
    FOREIGN KEY(PersonID)
    REFERENCES Persons(PersonID)
);


/* ==========================================
   TABLE 3 : EDUCATION
   ========================================== */

CREATE TABLE Education (
    EducationID NUMBER PRIMARY KEY,
    PersonID NUMBER,
    Qualification VARCHAR2(100),
    Institution VARCHAR2(100),
    YearOfPassing NUMBER,
    CONSTRAINT fk_edu_person
    FOREIGN KEY(PersonID)
    REFERENCES Persons(PersonID)
);


/* ==========================================
   TABLE 4 : EMPLOYMENT
   ========================================== */

CREATE TABLE Employment (
    EmployeeID NUMBER PRIMARY KEY,
    PersonID NUMBER,
    CompanyName VARCHAR2(100),
    Designation VARCHAR2(100),
    Salary NUMBER(10,2),
    CONSTRAINT fk_emp_person
    FOREIGN KEY(PersonID)
    REFERENCES Persons(PersonID)
);


/* ==========================================
   SAMPLE DATA
   ========================================== */

INSERT INTO Persons VALUES
(1,'Arun','Kumar','Male',
TO_DATE('15-05-2000','DD-MM-YYYY'),
'9876543210',
'arun@gmail.com');

INSERT INTO Persons VALUES
(2,'Divya','Rani','Female',
TO_DATE('20-08-1999','DD-MM-YYYY'),
'9876543211',
'divya@gmail.com');

INSERT INTO Persons VALUES
(3,'Rahul','Sharma','Male',
TO_DATE('10-01-1998','DD-MM-YYYY'),
'9876543212',
'rahul@gmail.com');


INSERT INTO Addresses VALUES
(1,1,'Anna Nagar','Chennai','Tamil Nadu','600040');

INSERT INTO Addresses VALUES
(2,2,'RS Puram','Coimbatore','Tamil Nadu','641002');

INSERT INTO Addresses VALUES
(3,3,'KK Nagar','Madurai','Tamil Nadu','625020');


INSERT INTO Education VALUES
(1,1,'B.E CSE','Anna University',2021);

INSERT INTO Education VALUES
(2,2,'B.Sc IT','Bharathiar University',2020);

INSERT INTO Education VALUES
(3,3,'MCA','Madurai Kamaraj University',2022);


INSERT INTO Employment VALUES
(1,1,'TCS','Software Engineer',45000);

INSERT INTO Employment VALUES
(2,2,'Infosys','System Engineer',40000);

INSERT INTO Employment VALUES
(3,3,'Wipro','Developer',42000);

COMMIT;


/* ==========================================
   VIEW
   ========================================== */

CREATE OR REPLACE VIEW PersonDetails AS
SELECT
    p.PersonID,
    p.FirstName,
    p.LastName,
    a.City,
    e.Qualification,
    em.CompanyName
FROM Persons p
JOIN Addresses a
ON p.PersonID = a.PersonID
JOIN Education e
ON p.PersonID = e.PersonID
JOIN Employment em
ON p.PersonID = em.PersonID;


/* ==========================================
   PROCEDURE
   ========================================== */

CREATE OR REPLACE PROCEDURE GetPersonInfo
(
    p_id IN NUMBER
)
AS
BEGIN
    FOR rec IN
    (
        SELECT *
        FROM Persons
        WHERE PersonID = p_id
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            rec.FirstName || ' ' ||
            rec.LastName
        );
    END LOOP;
END;
/


/* ==========================================
   FUNCTION
   ========================================== */

CREATE OR REPLACE FUNCTION GetSalary
(
    p_id NUMBER
)
RETURN NUMBER
IS
    sal NUMBER;
BEGIN
    SELECT Salary
    INTO sal
    FROM Employment
    WHERE PersonID = p_id;

    RETURN sal;
END;
/


/* ==========================================
   TRIGGER
   ========================================== */

CREATE OR REPLACE TRIGGER Salary_Check
BEFORE INSERT OR UPDATE
ON Employment
FOR EACH ROW
BEGIN
    IF :NEW.Salary <= 0 THEN
        RAISE_APPLICATION_ERROR(
        -20001,
        'Salary must be greater than zero');
    END IF;
END;
/


/* ==========================================
   QUERY 1 : DISPLAY ALL PERSONS
   ========================================== */

SELECT * FROM Persons;

/*
OUTPUT:

PERSONID FIRSTNAME LASTNAME   GENDER   DOB        PHONE       EMAIL
-------- --------- ---------- -------- ---------- ----------- -------------------
1        Arun      Kumar      Male     15-MAY-00  9876543210  arun@gmail.com
2        Divya     Rani       Female   20-AUG-99  9876543211  divya@gmail.com
3        Rahul     Sharma     Male     10-JAN-98  9876543212  rahul@gmail.com
*/


/* ==========================================
   QUERY 2 : DISPLAY ALL ADDRESSES
   ========================================== */

SELECT * FROM Addresses;

/*
OUTPUT:

ADDRESSID PERSONID STREET       CITY       STATE         PINCODE
--------- -------- ------------ ---------- ------------- -------
1         1        Anna Nagar   Chennai    Tamil Nadu    600040
2         2        RS Puram     Coimbatore Tamil Nadu    641002
3         3        KK Nagar     Madurai    Tamil Nadu    625020
*/


/* ==========================================
   QUERY 3 : DISPLAY ALL EDUCATION DETAILS
   ========================================== */

SELECT * FROM Education;

/*
OUTPUT:

EDUCATIONID PERSONID QUALIFICATION INSTITUTION
----------- -------- ------------ -------------------------
1           1        B.E CSE      Anna University
2           2        B.Sc IT      Bharathiar University
3           3        MCA          Madurai Kamaraj University

YEAROFPASSING
-------------
2021
2020
2022
*/


/* ==========================================
   QUERY 4 : DISPLAY ALL EMPLOYMENT DETAILS
   ========================================== */

SELECT * FROM Employment;

/*
OUTPUT:

EMPLOYEEID PERSONID COMPANYNAME DESIGNATION          SALARY
---------- -------- ----------- -------------------- ------
1          1        TCS         Software Engineer    45000
2          2        Infosys     System Engineer      40000
3          3        Wipro       Developer            42000
*/


/* ==========================================
   QUERY 5 : DISPLAY NAME AND PHONE
   ========================================== */

SELECT FirstName, LastName, Phone
FROM Persons;

/*
OUTPUT:

FIRSTNAME  LASTNAME  PHONE
---------- --------- ----------
Arun       Kumar     9876543210
Divya      Rani      9876543211
Rahul      Sharma    9876543212
*/


/* ==========================================
   QUERY 6 : DISPLAY PERSON AND CITY
   ========================================== */

SELECT FirstName, City
FROM Persons p
JOIN Addresses a
ON p.PersonID = a.PersonID;

/*
OUTPUT:

FIRSTNAME  CITY
---------- ----------
Arun       Chennai
Divya      Coimbatore
Rahul      Madurai
*/


/* ==========================================
   QUERY 7 : DISPLAY PERSON AND QUALIFICATION
   ========================================== */

SELECT FirstName, Qualification
FROM Persons p
JOIN Education e
ON p.PersonID = e.PersonID;

/*
OUTPUT:

FIRSTNAME  QUALIFICATION
---------- ----------------
Arun       B.E CSE
Divya      B.Sc IT
Rahul      MCA
*/


/* ==========================================
   QUERY 8 : DISPLAY PERSON AND SALARY
   ========================================== */

SELECT FirstName, Salary
FROM Persons p
JOIN Employment e
ON p.PersonID = e.PersonID;

/*
OUTPUT:

FIRSTNAME  SALARY
---------- ------
Arun       45000
Divya      40000
Rahul      42000
*/


/* ==========================================
   QUERY 9 : CALL FUNCTION
   ========================================== */

SELECT GetSalary(1)
FROM Dual;

/*
OUTPUT:

GETSALARY(1)
------------
45000
*/


/* ==========================================
   QUERY 10 : DISPLAY PERSON DETAILS VIEW
   ========================================== */

SELECT * FROM PersonDetails;

/*
OUTPUT:

PERSONID FIRSTNAME LASTNAME CITY       QUALIFICATION COMPANYNAME
-------- --------- -------- ---------- ------------- -----------
1        Arun      Kumar    Chennai    B.E CSE       TCS
2        Divya     Rani     Coimbatore B.Sc IT       Infosys
3        Rahul     Sharma   Madurai    MCA           Wipro
*/


/* ==========================================
   PROCEDURE TEST
   ========================================== */

EXEC GetPersonInfo(1);

/*
OUTPUT:

Arun Kumar
*/


/* ==========================================
   TRIGGER TEST
   ========================================== */

/*
The following statement tests the trigger.

If salary is zero or negative, Oracle will display:

ORA-20001: Salary must be greater than zero
ORA-06512: at "SALARY_CHECK", line ...

Do NOT execute this test if you do not want an error
message in your final output.

Example:

INSERT INTO Employment
VALUES (4,1,'ABC Company','Tester',0);
*/


/* ==========================================
   FINAL TABLE VERIFICATION
   ========================================== */

SELECT * FROM Persons;
SELECT * FROM Addresses;
SELECT * FROM Education;
SELECT * FROM Employment;
SELECT * FROM PersonDetails;


/* ==========================================
   END OF PERSONAL INFORMATION SYSTEM
   ========================================== */
