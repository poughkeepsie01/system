select customer.customer_id, rooms.room_id  from Mycustomers customer join Myrooms rooms -- Mytransactions transacions
on customer.room_id = rooms.room_id

select customer_id from Mycustomers join Myrooms
using (customer_id)

select * from Mycustomers c join Myrooms r
using  (customer_id)
order by customer_id desc

select * from mycustomers

/* Formatted on 1/18/2024 2:58:16 PM (QP5 v5.227.12220.39754) */
/* Formatted on 1/18/2024 3:26:12 PM (QP5 v5.227.12220.39754) */
  SELECT C.customer_id,
         C.customer_firstname,
         C.CUSTOMER_LASTNAME,
         T.CHECK_IN,
         T.CHECK_OUT,
         C.HOURS_OF_STAYING,
         T.TOTAL_AMOUNT,
         T.TRANSACTION_ID,
         T.TRANSACTION_PERIOD
    FROM Mycustomers c, Mytransactions t
   WHERE     c.customer_id = T.CUSTOMER_ID
         AND transaction_status = 'Finished'
         AND TO_CHAR (t.transaction_period, 'MON-YY') = 'JAN-24'
         
         
         ORDER BY customer_id DESC

select SUM(TOTAL_AMOUNT) income_for_this_month  from MyTransactions
Where TO_CHAR (transaction_period, 'MON-YY') = 'JAN-24'
