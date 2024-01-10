/* Formatted on 1/10/2024 8:08:32 AM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE TRIGGER reg_to_room_trig
   AFTER INSERT
   ON Mycustomers
    FOR EACH ROW

BEGIN
   DBMS_OUTPUT.put_line ('Triggered room');

   UPDATE Myrooms
      SET status = 'occupied', customer_id = :NEW.customer_id
    WHERE ROOM_ID = :new.room_id;
--DBMS_OUTPUT.put_line (:NEW.customer_id || :new.room_id);


         
  
END;
/