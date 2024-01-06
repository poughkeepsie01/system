/* Formatted on 1/6/2024 10:50:35 PM (QP5 v5.360) */
CREATE OR REPLACE PROCEDURE VIEWROOMS
IS
    view_room_id          MYROOMS.ROOM_ID%TYPE;
    view_room_type        MYROOMS.ROOM_TYPE%TYPE;
    view_price_per_hour   MYROOMS.PRICE_PER_HOUR%TYPE;

    CURSOR rooms IS
          SELECT room_id, room_type, price_per_hour
            FROM MYROOMS
           WHERE status = 'available'
        ORDER BY room_id;
BEGIN
    OPEN rooms;

    DBMS_OUTPUT.put_line ('AVAILABLE ROOMS:');

    LOOP
        FETCH rooms INTO view_room_id, view_room_type, view_price_per_hour;

        EXIT WHEN rooms%NOTFOUND;
        DBMS_OUTPUT.put_line (
               view_room_id
            || ' '
            || view_room_type
            || ' '
            || view_price_per_hour);
    END LOOP;

    CLOSE rooms;
END;

EXECUTE viewrooms;