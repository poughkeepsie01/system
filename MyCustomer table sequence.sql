
create sequence customer_id_seq
increment by 1
start with 1
minvalue 1
nomaxvalue
cache 20;

drop sequence customer_id_seq


DECLARE 

customer_id MyCustomers.CUSTOMER_ID%type;

BEGIN
select customer_id into customer_id_seq from MyCustomers ;

END;