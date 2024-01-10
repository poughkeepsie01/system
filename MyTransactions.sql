/* Formatted on 1/9/2024 9:24:28 AM (QP5 v5.227.12220.39754) */
CREATE TABLE MyTransactions
(
   transaction_id          NUMBER (10) PRIMARY KEY,
   customer_id             NUMBER (10),
   room_id                 NUMBER (10),
   check_in_amount         NUMBER (5),
   time_extension_amount   NUMBER (5),
   total_amount            NUMBER (20),
   check_in                DATE DEFAULT SYSDATE,
   check_out               DATE,
   transaction_period      DATE DEFAULT TRUNC (SYSDATE),
   FOREIGN KEY (customer_id) REFERENCES MyCustomers (customer_id),
   FOREIGN KEY (room_id) REFERENCES MyRooms (room_id)
);

DROP TABLE  MyTransactions
drop table  MyTransactions;
DROP SEQUENCE customer_id_seq;

DROP TABLE  MyTransactions CASCADE CONSTRAINTS;

/* Formatted on 1/9/2024 9:24:36 AM (QP5 v5.227.12220.39754) */
/* Formatted on 1/9/2024 9:25:27 AM (QP5 v5.227.12220.39754) */
SELECT 
       transaction_id,
       Customer_id,
       room_id,
       check_in_amount,
       time_extension_amount,
       total_amount,
       TO_CHAR (check_in, 'HH24:MI:SS')check_in,
       TO_CHAR(check_out, 'HH24:MI:SS')check_out,
       TO_CHAR(Transaction_period, 'MON-YYYY') period
FROM  MyTransactions


TRUNCATE TABLE MyTransactions DROP STORAGE

delete from  MyTransactions


order by customer_id;
--wlang 0 sa contact number kasi NUMBER 005 = 5

INSERT INTO MyTransactions (transaction_id)
     VALUES (transactions_id_seq.NEXTVAL);
     
     INSERT INTO MyTransactions (transaction_id, customer_id)
        VALUES (transactions_id_seq.NEXTVAL, :NEW.customer_id );

DELETE FROM MyTransactions commit;


ALTER TABLE  MyTransactions
ADD status VARCHAR2(10) DEFAULT 'logged out'
update  MyTransactions
set status = 'logged in'
where customer_username = 'gerbal'

alter table  MyTransactions
drop column status

delete * from  MyTransactions
where customer_id > 20

select * from  MyTransactions
where length(contact_number) = 10;