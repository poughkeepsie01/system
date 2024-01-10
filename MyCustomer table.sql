CREATE TABLE MyCustomers
(
  customer_id number(10)  PRIMARY KEY ,
  customer_firstname varchar2(50),
  customer_lastname varchar2(50),
  customer_middlename varchar2(50) default ' ',
  contact_number varchar(20), 
  room_id number(2) default 0,
  hours_of_staying number(5),
  confiscated_items varchar2(20),
  registration_date date default sysdate
--  foreign key(room_id) references MyRooms(room_id)
)

--when they checked out, the room will be null, and if the count of room is = 10 then the error is hotel is full
drop table MyCustomers;
drop sequence customer_id_seq;

DROP TABLE mycustomers CASCADE CONSTRAINTS

select * from MyCustomers
order by room_id desc

truncate table MyCustomers CASCADE CONSTRAINTS

delete from MyCustomers

order by customer_id ;
--wlang 0 sa contact number kasi NUMBER 005 = 5

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

select * from MyCustomers
where length(contact_number) = 10;
