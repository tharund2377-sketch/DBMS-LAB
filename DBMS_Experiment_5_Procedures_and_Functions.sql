/* ============================================================================
   EX NO: 5
   TITLE : IMPLEMENT PL/SQL PROGRAM FOR PROCEDURES AND FUNCTION
   AIM   : To implement PL/SQL programs for procedures and functions.
   ============================================================================
   SYNTAX FOR PROCEDURE:
     CREATE OR REPLACE PROCEDURE <procedure_name>
         (<parameter1> IN/OUT <datatype>, ...) [IS | AS]
         <declaration part>
     BEGIN
         <execution part>
     EXCEPTION
         <exception handling part>
     END;

   SYNTAX FOR FUNCTION:
     CREATE OR REPLACE FUNCTION <function_name>
         (<variable_name> IN <datatype>, ...) RETURN <datatype> IS/AS
         <variable/constant declaration>
     BEGIN
         -- PL/SQL subprogram body
     EXCEPTION
         -- Exception handling block
     END <function_name>;
   ============================================================================ */


/* ----------------------------------------------------------------------------
   PROCEDURE: Sum_Numbers
   Takes two numbers IN and prints their sum.
   ---------------------------------------------------------------------------- */

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Sum_Numbers (
    a IN NUMBER,
    b IN NUMBER
) IS
    c NUMBER;
BEGIN
    c := a + b;
    DBMS_OUTPUT.PUT_LINE('Sum of two nos = ' || c);
END Sum_Numbers;
/

-- Calling the procedure
BEGIN
    Sum_Numbers(10, 20);
END;
/
/* OUTPUT:
Sum of two nos = 30
*/


/* ----------------------------------------------------------------------------
   FUNCTION: Sum_Function
   Takes two numbers IN and RETURNS their sum.
   ---------------------------------------------------------------------------- */

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION Sum_Function (
    a IN NUMBER,
    b IN NUMBER
) RETURN NUMBER
IS
    c NUMBER;
BEGIN
    c := a + b;
    RETURN c;
END Sum_Function;
/

-- Calling the function
SET SERVEROUTPUT ON;
DECLARE
    result NUMBER;
BEGIN
    result := Sum_Function(5, 5);
    DBMS_OUTPUT.PUT_LINE('Sum of two nos = ' || result);
END;
/
/* OUTPUT:
Sum of two nos = 10
*/


/* ============================================================================
   RESULT: Thus the PL/SQL programs for procedure and function have been
   executed successfully and the output was verified.
   ============================================================================ */
