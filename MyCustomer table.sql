CREATE TABLE MyCustomers
(
  customer_id number(10)  PRIMARY KEY ,
  customer_firstname varchar2(50) NOT NULL,
  customer_lastname varchar2(50) NOT NULL,
  customer_initials varchar2(50) default ' '  ,
  transaction_event DATE DEFAULT sysdate,
  room  number(2) default 0 ,
  transaction_period DATE DEFAULT TRUNC(SYSDATE),
  credit varchar2(10) default 'cash'   
);
--when they checked out, the room will be null, and if the count of room is = 10 then the error is hotel is full
drop table MyCustomers

select * from MyCustomers
order by customer_id asc


insert into MyCustomers(customer_id, customer_firstname,customer_lastname)
values 
(
customer_id_seq.NEXTVAL,
'evrg',
'ercgw'
);

delete from MyCustomers 

commit;


alter table MyCustomers
add status varchar2(10) default 'logged out'

update MyCustomers
set status = 'logged in'
where customer_username = 'gerbal'

alter table MyCustomers
drop column status 

delete * from MyCustomers
where customer_id > 20
