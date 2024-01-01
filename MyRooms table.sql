CREATE TABLE MyRooms
(
  room_id number(10)primary key,
  customer_id number(10),
  price_per_hour number(10),
  status varchar2(10)
  
);

drop table MyRooms;

select * from MyRooms
order by customer_id asc


insert into MyRooms(customer_id, customer_firstname,customer_lastname)
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
