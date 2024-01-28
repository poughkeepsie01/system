/* Formatted on 1/24/2024 3:37:44 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE extend_time (room_num           NUMBER,
                                         hours_to_extend    NUMBER)
IS
   room             MYTRANSACTIONS.room_id%TYPE;
   hoursExtension   MYTRANSACTIONS.actual_checkout%TYPE;
   status           MYTRANSACTIONS.transaction_status%TYPE;
price                MYROOMS.price_per_hour%type;
hours_stay         MYCUSTOMERS.hours_of_staying%type;
   CURSOR check_status
   IS
      SELECT transaction_status
        FROM MYTRANSACTIONS
       WHERE room_id = room_num;

   error            EXCEPTION;
BEGIN
   OPEN check_status;

   FETCH check_status INTO status;

   IF status = 'On-going'
   THEN
   --update actual checkout
--      SELECT room_id
--        INTO room
--        FROM MYTRANSACTIONS
--       WHERE room_id = room_num;

      
       
       --update total amount
       SELECT price_per_hour into price
       from myrooms 
       where status = 'occupied';
       
       SELECT hours_of_staying into hours_stay
       from mycustomers
       WHERE room_id = room_num;
       
       update Mytransactions
       set total_amount = total_amount + price * hours_to_extend,
           time_extension_amount = time_extension_amount + price * hours_to_extend
       WHERE room_id = room_num;
       
       --update actual check out
       UPDATE MYTRANSACTIONS
         SET actual_checkout =
                actual_checkout + (INTERVAL '1' HOUR) * hours_to_extend
       WHERE room_id = room_num;
       
       commit;
   ELSE
      RAISE error;
   END IF;
EXCEPTION
   WHEN error
   THEN
      RAISE_APPLICATION_ERROR (
         -20000,
         'You can not extend the room while available/for cleaning');
END;

EXECUTE extend_time(&input_room, &input_time);