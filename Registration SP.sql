/* Formatted on 1/25/2024 8:50:11 AM (QP5 v5.227.12220.39754) */
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
   reg_room_status           MYROOMS.status%TYPE;

   max_rooms                 NUMBER (3) := 10;
   min_rooms                 NUMBER (3) := 1;
   contact_num_format        NUMBER (15) := 11;
   time_fib                  NUMBER (10) := 0;
   seq                       NUMBER (2) := MOD (par_hours_of_staying, 3);


   CURSOR room_checker
   IS
      SELECT room_id
        FROM MyCustomers
       WHERE room_id = par_rooms; --if existing na sa customer table yung room number na ininput mag-error

   CURSOR room_status_checker
   IS
      SELECT status
        FROM myRooms
       WHERE room_id = par_rooms;

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
   status_not_available      EXCEPTION;
BEGIN
   OPEN room_checker;

   FETCH room_checker INTO reg_room;

   OPEN number_checker;

   OPEN room_status_checker;

   FETCH room_status_checker INTO reg_room_status;

   FETCH number_checker
      INTO reg_contact_number,
           reg_customer_firstname,
           reg_customer_lastname,
           reg_customer_middlename;


   IF    par_firstname IS NULL
      OR par_lastname IS NULL
      OR par_contact_number IS NULL
      OR par_rooms IS NULL
      OR par_hours_of_staying IS NULL
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Lack of important input');
   ELSIF reg_room = par_rooms
   THEN
      RAISE occupied_room;
   ELSIF LENGTH (par_contact_number) != contact_num_format
   THEN
      RAISE contact_error;
   ELSIF par_rooms NOT BETWEEN min_rooms AND max_rooms
   THEN
      RAISE room_not_exist;
   ELSIF reg_contact_number = par_contact_number
   THEN
      RAISE contact_exist;
   ELSIF par_hours_of_staying > 72 --par_hours_of_staying NOT IN (3, 6, 9, 12, 15, 18, 21, 24, 27,30,33, 36,39,42,45,48)
   THEN
      RAISE invalid_time_staying;
   ELSIF seq != 0 --par_hours_of_staying NOT IN (3, 6, 9, 12, 15, 18, 21, 24, 27,30,33, 36,39,42,45,48)
   THEN
      RAISE invalid_time_staying;
   ELSIF reg_room_status = 'For Cleaning'
   THEN
      RAISE status_not_available;
   ELSE
      DBMS_OUTPUT.put_line ('inserted successfully');
      DBMS_OUTPUT.put_line (seq);
      DBMS_OUTPUT.put_line (par_hours_of_staying);


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

      reg_to_transact_trig (par_rooms);
      COMMIT;
   END IF;
EXCEPTION
   WHEN occupied_room
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Room is Occupied');                 --
   WHEN contact_error
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Contact No. must be 11 digits');    --
   WHEN room_not_exist
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'Room does not exist');
   WHEN invalid_time_staying
   THEN
      RAISE_APPLICATION_ERROR (
         -20000,
         'Time of staying is invalid, must be count by 3');
   WHEN status_not_available
   THEN
      RAISE_APPLICATION_ERROR (-20000, 'The room is still for cleaning');   --
   WHEN contact_exist
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
         || reg_customer_middlename);                                       --
--
END;

--

EXECUTE register_user('&fname', '&middlename','&lname','&contactNum','&room','&hoursstaying','&confiscatedItem');