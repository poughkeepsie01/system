/* Formatted on 1/9/2024 11:29:29 AM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE register_user (par_firstname            VARCHAR2,
                                           par_middlename           VARCHAR2,
                                           par_lastname             VARCHAR2,
                                           par_contact_number       VARCHAR2,
                                           par_rooms                NUMBER,
                                           par_hours_of_staying     NUMBER,
                                           par_confiscated_items    VARCHAR2)
IS
   --    reg_customer_id          MYCUSTOMERS.CUSTOMER_ID%TYPE;
   reg_customer_firstname    MYCUSTOMERS.CUSTOMER_FIRSTNAME%TYPE;
   reg_customer_lastname     MYCUSTOMERS.CUSTOMER_LASTNAME%TYPE;
   reg_customer_middlename   MYCUSTOMERS.CUSTOMER_middlename%TYPE;
   reg_contact_number        MYCUSTOMERS.CONTACT_NUMBER%TYPE;
   reg_room                  MYCUSTOMERS.ROOM_ID%TYPE;
   reg_hours_of_staying      MYCUSTOMERS.hours_of_staying%TYPE;
   reg_confiscated_items     MYCUSTOMERS.CONFISCATED_ITEMS%TYPE;


   max_rooms                 NUMBER (3) := 10;
   min_rooms                 NUMBER (3) := 1;
   contact_num_format        NUMBER (15) := 11;
   time_fib                  NUMBER(10) := 0;


   CURSOR room_checker
   IS
      SELECT room_id
        FROM MyCustomers
       WHERE room_id = par_rooms; --if existing na sa customer table yung room number na ininput mag-error

   CURSOR number_checker
   IS
      SELECT contact_number,
             customer_firstname,
             customer_lastname,
             customer_middlename
        FROM MyCustomers
       WHERE contact_number = par_contact_number;

   occupied_room             EXCEPTION;
   already_exist             EXCEPTION;
   contact_error             EXCEPTION;
   room_not_exist            EXCEPTION;
   contact_exist             EXCEPTION;
   invalid_time_staying      EXCEPTION;
BEGIN
   OPEN room_checker;

   FETCH room_checker INTO reg_room;

   OPEN number_checker;

   FETCH number_checker
      INTO reg_contact_number,
           reg_customer_firstname,
           reg_customer_lastname,
           reg_customer_middlename;

    
   IF par_firstname is null or par_lastname is null or par_contact_number is null or par_rooms is null or par_hours_of_staying is null
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Lack of important input');
   ElSIF reg_room = par_rooms
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Room is Occupied'); --RAISE occupied_room;
   ELSIF LENGTH (par_contact_number) != contact_num_format
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Contact No. must be 11 digits'); --RAISE contact_error;
   ELSIF par_rooms NOT BETWEEN min_rooms AND max_rooms
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Room does not exist'); --RAISE room_not_exist;
   ELSIF reg_contact_number = par_contact_number
   THEN
      RAISE_APPLICATION_ERROR (
         -20000,
            'The number '
         || reg_contact_number
         || ' is already exist for '
         || reg_customer_firstname
         || ' '
         || reg_customer_lastname
         || ' '
         || reg_customer_middlename);                  -- RAISE contact_exist;
   ELSIF par_hours_of_staying NOT IN (3, 6, 9, 12, 15, 24)
   THEN
      RAISE_APPLICATION_ERROR (
         -20000,
         'Time of staying is invalid, must be count by 3'); --      RAISE invalid_time_staying;
   ELSE
      DBMS_OUTPUT.put_line ('inserted successfully');
      INSERT INTO MyCustomers (customer_id,
                               customer_firstname,
                               customer_middlename,
                               customer_lastname,
                               contact_number,
                               room_id,
                               hours_of_staying,
                               confiscated_items)
           VALUES (customer_id_seq.NEXTVAL,
                   par_firstname,
                   par_middlename,
                   par_lastname,
                   par_contact_number,
                   par_rooms,
                   par_hours_of_staying,
                   par_confiscated_items);
      
      reg_to_transact_trig(par_rooms);
      COMMIT;
   END IF;
EXCEPTION
   WHEN occupied_room
   THEN
      DBMS_OUTPUT.put_line ('Room is taken');
   WHEN contact_error
   THEN
      DBMS_OUTPUT.put_line ('Invalid contact info');
   WHEN room_not_exist
   THEN
      DBMS_OUTPUT.put_line ('Room does not exist');
   WHEN contact_exist
   THEN
      DBMS_OUTPUT.put_line (
            'The number '
         || reg_contact_number
         || ' is already exist for '
         || reg_customer_firstname
         || ' '
         || reg_customer_lastname
         || ' '
         || reg_customer_middlename);
   WHEN invalid_time_staying
   THEN
      DBMS_OUTPUT.put_line ('Time of staying is invalid');
END;

--

EXECUTE register_user('&fname', '&middlename','&lname','&contactNum','&room','&hoursstaying','&confiscatedItem');