/* Formatted on 1/8/2024 10:01:14 AM (QP5 v5.227.12220.39754) */
CREATE OR REPLACE PROCEDURE room_creator
IS
   min_room   NUMBER (2) := 1;
   mid_room number(2):= 6;
   max_room   NUMBER (2) := 10;
   i number(2);
BEGIN
   LOOP
      i := min_room;

      INSERT INTO MyRooms (room_id, room_type, price_per_hour)
           VALUES (i, 'single', '100');

      EXIT WHEN i = 5;
   END LOOP;

   --For j in 6 .. min_room LOOP
   --    INSERT into MyRooms(room_id,room_type, price_per_hour)
   --    values
   --    (
   --    j,
   --    'double',
   --    '150'
   --    );
   --End LOOP;

   COMMIT;
END;

EXECUTE room_creator;