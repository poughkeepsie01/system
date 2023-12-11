/* Formatted on 12/6/2023 2:59:29 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE login (login_username    VARCHAR2,
                                   login_password    VARCHAR2)
IS
   username       MYCUSTOMERS.CUSTOMER_USERNAME%TYPE;
   userpassword   MYCUSTOMERS.CUSTOMER_PASSWORD%TYPE;
   

   CURSOR account
   IS
      SELECT customer_username, customer_password
        FROM MyCustomers
       WHERE customer_username = login_username;


   INVALID        EXCEPTION;
BEGIN
   OPEN account;

   FETCH account
      INTO username, userpassword;

   IF username = login_username AND userpassword = login_password
   THEN
      status_update(username);
      DBMS_OUTPUT.put_line ('u are logged in');
   ELSE
      RAISE INVALID;
   END IF;

   CLOSE account;
EXCEPTION
   WHEN INVALID
   THEN
      DBMS_OUTPUT.put_line ('incorrect input or register first');
END;

--execute login(&inputUsername, &inputPass)


