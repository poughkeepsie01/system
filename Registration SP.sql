/* Formatted on 1/6/2024 10:09:33 PM (QP5 v5.360) */
CREATE OR REPLACE PROCEDURE register_user (par_firstname           VARCHAR2,
                                           par_initials            VARCHAR2,
                                           par_lastname            VARCHAR2,
                                           par_contact_number      VARCHAR2,
                                           par_rooms               NUMBER,
                                           par_confiscated_items   VARCHAR2)
IS
    --    reg_customer_id          MYCUSTOMERS.CUSTOMER_ID%TYPE;
    reg_customer_firstname   MYCUSTOMERS.CUSTOMER_FIRSTNAME%TYPE;
    reg_customer_lastname    MYCUSTOMERS.CUSTOMER_LASTNAME%TYPE;
    reg_customer_initials    MYCUSTOMERS.CUSTOMER_INITIALS%TYPE;
    reg_contact_number       MYCUSTOMERS.CONTACT_NUMBER%TYPE;
    reg_room                 MYCUSTOMERS.ROOM_ID%TYPE;
    reg_confiscated_items    MYCUSTOMERS.CONFISCATED_ITEMS%TYPE;


    CURSOR checker IS
        SELECT customer_firstname,
               customer_initials,
               customer_lastname,
               contact_number,
               room_id,
               confiscated_items
          FROM MyCustomers;

    CURSOR room_checker IS
        SELECT room_id
          FROM MyCustomers
         WHERE room_id = par_rooms; --if existing na sa customer table yung room number na iniput mag-error


    occupied_room            EXCEPTION;
    already_exist            EXCEPTION;
    contact_error            EXCEPTION;
BEGIN
    OPEN checker;

    FETCH checker
        INTO reg_customer_firstname,
             reg_customer_initials,
             reg_customer_lastname,
             reg_contact_number,
             reg_room,
             reg_confiscated_items;

    OPEN room_checker;

    FETCH room_checker INTO reg_room;


    --    DBMS_OUTPUT.put_line (reg_customer_firstname);

    IF reg_room = par_rooms
    THEN
        RAISE occupied_room;
    ELSIF LENGTH (par_contact_number) != 11
    THEN
        RAISE contact_error;
    ELSE
        INSERT INTO MyCustomers (customer_id,
                                 customer_firstname,
                                 customer_initials,
                                 customer_lastname,
                                 contact_number,
                                 room_id,
                                 confiscated_items)
             VALUES (customer_id_seq.NEXTVAL,
                     par_firstname,
                     par_initials,
                     par_lastname,
                     par_contact_number,
                     par_rooms,
                     par_confiscated_items);

        DBMS_OUTPUT.put_line ('inserted succefully');
        COMMIT;
    END IF;
EXCEPTION
    WHEN occupied_room
    THEN
        DBMS_OUTPUT.put_line ('Room is taken');
    WHEN contact_error
    THEN
        DBMS_OUTPUT.put_line ('lack of contact info');
END;

--

EXECUTE register_user('&fname', '&initials','&lname','&contactNum','&room','&confiscatedItem');