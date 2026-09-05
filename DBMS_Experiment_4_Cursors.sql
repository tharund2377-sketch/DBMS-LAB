/* ============================================================================
   EX NO: 4
   TITLE : CREATE PL/SQL PROGRAM FOR IMPLICIT AND EXPLICIT CURSORS
   AIM   : To implement implicit and explicit cursor programs in SQL.
   ============================================================================
   INTRODUCTION
   ------------
   A cursor is a pointer to a private SQL work area (context area).
   PL/SQL controls this context area through a cursor. A cursor holds
   the row(s) returned by a SQL statement; the set of rows the cursor
   holds is called the "active set".

   TYPES OF CURSORS
   ----------------
   1. Implicit cursors - automatically created by Oracle for every DML
      statement (INSERT/UPDATE/DELETE/SELECT INTO) when no explicit
      cursor is declared. Cannot be controlled by the programmer.

        Attribute    | Description
        -------------+----------------------------------------------------
        %FOUND       | TRUE if INSERT/UPDATE/DELETE affected >=1 row, or
                      | SELECT INTO returned >=1 row. Else FALSE.
        %NOTFOUND    | Logical opposite of %FOUND.
        %ISOPEN      | Always FALSE for implicit cursors (Oracle closes
                      | the SQL cursor automatically after execution).
        %ROWCOUNT    | Number of rows affected/returned.

   2. Explicit cursors - programmer-defined, declared for SELECT
      statements that may return more than one row.
        Steps: (1) Declare (2) Open (3) Fetch (4) Close
   ============================================================================ */


/* ----------------------------------------------------------------------------
   TABLE CREATION AND SAMPLE DATA
   ---------------------------------------------------------------------------- */

CREATE TABLE customers (
    id      INT PRIMARY KEY,
    name    VARCHAR(50),
    address VARCHAR(100),
    salary  DECIMAL(10,2)
);

INSERT INTO customers (id, name, address, salary) VALUES
(1, 'John',  'New York',    5000.00),
(2, 'Alice', 'Los Angeles', 6000.00),
(3, 'Bob',   'Chicago',     4500.00),
(4, 'David', 'Houston',     7000.00),
(5, 'Emma',  'Boston',      5500.00);


/* ----------------------------------------------------------------------------
   IMPLICIT CURSOR EXAMPLE
   Uses the implicit SQL cursor's %FOUND / %NOTFOUND / %ROWCOUNT
   attributes after a bulk UPDATE.
   ---------------------------------------------------------------------------- */

SET SERVEROUTPUT ON;

DECLARE
    total_rows NUMBER(2);
BEGIN
    UPDATE customers
    SET salary = salary + 500;

    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('no customers selected');
    ELSIF SQL%FOUND THEN
        total_rows := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE(total_rows || ' customers selected ');
    END IF;
END;
/
/* OUTPUT:
5 customers selected

PL/SQL procedure successfully completed.
*/


/* ----------------------------------------------------------------------------
   EXPLICIT CURSOR EXAMPLE
   Declares a cursor over a multi-row SELECT, then opens, fetches in a
   loop, and closes it.
   ---------------------------------------------------------------------------- */

SET SERVEROUTPUT ON;

DECLARE
    c_id      customers.id%TYPE;
    c_name    customers.name%TYPE;
    c_addr    customers.address%TYPE;
    CURSOR c_customers IS
        SELECT id, name, address FROM customers;
BEGIN
    OPEN c_customers;
    LOOP
        FETCH c_customers INTO c_id, c_name, c_addr;
        EXIT WHEN c_customers%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(c_id || ' ' || c_name || ' ' || c_addr);
    END LOOP;
    CLOSE c_customers;
END;
/
/* OUTPUT:
ID | NAME  | ADDRESS
---+-------+------------
1  | John  | New York
2  | Alice | Los Angeles
3  | Bob   | Chicago
4  | David | Houston
5  | Emma  | Boston
*/


/* ============================================================================
   RESULT: Thus the program for implicit and explicit cursors in SQL has
   been executed successfully and the output was verified.
   ============================================================================ */
