CREATE TABLE MyCustomers
(
 customer_id number(10)  PRIMARY KEY ,
  customer_username varchar2(500) UNIQUE NOT NULL,
  customer_password varchar2(500)  NOT NULL,
  date_created date default sysdate NOT NULL
   
);


select * from MyCustomers
order by customer_id asc


insert into MyCustomers(customer_id, customer_username, customer_password )
values 
(
customer_id_seq.NEXTVAL,
'sdvas',
'sdvds'
);

delete from MyCustomers 

commit;


alter table MyCustomers
add status varchar2(10) default 'logged out'

update MyCustomers
set status = 'logged in'
where customer_username = 'gerbal'



delete * from MyCustomers
where customer_id > 20
