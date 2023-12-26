/* Formatted on 12/26/2023 7:59:00 PM (QP5 v5.360) */
CREATE OR REPLACE PROCEDURE register_user (par_firstname   VARCHAR2,
                                           par_initials    VARCHAR2,
                                           par_lastname    VARCHAR2,
                                           par_rooms       NUMBER,
                                           par_credits     VARCHAR2)
IS
    --    reg_customer_id          MYCUSTOMERS.CUSTOMER_ID%TYPE;
    reg_customer_firstname   MYCUSTOMERS.CUSTOMER_FIRSTNAME%TYPE;
    reg_customer_lastname    MYCUSTOMERS.CUSTOMER_LASTNAME%TYPE;
    reg_customer_initials    MYCUSTOMERS.CUSTOMER_INITIALS%TYPE;
    reg_room                 MYCUSTOMERS.ROOM%TYPE;
    reg_credit               MYCUSTOMERS.CREDIT%TYPE;


    CURSOR checker IS
        SELECT customer_firstname,
               customer_initials,
               customer_lastname,
               room,
               credit
          FROM MyCustomers;
    
     CURSOR room_checker IS
        SELECT 
               room
        
          FROM MyCustomers
          WHERE room = par_rooms;

    occupied_room            EXCEPTION;
    already_exist            EXCEPTION;
BEGIN
    OPEN checker;

    FETCH checker
        INTO reg_customer_firstname,
             reg_customer_initials,
             reg_customer_lastname,
             reg_room,
             reg_credit;
             
    OPEN room_checker;

    FETCH room_checker
        INTO 
             reg_room;
             

    DBMS_OUTPUT.put_line (reg_customer_firstname);

    IF reg_room = par_rooms
    THEN
        RAISE occupied_room;
    ELSE
        INSERT INTO MyCustomers (customer_id,
                                 customer_firstname,
                                 customer_initials,
                                 customer_lastname,
                                 room,
                                 credit)
             VALUES (customer_id_seq.NEXTVAL,
                     par_firstname,
                     par_initials,
                     par_lastname,
                     par_rooms,
                     par_credits);

        DBMS_OUTPUT.put_line ('blabla');
        COMMIT;
    END IF;
EXCEPTION
    WHEN occupied_room
    THEN
        DBMS_OUTPUT.put_line ('Room is taken');
END;

--

EXECUTE register_user('&fname', '&initials','&lname','&room','&credits');