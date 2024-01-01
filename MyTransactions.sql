CREATE TABLE MyTransactions
(
   transaction_id number(10) primary key,
  customer_id number(10),
  room_id number(10),
  total_amount number(20),
  check_in DATE DEFAULT sysdate,
  check_out DATE DEFAULT sysdate,
  transaction_period DATE DEFAULT TRUNC(SYSDATE),
  foreign key(customer_id) references MyCustomers(customer_id),
  foreign key(room_id) references MyRooms(room_id)
);

drop table MyTransactions