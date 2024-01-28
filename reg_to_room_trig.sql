/* Formatted on 1/10/2024 1:20:53 PM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE TRIGGER reg_to_room_trig
   AFTER INSERT
   ON Mycustomers
   FOR EACH ROW
   
BEGIN

   UPDATE Myrooms
      SET status = 'occupied',
          customer_id = :NEW.customer_id
    WHERE ROOM_ID = :new.room_id;
   DBMS_OUTPUT.put_line ('Triggered room');
         
   
-- TRANSACTIONS TB

   INSERT INTO MyTransactions (transaction_id)
        VALUES (transactions_id_seq.NEXTVAL);

   UPDATE MyTransactions
      SET room_id = :NEW.room_id,
          customer_id = :NEW.customer_id
    WHERE customer_id IS NULL AND room_id IS NULL;

   DBMS_OUTPUT.put_line ('Triggered transact');
END;
/