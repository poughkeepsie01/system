/* Formatted on 1/26/2024 10:08:36 AM (QP5 v5.227.12220.39754) */
--master file

--VIEWING AVAILABLE ROOM
EXECUTE viewrooms

--REGISTER A USER
EXECUTE register_user('&fname', '&middlename','&lname','&contactNum','&room','&hoursstaying','&confiscatedItem');

--MYCUSTOMERS TABLE
  SELECT *
    FROM MyCustomers
ORDER BY customer_id DESC

--MYROOMS TABLE
select * from MyRooms

--MYTRANSACTIONS TABLE
SELECT
       transaction_id,
       Customer_id,
       room_id,
       check_in_amount,
       time_extension_amount,
       total_amount,
       TO_CHAR (check_in, 'HH24:MI:SS DD-MON')check_in,
       TO_CHAR(check_out + + interval '30' HOUR, 'HH24:MI:SS DD-MON')check_out,  --+ interval '15' HOUR, 'HH24:MI:SS' + interval '13' HOUR
       TO_CHAR(actual_checkout , 'HH24:MI:SS DD-MON')actual_checkout,
       TO_CHAR(Transaction_period, 'DD-MON-YYYY') period,
       transaction_status
FROM  MyTransactions
order by transaction_id desc

--CHECKOUT
EXECUTE mycheckout('&roomNo.') --F5 to see receipt

--EXTEND
EXECUTE extend_time(&input_room, &input_time);

--CHANGE ROOM STATUS
EXECUTE update_room_status



select sysdate + interval '30' hour from dual