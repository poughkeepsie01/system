CREATE TABLE MyHistory
(
 history_id number(10) primary Key,
   transaction_id number(10),
  customer_id number(10),
  room_id number(10),
  transaction_period DATE DEFAULT TRUNC(SYSDATE),
  foreign key(transaction_id) references MyTransactions(transaction_id)
);