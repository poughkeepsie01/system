/* Formatted on 12/7/2023 7:43:22 AM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE status_update (input_user VARCHAR2)
IS
   customer_input   MYCUSTOMERS.CUSTOMER_USERNAME%TYPE := input_user;
BEGIN
   UPDATE MyCustomers
      SET status = 'Online'
    WHERE customer_username = customer_input;

   DBMS_OUTPUT.put_line (customer_input);


   COMMIT;
END;

