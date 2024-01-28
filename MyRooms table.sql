CREATE TABLE MyRooms
(
  room_id number(10)primary key,
  room_type varchar2(10),
  customer_id number(10) default null,
  price_per_hour number(10) default 100,
  status varchar2(20) default 'available',
  foreign key(customer_id) references MyCustomers(customer_id)
)

--drop table MyRooms
--
--DROP TABLE MyRooms CASCADE CONSTRAINTS

--truncate table Myrooms

select * from MyRooms;


commit


update myrooms
set status = 'available'
WHERE status = 'For Cleaning'

insert into MyRooms(room_id,room_type, price_per_hour)
values 
(
10,
'double',
150
);

delete from MyRooms 

commit;


alter table MyRooms
add status varchar2(10) default 'logged out'

update MyRooms
set status = 'logged in'
where customer_username = 'gerbal'

--alter table MyRooms
drop column status 

delete  from MyRooms
where room_id = 6

update MyRooms
set status = 'available', customer_id = null
where customer_id is not null

rollback