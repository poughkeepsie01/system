
create sequence transactions_id_seq
increment by 1
start with 1
minvalue 1
nomaxvalue
cache 20

drop sequence transactions_id_seq

---
create sequence rooms_id_seq
increment by 1
start with 1
minvalue 1
nomaxvalue
cache 20;

drop sequence rooms_id_seq

commit