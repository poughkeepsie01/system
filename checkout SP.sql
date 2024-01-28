/* Formatted on 1/26/2024 2:25:43 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE MYCHECKOUT (room_num NUMBER)
IS
   check_out_time               TIMESTAMP;
   check_in_time                TIMESTAMP;
   computed_time                INTERVAL DAY TO SECOND;
   rooms_in_table               MYTRANSACTIONS.ROOM_ID%TYPE;
   time_extension_computation   INTERVAL DAY TO SECOND;
   Total_amount                 MYTRANSACTIONS.TOTAL_AMOUNT%TYPE;
   extension_amount             MYTRANSACTIONS.TIME_EXTENSION_AMOUNT%TYPE;
   room_price_per_hour          MyRooms.PRICE_PER_HOUR%TYPE;
   hours_of_staying             MYCUSTOMERS.HOURS_OF_STAYING%TYPE;
   actual_check_out             TIMESTAMP;
   checkin_cost                 MYTRANSACTIONS.check_in_amount%TYPE;
   Day_to_hour                  NUMBER := 24;

   CURSOR check_room
   IS
      SELECT room_id
        FROM MyTransactions
       WHERE     Room_id = room_num
             AND check_out IS NULL
             AND transaction_status = 'On-going';

   room_not_exist               EXCEPTION;
BEGIN
   OPEN check_room;

   FETCH check_room INTO rooms_in_table;

   IF room_num = ROOMS_in_table
   THEN
      SELECT ACTUAL_CHECKOUT
        INTO actual_check_out
        FROM MYTRANSACTIONS
       WHERE Room_id = room_num;

      --comparison of check in and check out
      UPDATE Mytransactions
         SET check_out = SYSDATE
       WHERE Room_id = room_num;

      SELECT check_in
        INTO check_in_time
        FROM Mytransactions
       WHERE Room_id = room_num;

      SELECT check_out + INTERVAL '30' HOUR
        INTO check_out_time
        FROM Mytransactions
       WHERE Room_id = room_num;

      computed_time := (check_out_time - check_in_time);
      DBMS_OUTPUT.put_line ('computed time: ' || computed_time);

      --      DBMS_OUTPUT.put_line (
      --         'time in:' || TO_CHAR (check_in_time, 'HH:MI:SS'));
      --      DBMS_OUTPUT.put_line (
      --         'time out:' || TO_CHAR (check_out_time, 'HH:MI:SS'));
      --      DBMS_OUTPUT.put_line (
      --         'time diff:' || EXTRACT (HOUR FROM computed_time) || ' hours');
      --      DBMS_OUTPUT.put_line (
      --         'time diff:' || EXTRACT (MINUTE FROM computed_time) || ' minute');
      --      DBMS_OUTPUT.put_line (
      --         'time diff:' || EXTRACT (SECOND FROM computed_time) || ' seconds');
      DBMS_OUTPUT.put_line (
         'time diff:' || EXTRACT (DAY FROM computed_time) || ' seconds');


      time_extension_computation := (check_out_time - actual_check_out);

      SELECT PRICE_PER_HOUR
        INTO room_price_per_hour
        FROM MyRooms
       WHERE Room_id = room_num;

      SELECT HOURS_OF_STAYING
        INTO hours_of_staying
        FROM MyCustomers
       WHERE Room_id = room_num;



      IF EXTRACT (HOUR FROM time_extension_computation) <= 0
      THEN
         DBMS_OUTPUT.put_line ('negative');
      ELSE
         UPDATE MyTransactions                                           --100
            SET TIME_EXTENSION_AMOUNT =
                     TIME_EXTENSION_AMOUNT
                   +   room_price_per_hour
                     * EXTRACT (HOUR FROM time_extension_computation)
          WHERE Room_id = room_num;
      END IF;


      SELECT check_in_amount
        INTO checkin_cost
        FROM MyTransactions
       WHERE Room_id = room_num;

      UPDATE MyTransactions
         SET TOTAL_AMOUNT = TIME_EXTENSION_AMOUNT + checkin_cost
       WHERE Room_id = room_num;


      -- updating the 3 tables
      IF EXTRACT (DAY FROM computed_time) >= 1
      THEN
         UPDATE MyCustomers
            SET room_id = NULL,
                Hours_of_staying =
                     EXTRACT (HOUR FROM computed_time)
                   + Day_to_hour * EXTRACT (DAY FROM computed_time)
          WHERE Room_id = room_num;
      ELSE
         UPDATE MyCustomers
            SET room_id = NULL,
                Hours_of_staying = EXTRACT (HOUR FROM computed_time)
          WHERE Room_id = room_num;
      END IF;

      UPDATE MyRooms
         SET customer_id = NULL, status = 'For Cleaning'
       WHERE Room_id = room_num;

      UPDATE Mytransactions
         SET transaction_status = 'Finished', room_id = NULL
       WHERE Room_id = room_num;

      COMMIT;
   ELSE
      RAISE room_not_exist;
   END IF;
EXCEPTION
   WHEN room_not_exist
   THEN
      DBMS_OUTPUT.put_line (room_num);
      RAISE_APPLICATION_ERROR (
         -20000,
         'You can not check out the room while available/for cleaning');
END;

EXECUTE mycheckout('&roomNo.')
-- compile muna pag binago interval