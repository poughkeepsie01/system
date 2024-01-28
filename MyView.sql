/* Formatted on 1/4/2024 10:24:12 AM (QP5 v5.227.12220.39754) */
CREATE TABLE mytest
(
   time_no   NUMBER (2),
   mytime    DATE DEFAULT SYSDATE
);

DROP TABLE mytest

select * from mytest

insert into mytest(time_no)
values(2)

create view viewTime
as select * from mytest
with read only;

drop view viewtime

select * from viewTime

insert into viewTime(time_no)
values(3)

/* Formatted on 1/4/2024 9:53:29 AM (QP5 v5.227.12220.39754) */
SELECT 10 + 10 / 2 * 3 FROM DUAL;

SELECT 10 + 10 * 2 / 3 FROM DUAL;

CREATE VIEW toView
AS
   SELECT * FROM MyCustomers
   WITH READ ONLY;
   
   select * from toview

ALTER VIEW toSee     read only;

COMMIT
select * from toSee

drop view toView

insert into toView(CUSTOMER_ID,CUSTOMER_FIRSTNAME,CUSTOMER_LASTNAME)
values
(
2,
'tan',
'gaygon'
);

select * from mycustomers