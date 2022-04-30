 
CREATE DATABASE hotelreservation;
GO
USE hotelreservation;
GO
 
CREATE TABLE payment_data(
id INT IDENTITY PRIMARY KEY,
credit_card_nr NCHAR(20),
credit_card_type NVARCHAR(20),
);
GO
 
CREATE TABLE guest(
 id INT IDENTITY PRIMARY KEY,
 first_name NVARCHAR(50),
 last_name NVARCHAR(50),
 phonenumber NVARCHAR(50),
 email NVARCHAR(50),
 contact_person NVARCHAR(50),
 payment_data_id INT FOREIGN KEY REFERENCES payment_data(id)
);
GO
 
CREATE TABLE room_type(
id INT IDENTITY PRIMARY KEY,
room_name VARCHAR(50),
price DECIMAL,
);
GO
 
CREATE TABLE room(
id INT IDENTITY PRIMARY KEY,
room_type_id INT FOREIGN KEY REFERENCES room_type(id),
nr_of_guests INT,
extrabed INT CHECK(extrabed BETWEEN 1 AND 1) 
);
GO
 
CREATE TABLE communication(
 id INT IDENTITY PRIMARY KEY,
 guest_id INT FOREIGN KEY REFERENCES guest(id),
 guest_comments NVARCHAR(1000),
 hotel_message NVARCHAR(1000),
 rating INT CHECK(rating BETWEEN 0 AND 5),
 contact_person NVARCHAR(100)
);
GO
 
CREATE TABLE payment(
id INT IDENTITY PRIMARY KEY,
payment_method NVARCHAR(20),
status DATETIME,
);
GO
 
CREATE TABLE discount(
id INT IDENTITY PRIMARY KEY,
discount_code NVARCHAR(20),
discount_percentage DECIMAL,
);
GO
 
 
CREATE TABLE reservation(
id INT IDENTITY PRIMARY KEY,
guest_id INT FOREIGN KEY REFERENCES guest(id),
check_in DATETIME,
check_out DATETIME,
total_guests INT,
hotel_contact NVARCHAR(100),
payment_id INT FOREIGN KEY REFERENCES payment(id),
late_arrival DATETIME,
room_id INT FOREIGN KEY REFERENCES room(id), 
no_arrival NVARCHAR(20), -- om ingen ankomst skriv i no arrival
total_price DECIMAL,
discount_id INT FOREIGN KEY REFERENCES discount(id),
nbr_nights INT
);
GO
 
 
 
CREATE TRIGGER deletedmessage
ON reservation
FOR delete
AS
PRINT 'DELETED!'
GO
 
CREATE TRIGGER set_contact_person
ON guest
AFTER  INSERT
NOT FOR REPLICATION
AS
BEGIN
  DECLARE
  @id INT,
  @first NVARCHAR(50),
  @last NVARCHAR(50)
  SELECT @id = INSERTED.id,
  @first= INSERTED.first_name,
  @last = INSERTED.last_name
  FROM INSERTED
  UPDATE guest SET contact_person = CONCAT(CONCAT(@first, ' '),@last) WHERE id = @id
END
GO
 
 
CREATE TRIGGER set_length_of_stay
ON reservation
AFTER  INSERT
NOT FOR REPLICATION
AS
BEGIN
 DECLARE
 @id INT,
 @check_in DATETIME,
 @check_out DATETIME
 SELECT @id = INSERTED.id,
 @check_in= INSERTED.check_in,
 @check_out = INSERTED.check_out
 FROM INSERTED
 UPDATE reservation SET nbr_nights = DATEDIFF(DAY, @check_in, @check_out) WHERE id = @id
END
GO
 
 
CREATE VIEW reservation_per_guest
AS
SELECT g.first_name, g.last_name, COUNT(r.id) AS 'Nr of reservations per registered guest'
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
GROUP BY g.first_name, g.last_name
GO
 
CREATE VIEW reservations_not_paid
AS
SELECT g.first_name, g.last_name, r.check_in, r.check_out, p.status AS 'Paymentstatus'
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
INNER JOIN payment p
ON r.payment_id = p.id
WHERE p.status IS NULL
GO
 
CREATE VIEW reservations_paid
AS
SELECT g.first_name, g.last_name, r.check_in, r.check_out, p.status AS 'Date of payment'
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
INNER JOIN payment p
ON r.payment_id = p.id
WHERE p.status IS NOT NULL
GO
 
 
CREATE VIEW reservations_with_discount
AS
SELECT g.first_name, g.last_name, r.check_in, r.check_out, d.discount_code, d.discount_percentage
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
INNER JOIN discount d
ON r.discount_id = d.id
WHERE discount_id IS NOT NULL
GO
 
CREATE VIEW reservations_late_arrival
AS
SELECT g.first_name, g.last_name, r.check_in, r.check_out, r.late_arrival
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
WHERE late_arrival IS NOT NULL
GO
 
-- OBS visar rating i heltal
CREATE VIEW avg_rating_january
AS
SELECT AVG(rating) AS 'Average rating for reservations in January'
FROM communication c
INNER JOIN reservation r
ON c.guest_id = r.guest_id
WHERE r.check_in BETWEEN '2022-01-01' AND '2022-01-31';
GO
 
CREATE VIEW guest_info
AS
SELECT g.first_name, g.last_name, g.phonenumber, g.email, p.credit_card_type, p.credit_card_nr
FROM guest g
INNER JOIN payment_data p
ON g.payment_data_id = p.id
GO
 
CREATE VIEW reservations_extrabed
AS
SELECT g.first_name, g.last_name, r.check_in, r.check_out, ro.extrabed
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
INNER JOIN room ro
ON r.room_id = ro.id
WHERE extrabed IS NOT NULL
GO
 
CREATE VIEW discount_BlackFriday10
AS
SELECT d.discount_code, r.discount_id
FROM discount d
JOIN reservation r
ON d.id = r.discount_id
WHERE d.discount_code = 'BlackFriday10'
GO
 
CREATE VIEW message_from_what_email
AS
SELECT c.hotel_message, g.email
FROM communication c
INNER JOIN guest g
ON c.guest_id = g.id
Where hotel_message IS NOT NULL
GO
 
 
CREATE PROC upcoming_reservations_2022
AS
SELECT COUNT(*) AS 'Nr of upcoming reservations in 2022'
FROM reservation
WHERE check_in BETWEEN CURRENT_TIMESTAMP AND '2022-12-31';
GO
 
 
-- Visar reservationer genom att söka på efternamn.
CREATE PROC search_reservation_by_last_name @name NVARCHAR(20)
AS
SELECT g.first_name, g.last_name, r.check_in, r.check_out, rt.room_name, r.total_guests, r.total_price
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
INNER JOIN room ro
ON r.room_id = ro.id
INNER JOIN room_type rt
ON ro.room_type_id = rt.id
WHERE g.last_name = @name;
GO
 
 
-- Visar reservationer som har check in mellan två datum
CREATE PROC search_reservation_between_dates @firstdate DATETIME, @seconddate DATETIME
AS
SELECT g.first_name, g.last_name, r.check_in, r.check_out
FROM guest g
INNER JOIN reservation r
ON g.id = r.guest_id
WHERE r.check_in BETWEEN @firstdate AND @seconddate
GO
 
 
 
-- Visar och räknar ut hur många gånger respektive betalsätt används
CREATE PROC payment_methods_used
AS
SELECT 'Card used' = (SELECT COUNT(*) FROM payment WHERE payment_method = 'card'),
'Cash used' = (SELECT COUNT(*) FROM payment WHERE payment_method = 'cash'),
'Invoice used' = (SELECT COUNT(*) FROM payment WHERE payment_method = 'invoice')
GO
 
 
 
CREATE PROC update_room_price @single DECIMAL, @double DECIMAL, @family DECIMAL
AS
BEGIN
   UPDATE room_type
   SET price = @single WHERE id = 1;
END
BEGIN
   UPDATE room_type
   SET price = @double WHERE id = 2
END
BEGIN
   UPDATE room_type
   SET price = @family WHERE id = 3
END
GO
 
 
-- Uppdatera total_price i reservation, tar priset minus rabatten alltså vad priset är när rabatten är avdragen. Om ingen rabatt finns tar den hela rumspriset.
CREATE OR ALTER PROC update_total_price @reservationid INT
AS
IF (SELECT discount_id FROM reservation WHERE id = @reservationid) IS NOT NULL
   UPDATE reservation
       SET total_price =
                   (SELECT price -
                   (SELECT price *
                   (SELECT discount_percentage/100 FROM discount d WHERE d.id IN(SELECT discount_id FROM reservation))
                   FROM room_type rt WHERE rt.id IN (SELECT room_type_id
                   FROM room WHERE rt.id = rt2.id))
                   FROM room_type rt2 WHERE rt2.id IN (SELECT room_type_id FROM room WHERE id = @reservationid)) 
   WHERE id = @reservationid;
ELSE
   UPDATE reservation
       SET total_price = (SELECT price FROM room_type rt WHERE rt.id IN(SELECT room_type_id FROM room WHERE id = @reservationid))
   WHERE id = @reservationid;
GO
 
 
CREATE PROCEDURE count_reservations_extrabed @startdate DATETIME, @enddate DATETIME
AS
SELECT COUNT(*) AS 'Nr of reservations with extrabeds '
FROM reservation r
INNER JOIN room ro
ON r.room_id = ro.id
WHERE check_in BETWEEN @startdate AND @enddate AND ro.extrabed IS NOT NULL;
GO

CREATE TABLE reservations_deleted(
id INT IDENTITY PRIMARY KEY,
guest_id INT FOREIGN KEY REFERENCES guest(id),
check_in DATETIME,
check_out DATETIME,
total_guests INT,
hotel_contact NVARCHAR(100),
payment_id INT,
late_arrival DATETIME,
room_id INT, 
no_arrival NVARCHAR(20), 
total_price DECIMAL,
discount_id INT,
nbr_nights INT,
date_deleted DATETIME DEFAULT GETDATE(),
);
GO

CREATE TRIGGER deleted_from_reservations
ON reservation
FOR DELETE
AS
BEGIN
INSERT INTO reservations_deleted(guest_id, check_in,check_out, total_guests, hotel_contact, payment_id, late_arrival, room_id, no_arrival, total_price, discount_id, nbr_nights)
SELECT d.guest_id, d.check_in, d.check_out, d.total_guests, d.hotel_contact, d.payment_id, d.late_arrival, d.room_id, d.no_arrival, d.total_price, d.discount_id, d.nbr_nights
FROM deleted AS d; 
END
GO 
 
 
USE master;
GO
CREATE LOGIN hoteladmin WITH PASSWORD = 'P@ssw0rd';
GO
CREATE LOGIN employee WITH PASSWORD = 'P@ssw0rd1';
GO
CREATE LOGIN hoteluser WITH PASSWORD = 'P@ssw0rd2';
GO
USE hotelreservation;
GO
CREATE USER hoteladmin FOR LOGIN hoteladmin;
GO
CREATE USER employee FOR LOGIN employee;
GO
CREATE USER hoteluser FOR LOGIN hoteluser;
GO

-- Behörighetsnivåer
GRANT CONTROL TO hoteladmin;
GO
GRANT INSERT, UPDATE, SELECT TO employee;
GO
GRANT SELECT TO hoteluser;
GO
