/* Formatted on 1/2/2024 8:18:17 PM (QP5 v5.360) */
CREATE TABLE MyTest
(
    date_id    NUMBER (10),
    mydate     DATE DEFAULT SYSDATE
);

DROP TABLE MyTest;

SELECT TO_CHAR (mydate, 'MM/DD') FROM MyTest;

INSERT INTO MyTest (date_id)
     VALUES (1);