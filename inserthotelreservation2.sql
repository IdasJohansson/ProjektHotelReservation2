 
USE hotelreservation;
GO
 
-- INSERTS
 
-- payment_data
INSERT INTO payment_data VALUES ('3529241532993652','maestro')
INSERT INTO payment_data VALUES ('4936648491206682015', 'americanexpress')
INSERT INTO payment_data VALUES ('5602211139373991', 'maestro')
INSERT INTO payment_data VALUES ('3586725377661416', 'americanexpress')
INSERT INTO payment_data VALUES ('3550879205903144', 'maestro')
INSERT INTO payment_data VALUES ('50203100360505851', 'maestro')
INSERT INTO payment_data VALUES ('67066533574838744', 'americanexpress')
INSERT INTO payment_data VALUES ('5007665406507113', 'americanexpress')
INSERT INTO payment_data VALUES ('6709867360447539', 'maestro')
INSERT INTO payment_data VALUES ('201950560272968', 'americanexpress');
GO
 

-- guest;
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Mario', 'Fossord', '474 952 0138', 'mfossord0@newyorker.com', null, 1);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Joann', 'Kirkwood', '178 897 0365', 'jkirkwood1@nsw.gov.au', null, 2);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Lucine', 'Peltzer', '444 968 4417', 'lpeltzer2@cnn.com', null, 3);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Vinita', 'Gamell', '963 986 7495', 'vgamell3@cnet.com', null,4);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Angil', 'Coker', '777 282 3124', 'acoker4@skype.com', null,5);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Elliott', 'Rubi', '958 763 0610', 'erubi5@samsung.com', null,6);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Clifford', 'Cheater', '562 375 3993', 'ccheater6@apple.com', null, 7);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Jobey', 'Briamo', '631 369 2373', 'jbriamo7@drupal.org', null, 8);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Flss', 'McCoole', '788 942 9167', 'fmccoole8@techcrunch.com', null, 9);
 
INSERT INTO guest (first_name, last_name, phonenumber, email, contact_person, payment_data_id) VALUES ('Rickard', 'Brelsford', '476 646 1073', 'rbrelsford9@sciencedirect.com', null, 10);
GO
 
-- room_type;
INSERT INTO room_type VALUES ('Single', 1000);
INSERT INTO room_type VALUES ('Double', 1500);
INSERT INTO room_type VALUES ('Family', 2500);
GO
 
-- room;
INSERT INTO room VALUES (1, 1 , null);
INSERT INTO room VALUES (1, 1 , null);
INSERT INTO room VALUES (1, 1 , null);
 
INSERT INTO room VALUES (2, 3, 1);
INSERT INTO room VALUES (2, 2, null);
INSERT INTO room VALUES (2, 2, null);
INSERT INTO room VALUES (2, 2, null);
 
INSERT INTO room VALUES (3, 4, null);
INSERT INTO room VALUES (3, 4, null);
INSERT INTO room VALUES (3, 4, null);
GO
 
-- communication;
INSERT INTO communication VALUES (1,'Great service', 'Welcome back!', 4, 'Anna')
INSERT INTO communication VALUES (2,'Great service', 'Welcome back!', 3, 'Anna')
INSERT INTO communication VALUES (3,'Great service', 'Welcome back!', 5, 'Anna')
INSERT INTO communication VALUES (4,'Great service', 'Welcome back!', 5, 'Anna')
INSERT INTO communication VALUES (5,'Great service', 'Welcome back!', 5, 'Anna')
INSERT INTO communication VALUES (6,'Looking forward to my stay', 'Enjoy your stay!', null, 'Anna')
INSERT INTO communication VALUES (7,'Looking forward to my stay', 'Enjoy your stay!', null, 'Anna')
INSERT INTO communication VALUES (8,'Looking forward to my stay', 'Enjoy your stay!', null, 'Anna')
INSERT INTO communication VALUES (9,'Looking forward to my stay', 'Enjoy your stay!', null, 'Anna')
INSERT INTO communication VALUES (10,'Looking forward to my stay', 'Enjoy your stay!', null, 'Anna');
GO
 
-- payment;
INSERT INTO payment VALUES ('card', '2022-01-23 11:00:00')
INSERT INTO payment VALUES ('cash', '2022-01-23 11:00:00')
INSERT INTO payment VALUES ('card', '2022-01-23 11:00:00')
INSERT INTO payment VALUES ('invoice', '2022-01-23 11:00:00')
INSERT INTO payment VALUES ('invoice', '2022-01-23 11:00:00')
INSERT INTO payment VALUES (NULL, NULL)
INSERT INTO payment VALUES (NULL, NULL)
INSERT INTO payment VALUES (NULL, NULL)
INSERT INTO payment VALUES (NULL, NULL)
INSERT INTO payment VALUES (NULL, NULL);
GO
 
-- discount;
INSERT INTO discount VALUES ('BlackFriday10', 10)
INSERT INTO discount VALUES ('EarlyBird15', 15)
INSERT INTO discount VALUES ('EASTER20', 20)
INSERT INTO discount VALUES ('EASTER20', 20)
INSERT INTO discount VALUES ('BlackFriday10', 10)
INSERT INTO discount VALUES ('EarlyBird15', 15)
INSERT INTO discount VALUES ('BlackFriday10', 10)
INSERT INTO discount VALUES ('EarlyBird15', 15)
INSERT INTO discount VALUES ('EASTER20', 20)
INSERT INTO discount VALUES ('EASTER20', 20);
GO
 
-- reservation;
INSERT INTO reservation VALUES (1, '2022-01-22 15:00:00', '2022-01-23 11:00:00',1,'Anna', 1,'2022-01-22 19:00:00',1,null,900,1, null)
INSERT INTO reservation VALUES (2, '2022-01-22 15:00:00', '2022-01-23 11:00:00',1,'Anna', 2,null,2,null,1000,null, null)
INSERT INTO reservation VALUES (3, '2022-01-22 15:00:00', '2022-01-23 11:00:00',1,'Anna', 3,null,3,null,1000,null, null)
INSERT INTO reservation VALUES (4, '2022-01-22 15:00:00', '2022-01-23 11:00:00',3,'Anna', 4,null,4,null,1500,null, null)
INSERT INTO reservation VALUES (5, '2022-01-22 15:00:00', '2022-01-23 11:00:00',2,'Anna', 5,null,5,null,1500,null, null)
INSERT INTO reservation VALUES (6, '2022-05-05 15:00:00', '2022-05-06 11:00:00',2,'Anna', 6,null,6,null,1500,null, null)
INSERT INTO reservation VALUES (7, '2022-05-05 15:00:00', '2022-05-06 11:00:00',2,'Anna', 7,null,7,null,1500,null, null)
INSERT INTO reservation VALUES (8, '2022-05-25 15:00:00', '2022-05-27 11:00:00',4,'Anna', 8,null,8,null,2500,null, null)
INSERT INTO reservation VALUES (9, '2022-05-25 15:00:00', '2022-05-27 11:00:00',4,'Anna', 9,null,9,null,2500,null, null)
INSERT INTO reservation VALUES (10, '2022-05-25 15:00:00', '2022-05-27 11:00:00',4,'Anna',10,null,10,null,2500,null,null);
GO
