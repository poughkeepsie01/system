/* Formatted on 1/10/2024 8:08:37 AM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE TRIGGER reg_to_transact_trig
   AFTER UPDATE
   ON Myrooms
   FOR EACH ROW

DECLARE

   


BEGIN

--add conditional IF pag uupdate status ng rooms
 
INSERT INTO MyTransactions (transaction_id)
        VALUES (transactions_id_seq.NEXTVAL);
         

   UPDATE MyTransactions
      SET room_id = :NEW.room_id,
          customer_id = :NEW.customer_id,
          check_in_amount = 100 * hours_staying
    WHERE  customer_id is null and room_id is null;
    DBMS_OUTPUT.put_line ('Triggered transact');
--    DBMS_OUTPUT.put_line (:NEW.customer_id || :new.room_id);


END;
/

--drop trigger reg_to_transact_trig

--when checking out just update and set to customer and room id to 'null'(string)