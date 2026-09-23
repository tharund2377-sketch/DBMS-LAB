/* ============================================================================
   EX NO: 6
   TITLE : WRITE A PROGRAM FOR TRIGGERS
   AIM   : To write a program to create a trigger during insert, update
           and deletion of records on a table.
   ============================================================================
   ALGORITHM
   ---------
   STEP 1 : Start
   STEP 2 : Initialize the trigger with a specific table id
   STEP 3 : When the total is greater than 1000, raise an exception
   STEP 4 : Specify the operation (UPDATE / INSERT / DELETE) for which
            the trigger has to be executed
   STEP 5 : Carry out the operation on the table to check trigger
            execution
   STEP 6 : Display the action taken as a result of the above condition
   STEP 7 : Stop
   ============================================================================ */


SET SERVEROUTPUT ON;

/* ----------------------------------------------------------------------------
   RESET OBJECTS SO THE EXERCISE CAN BE RUN MORE THAN ONCE
   ---------------------------------------------------------------------------- */

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER ins_classb';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -4080 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER del_classb';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -4080 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER up_classd';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -4080 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE classb CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE customer CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

/* ----------------------------------------------------------------------------
   SUPPORTING TABLES (referenced by the triggers below)
   ---------------------------------------------------------------------------- */

CREATE TABLE customer (
    sid    NUMBER PRIMARY KEY,
    sname  VARCHAR2(50),
    stotal NUMBER
);

CREATE TABLE classb (
    sid    NUMBER PRIMARY KEY,
    sname  VARCHAR2(50),
    sdept  VARCHAR2(50),
    stotal NUMBER,
    grade  VARCHAR2(5)
);

INSERT INTO customer VALUES (1, 'Ravi', 900);
INSERT INTO customer VALUES (3, 'Kumar', 900);


/* ----------------------------------------------------------------------------
   TRIGGER ON UPDATE
   Fires BEFORE an UPDATE on "customer", printing the OLD and NEW value
   of stotal for each affected row.
   ---------------------------------------------------------------------------- */

CREATE OR REPLACE TRIGGER up_classd
BEFORE UPDATE ON customer
FOR EACH ROW
BEGIN
    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('new value is ' || :NEW.stotal);
        DBMS_OUTPUT.PUT_LINE('old value is ' || :OLD.stotal);
    END IF;
END;
/

-- Test the UPDATE trigger
UPDATE customer
SET stotal = 500
WHERE sid = 3;
/* OUTPUT:
new value is 500
old value is 900
1 row updated.
*/


/* ----------------------------------------------------------------------------
   TRIGGER ON DELETE
   Fires BEFORE a DELETE on "customer", printing a confirmation message.
   ---------------------------------------------------------------------------- */

CREATE OR REPLACE TRIGGER del_classb
BEFORE DELETE ON customer
FOR EACH ROW
BEGIN
    IF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('row deleted');
    END IF;
END;
/

-- Test the DELETE trigger
DELETE FROM customer
WHERE sid = 1;
/* OUTPUT:
row deleted
1 row deleted.
*/


/* ----------------------------------------------------------------------------
   TRIGGER ON INSERT (with validation / exception)
   Fires BEFORE an INSERT on "classb". If the new row's stotal exceeds
   1000, a user-defined exception (InvTot) is raised and reported via
   RAISE_APPLICATION_ERROR.
   ---------------------------------------------------------------------------- */

CREATE OR REPLACE TRIGGER ins_classb
BEFORE INSERT ON classb
FOR EACH ROW
DECLARE
    InvTot EXCEPTION;
BEGIN
    IF INSERTING THEN
        IF :NEW.stotal > 1000 THEN
            RAISE InvTot;
        END IF;
    END IF;
EXCEPTION
    WHEN InvTot THEN
        RAISE_APPLICATION_ERROR(-20000, 'Total not valid');
END;
/

-- Test 1: valid insert (stotal <= 1000) -> succeeds
INSERT INTO classb VALUES (1, 'John', 'IT', 900, 'A');

SELECT * FROM classb;
/* OUTPUT:
sid | sname | sdept | stotal | grade
----+-------+-------+--------+------
1   | John  | IT    | 900    | A
*/

-- Test 2: invalid insert (stotal > 1000) -> trigger blocks it
BEGIN
    INSERT INTO classb VALUES (6, 'jana', 'it', 20000, 'a');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -20000 THEN
            DBMS_OUTPUT.PUT_LINE('Invalid insert rejected: ' || SQLERRM);
        ELSE
            RAISE;
        END IF;
END;
/
/* OUTPUT:
Invalid insert rejected: ORA-20000: Total not valid
*/


/* ============================================================================
   RESULT: Thus, the programs for triggers created during insertion,
   update and deletion have been executed successfully and the output
   was verified.
   ============================================================================ */
