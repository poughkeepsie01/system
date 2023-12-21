select 210 + 250 /2 * 3 from dual;

select 210 + 250 * 2 / 3 from dual;

create view toView AS
select * from MyCustomers
with read only;

alter view toSee read only;

commit

select * from toSee

drop view toSee

insert into toView(customer_id, customer_username, customer_password )
values 
(
3,
'sdfv',
'efgh'
);