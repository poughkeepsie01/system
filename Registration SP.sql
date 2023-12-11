/* Formatted on 12/7/2023 2:16:28 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE register_user (username    VARCHAR2,
                                           password    VARCHAR2)
IS
   reg_username    MYCUSTOMERS.CUSTOMER_USERNAME%TYPE;
   reg_password    MYCUSTOMERS.CUSTOMER_PASSWORD%TYPE;

   CURSOR checker
   IS
      SELECT customer_username, customer_password
        FROM MyCustomers
       WHERE customer_username = username;

   already_exist   EXCEPTION;
BEGIN
   OPEN checker;

   FETCH checker
      INTO reg_username, reg_password;

   DBMS_OUTPUT.put_line (username);

   IF reg_username = username
   THEN
      RAISE already_exist;
   ELSE
      INSERT
        INTO MyCustomers (customer_id, customer_username, customer_password)
      VALUES (customer_id_seq.NEXTVAL, username, password);

      DBMS_OUTPUT.put_line ('blabla');
      COMMIT;
   END IF;
EXCEPTION
   WHEN already_exist
   THEN
      DBMS_OUTPUT.put_line ('Username already exist');
END;

--

EXECUTE register_user(&userInput,&passInput);