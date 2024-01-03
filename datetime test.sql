CREATE TABLE MyTest
(
 date_id number(10),
  mydate date default sysdate
  
);

drop table MyTest;

select to_char(mydate, 'MM/DD') from MyTest;

insert into MyTest(date_id)
values
(
1
);