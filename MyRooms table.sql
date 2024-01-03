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
rooms_id_seq.NEXTVAL,
'evrg',
'ercgw'
);

delete from MyRooms 

commit;


alter table MyRooms
add status varchar2(10) default 'logged out'

update MyRooms
set status = 'logged in'
where customer_username = 'gerbal'

alter table MyRooms
drop column status 

delete * from MyRooms
where customer_id > 20
