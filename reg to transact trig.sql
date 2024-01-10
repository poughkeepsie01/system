/* Formatted on 1/10/2024 12:59:28 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE reg_to_transact_trig(par_room_id number)
  IS
   stay_time   MYCUSTOMERS.hours_of_staying%TYPE;
   stay_price  MYROOMS.PRICE_PER_HOUR%type;
BEGIN
   --add conditional IF pag uupdate status ng rooms
   
    SELECT hours_of_staying into stay_time
        FROM mycustomers
       WHERE Room_id = par_room_id;
       
    SELECT PRICE_PER_HOUR into stay_price
        FROM MyRooms
       WHERE Room_id = par_room_id;

   UPDATE MyTransactions
      SET check_in_amount = stay_price * stay_time
    WHERE check_in_amount IS NULL;

   DBMS_OUTPUT.put_line ('Triggered transact2');
    DBMS_OUTPUT.put_line (par_room_id);
--    DBMS_OUTPUT.put_line (:NEW.customer_id || :new.room_id);

commit;
END;
/

--drop trigger reg_to_transact_trig

--when checking out just update and set to customer and room id to 'null'(string)