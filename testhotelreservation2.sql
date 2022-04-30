USE hotelreservation;
GO

-- Visar att det finns mockdata i alla tabeller:
SELECT * FROM payment_data;
SELECT * FROM guest;
SELECT * FROM room_type;
SELECT * FROM room;
SELECT * FROM communication;
SELECT * FROM payment;
SELECT * FROM discount;
SELECT * FROM reservation;
GO
 
 
-- STORED PROCEDURES
EXEC upcoming_reservations_2022;
GO
 
EXEC search_reservation_by_last_name @name = 'Kirkwood';
GO
 
EXEC search_reservation_between_dates @firstdate = '2022-05-05', @seconddate = '2022-05-06';
GO
 
EXEC payment_methods_used;
GO
 
-- Testdata som uppdaterar rumspriserna och sen ändrar tillbaka dom igen med proc update_room_price
EXEC update_room_price @single = 2000, @double = 2500, @family = 3500;
GO
SELECT * FROM room_type;
GO
EXEC update_room_price @single = 1000, @double = 1500, @family = 2500;
GO
SELECT * FROM room_type;
GO
 
-- Testdata som visar att både med och utan rabatt fungerar med proc update_total_price
UPDATE reservation SET total_price = 0 WHERE id = 1;
UPDATE reservation SET total_price = 0 WHERE id = 2;
GO
SELECT * FROM reservation;
GO
EXEC update_total_price @reservationid = 1;
EXEC update_total_price @reservationid = 2;
GO
SELECT * FROM reservation; 
GO
 
EXEC count_reservations_extrabed @startdate = '2022-01-01', @enddate = '2022-12-31'
GO
 
 
-- VIEWS
SELECT * FROM reservation_per_guest;
SELECT * FROM reservations_not_paid;
SELECT * FROM reservations_paid;
SELECT * FROM reservations_with_discount;
SELECT * FROM reservations_late_arrival;
SELECT * FROM avg_rating_january;
SELECT * FROM guest_info;
SELECT * FROM reservations_extrabed;
SELECT * FROM discount_BlackFriday10;
SELECT * FROM message_from_what_email;
GO
 
-- TRIGGERS
 
-- Visar att trigger set_contact_person fungerar
INSERT INTO guest (first_name,last_name,phonenumber,email,contact_person) VALUES ('Kalle', 'Svensson', '474 952 0000', 'kallesvens@gmail.com', null);
SELECT * FROM guest;
GO
-- Visar att det går att ändra contact_person även om gästens namn hamnar där by default
UPDATE guest
SET contact_person = 'Lars Larsson'
WHERE id = 11
SELECT * FROM guest;
GO

-- Lägger in payment_data på gäst med id 11. 
INSERT INTO payment_data VALUES ('201950560272000', 'americanexpress');
INSERT INTO payment VALUES (NULL, NULL)
UPDATE guest
SET payment_data_id = 11
WHERE id = 11; 
SELECT * FROM guest;
GO 
 
-- Visar att trigger deleted samt deleted_from_reservations fungerar
DELETE FROM reservation WHERE id = 11;
GO
SELECT * FROM reservations_deleted; 
GO
 
-- Visar att trigger set_length_of_stay fungerar
-- (Lägger in en ny reservation på guest_id 1)
INSERT INTO reservation VALUES (1, '2022-07-22 15:00:00', '2022-07-23 11:00:00',1,'Anna', 1,'2022-01-22 19:00:00',1,null,1000,null, null)
SELECT * FROM reservation;
 
