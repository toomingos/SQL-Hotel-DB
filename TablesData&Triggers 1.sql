use booking_system;
------------------------  ENTITIES & ATTRIBUTES  -------------------------
## TB_HOTEL_CHAIN
CREATE TABLE IF NOT EXISTS `TB_HOTEL_CHAIN` (
  `CHAIN_ID` int(8) NOT NULL,
  `CHAIN_NAME` varchar(12) NOT NULL,
  PRIMARY KEY (`CHAIN_ID`)
) ;

## TB_HOTEL 
CREATE TABLE IF NOT EXISTS `TB_HOTEL` (
  `HOTEL_ID` int(8) NOT NULL,
  `HOTEL_NAME` varchar(20) NOT NULL,
  `CHAIN_ID` int(8) NOT NULL,
  PRIMARY KEY (`HOTEL_ID`,`CHAIN_ID`)
) ;

## TB_ROOM
CREATE TABLE IF NOT EXISTS `TB_ROOM` (
  `ROOM_ID` int(8) NOT NULL,
  `HOTEL_ID` int(8) NOT NULL,
  `ROOM_PRICE` decimal(8,2) DEFAULT NULL,
  `ROOM_FLOOR` INTEGER DEFAULT NULL,
  `ROOM_ADDITIONAL_NOTES` MEDIUMTEXT DEFAULT NULL,
  `ROOM_TYPE_DESC` MEDIUMTEXT NULL,
  PRIMARY KEY (`ROOM_ID`)
) ;

## TB_BOOKINGS 
CREATE TABLE IF NOT EXISTS `REF_TB_BOOKINGS` (
  `BOOKING_ID` int(8) NOT NULL,
  `PAYMENT_ID` int(8) DEFAULT NULL,
  `ROOM_ID` int(8) NOT NULL,
  `CUSTOMER_ID` varchar(8) NOT NULL,
  `DATE_BOOKING_MADE` date NOT NULL,
  `TIME_BOOKING_MADE` Time NOT NULL,
  `BOOKING_START_DATE` date NOT NULL,
  `BOOKING_END_DATE` date NOT NULL,
  `DATE_PAYMENT_MADE` date DEFAULT NULL,
  `BOOKING_COMMENTS` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`BOOKING_ID`,`ROOM_ID`)
);

## TB_PAYMENTS
CREATE TABLE IF NOT EXISTS `TB_PAYMENTS` (
  `PAYMENT_ID` int(8) NOT NULL,
  `CUSTOMER_ID` varchar(8) NOT NULL,
  `BOOKING_ID` int(8) NOT NULL,
  `DATE_PAYMENT_MADE` date NOT NULL,
  `PAYMENT_METHOD_ID` int(8) NOT NULL,
  `PAYMENT_AMOUNT` decimal(8,2) DEFAULT NULL,
  `PAYMENT_COMMENTS` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`PAYMENT_ID`)
) ;

## TB_PAYMENT_METHODS 
CREATE TABLE IF NOT EXISTS `REF_TB_PAYMENT_METHODS` (
  `PAYMENT_METHOD_ID` int(8) NOT NULL,
  `PAYMENT_METHOD_DESC` varchar(15) NOT NULL,
  PRIMARY KEY (`PAYMENT_METHOD_ID`)
) ;

## TB_CUSTOMER 
CREATE TABLE IF NOT EXISTS `TB_CUSTOMER` (
  `CUSTOMER_ID` varchar(8) NOT NULL,
  `CUSTOMER_FIRSTNAME` varchar(20) NOT NULL,
  `CUSTOMER_SURNAME` varchar(25) NOT NULL,
  `CUSTOMER_DATE_OF_BIRTH` date NOT NULL,
  `CUSTOMER_HOME_PHONE` varchar(20) DEFAULT NULL,
  `CUSTOMER_WORK_PHONE` varchar(20) DEFAULT NULL,
  `CUSTOMER_MOBILE_PHONE` varchar(20) NOT NULL,
  `CUSTOMER_EMAIL` varchar(40) NOT NULL,
  `CITY_ID` varchar(8) NOT NULL,
  PRIMARY KEY (`CUSTOMER_ID`)
);

## TB_CITY 
CREATE TABLE IF NOT EXISTS `TB_CITY` (
  `CITY_ID` varchar(8) NOT NULL,
  `CITY_NAME` varchar(40) NOT NULL,
  `COUNTRY_ID` varchar(8) NOT NULL,
  PRIMARY KEY (`CITY_ID`)
);

## TB_COUNTRY
CREATE TABLE IF NOT EXISTS `TB_COUNTRY` (
  `COUNTRY_ID` varchar(8) NOT NULL,
  `COUNTRY_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`COUNTRY_ID`)
);

## LNK_TB_RATE_PERIOD 
CREATE TABLE IF NOT EXISTS `LNK_TB_RATE_PERIOD` (
  `RATE_PERIOD_ID` int(8) NOT NULL,
  `RATE_NAME` varchar(40) DEFAULT NULL,
  `BOOKING_ID` int(8) NOT NULL,
  `ROOM_ID` int(8) NOT NULL,
  PRIMARY KEY (`RATE_PERIOD_ID`)
);

# TB_CUSTOMER_RATING
CREATE TABLE IF NOT EXISTS `TB_CUSTOMER_RATING` (
  `CUSTOMER_RATING_ID` varchar(8) NOT NULL,
  `CUSTOMER_RATING` tinyint DEFAULT NULL,
  `CUSTOMER_RATING_COMMENTS` tinytext DEFAULT NULL,
  `CUSTOMER_ID` varchar(8) NOT NULL,
  `BOOKING_ID` int(8) NOT NULL,
  `ROOM_ID` int(8) NOT NULL,
  PRIMARY KEY (`CUSTOMER_RATING_ID`)
);

------------------------ DATA INSERTION  -------------------------
## TB_COUNTRY
INSERT INTO `TB_COUNTRY` (`COUNTRY_ID`, `COUNTRY_NAME`) VALUES
('AR', 'Argentina'),
('AU', 'Australia'),
('BE', 'Belgium'),
('BR', 'Brazil'),
('CA', 'Canada'),
('CH', 'Switzerland'),
('CN', 'China'),
('DE', 'Germany'),
('DK', 'Denmark'),
('EG', 'Egypt'),
('FR', 'France'),
('HK', 'HongKong'),
('IL', 'Israel'),
('IN', 'India'),
('IT', 'Italy'),
('JP', 'Japan'),
('KW', 'Kuwait'),
('MX', 'Mexico'),
('NG', 'Nigeria'),
('NL', 'Netherlands'),
('SG', 'Singapore'),
('UK', 'United Kingdom'),
('US', 'United States of America'),
('ZM', 'Zambia'),
('ZW', 'Zimbabwe');

## TB_CITY 
INSERT INTO `TB_CITY` (`COUNTRY_ID`, `CITY_NAME` , `CITY_ID`) VALUES
('AR', 'Buenos Aries' , 'BAR' ),
('AU', 'Sydney' , 'SYD' ),
('BE', 'Genk', 'GEN' ),
('BR', 'Sao Paulo' , 'SaoP' ),
('CA', 'Vancouver', 'VAN' ),
('CH', 'Basel', 'BAS' ),
('CN', 'Beijing', 'BEI' ),
('DE', 'Munchen','MUN' ),
('DK', 'Aarhus','AaR' ),
('EG', 'Cairo', 'CAI' ),
('FR', 'Paris', 'PAR' ),
('HK', 'HongKong', 'HKO' ),
('IL', 'Tel Aviv', 'AVI' ),
('IN', 'Mumbai','MUM' ),
('IT', 'Roma','ROM' ),
('JP', 'Osaka','OSK' ),
('KW', 'Al-Kuwait','ALKW' ),
('MX', 'Cancun','CAN' ),
('NG', 'Abuja', 'ABJ' ),
('NL', 'Amsterdam', 'AMS' ),
('SG', 'Singapore', 'SIN' ),
('UK', 'London', 'LON' ),
('US', 'New York', 'NWY' ),
('ZM', 'Lusaka', 'LUS' ),
('ZW', 'Harare', 'HAR' );

## TB_CUSTOMER
INSERT INTO `TB_CUSTOMER` (`CUSTOMER_ID`, `CUSTOMER_FIRSTNAME`, `CUSTOMER_SURNAME`, `CUSTOMER_EMAIL`, `CUSTOMER_MOBILE_PHONE`, `CUSTOMER_DATE_OF_BIRTH`, `CITY_ID`,`CUSTOMER_HOME_PHONE`,`CUSTOMER_WORK_PHONE`) VALUES
('3978', 'Jesenia', 'Crumpton', 'janetta.dew0561@berlin.dz', '+33-1926-060-545', '2013-09-30', 'BAR', '+595-9608-425-003', NULL),
('2934', 'Maryland', 'Easterling', 'gloriamattson@sodium.com', '+216-8035-194-421', '2008-03-19', 'SYD', NULL, NULL),
('5823', 'Hedwig', 'Janes', 'eliz-sterling@hotmail.com', '+599-9903-964-341', '1972-07-11', 'SYD', '+60-9262-422-770', '+264-0862-462-218'),
('863', 'Jack', 'Killian', 'jerilynlip@hotmail.com', '+599-1869-286-507', '2016-07-06', 'GEN', NULL, '+98-3586-106-312'),
('131', 'Tyree', 'Montano', 'junghandley2@yahoo.com', '+351-9978-277-300', '1977-01-12', 'HKO',NULL, '+46-2911-158-163'),
('53', 'Voncile', 'Levi', 'winfred.will@hotmail.com', '+502-2656-212-677', '1981-03-08', 'AVI', '+237-4290-074-121', NULL),
('237', 'Kristy', 'Kozak', 'britanymatheny@pocket.com', '+33-9343-157-752', '2004-05-06', 'MUM', '+31-3665-897-800', '+65-8039-382-569'),
('1452', 'Marin', 'Caudle', 'lizzie.olivo@cottages.com', '+47-0052-295-576', '1980-05-14', 'LON', '+234-5083-785-221', NULL),
('616', 'Marlys', 'Bowie', 'angelia_sacco0@ranger.com', '+90-4468-917-136', '2021-11-07', 'NWY', '+64-3241-462-149', '+266-8328-681-365'),
('10', 'Alison', 'Crane', 'ali_crane@hotmail.com', '+98-2223-261-859', '2011-01-22', 'LON', '+265-1907-032-913', '+90-5055-984-405'),
('1643', 'Breanne', 'Pace', 'page8@hotmail.com', '+98-2223-261-859', '2011-01-22', 'LON', '+265-1907-032-913', '+90-5055-984-405'),
('532', 'Arlinda', 'Waldrop', 'miriam406@tuesday.com', '+265-0260-508-739', '1994-07-22', 'HAR', '+213-5849-141-165', NULL),
('5167', 'Dorathy', 'Granados', 'demetrius.wylie4825@hotmail.com', '+39-3490-042-427', '2002-09-18', 'OSK', '+358-8571-762-716', '+972-5623-226-129'),
('48', 'Aleta', 'Tavares', 'willarddaly2@gmail.com', '+256-2657-791-154', '2012-08-03', 'ROM', '+57-6175-487-289', NULL),
('77', 'Marion', 'Beauchamp', 'harry.hanks@working.com', '+597-7098-110-866', '1978-01-04', 'AaR', '+351-3566-170-562', '+237-8045-954-077'),
('743', 'Fidela', 'Caballero', 'janettahealy3@hotmail.com', '+51-8089-705-856', '1995-07-26', 'LUS', NULL, NULL),
('108', 'Sibyl', 'Kimbrough', 'yajaira309@hotmail.com', '+39-8024-356-652', '1983-05-12', 'AaR', '+354-8155-266-421', '+968-1448-511-549'),
('4904', 'Kaci', 'Stoner', 'marlena.horn@should.com', '+254-1687-525-393', '1972-12-28', 'PAR', NULL, NULL),
('8675', 'Tamala', 'Cheng', 'elidia4074@receiver.com', '+82-0952-028-483', '1995-11-16', 'VAN', '+212-5430-855-423', NULL),
('3326', 'Kendra', 'Leger', 'jeanna50@vitamins.com', '+213-0530-576-294', '2000-12-23', 'PAR', NULL, '+66-4360-567-736');

## TB_HOTEL_CHAIN
INSERT INTO `TB_HOTEL_CHAIN` (`CHAIN_ID`, `CHAIN_NAME`) VALUES
('1', 'Innuva'),
('2', 'Lodit'),
('3', 'Zavvi');

## TB_HOTEL
INSERT INTO `TB_HOTEL` (`HOTEL_ID`, `HOTEL_NAME`, `CHAIN_ID`) VALUES
('1', 'NewEra Hotel', '2'),
('2', 'Marigny Hotel', '1'),
('3', 'Marshall Hotel', '2'),
('4', 'Vistana Hotel', '1'),
('5', ' Daybreak Hotel', '3'),
('6', 'Values Hotel', '3'),
('7', 'Riviera Hotel', '1'),
('8', 'SouthCoast Hotel', '2'),
('9', 'VillaMar Hotel', '1'),
('10', 'Waypoint Hotel', '2');

## TB_ROOM
INSERT INTO `TB_ROOM`(`ROOM_ID`, `HOTEL_ID`, `ROOM_PRICE`, `ROOM_FLOOR`, `ROOM_ADDITIONAL_NOTES`, `ROOM_TYPE_DESC`) VALUES
('4486', '1','662.99','9','beach view, king sized bed, private balcony','premium suite'),
('3634','2','816.99','10','beach view, king bed' ,'deluxe suite' ),
('5413','3','498.99','10','twin bed, pets allowed','standard suite with pets'),
('1693','4','409.99','3','twin bed, private balcony','standard suite with balcony'),
('6697','5','494.99','7','king sized bed','standard suite king'),
('7964','6','342.99','2','twin bed ','budget suite'),
('3727','7','153.99','10','beach view, king sized bed, private balcony','premium suite'),
('4078','8','361.99','3','beach view, king bed','deluxe suite' ),
('8873','9','551.99','5','twin bed, pets allowed','standard suite with pets'),
('2110','8','181.99','1','twin bed, private balcony','standard suite with balcony'),
('1748','7','851.99','3','king sized bed','standard suite king'),
('4898','10','960.5','6','twin bed' ,'budget suite'),
('4417','10','970.5','6','beach view, king sized bed, private balcony','premium suite'),
('4227','1','639.5','4','beach view, king bed','deluxe suite' ),
('1963','2','456.5','3','twin bed, pets allowed','standard suite with pets'),
('7745','3','381.5','7','twin bed, private balcony','standard suite with balcony'),
('2926','4','528.5','8','king sized bed','standard suite king'),
('3504','6','373.5','10','twin bed' ,'budget suite'),
('213','10','890.5','6','beach view, king sized bed, private balcony','premium suite'),
('8507','9','289','4','beach view, king bed','deluxe suite' ),
('4636','8','314','7','twin bed, pets allowed','standard suite with pets'),
('5807','3','239','6','twin bed, private balcony','standard suite with balcony'),
('3316','2','503','1','king sized bed','standard suite king'),
('7577','5','516','7','twin bed' ,'budget suite'),
('5863','4','386','6','twin bed, pets allowed','standard suite with pets');

## LNK_TB_RATE_PERIOD
INSERT INTO `LNK_TB_RATE_PERIOD` (`RATE_PERIOD_ID`, `RATE_NAME`, `BOOKING_ID`, `ROOM_ID`) VALUES
('28', 'Promotional Rate', '493', '4486'),
('341', ' Special Rate', '639', '7964'),
('457', ' Promotional Rate', '840', '3727'),
('32', ' Rack Rate', '829', '8873'),
('2', ' Promotional Rate', '948', '4898'),
('789', ' Promotional Rate', '875', '2110'),
('321', ' Rack Rate', '92', '7745'),
('21', ' Group Rate', '10', '1963'),
('476', ' Corporate Rate', '48', '213'),
('890', ' Promotional Rate', '850', '5863'),
('555', ' Corporate Rate', '493', '8507'),
('786', ' Promotional Rate', '3', '2926'),
('122', ' Rack Rate', '490', '4078'),
('435', ' Promotional Rate', '3496', '1748'),
('954', ' Rack Rate', '12', '3316'),
('43', ' Group Rate', '324', '3634'),
('5', ' Special Rate', '349', '5413'),
('19', ' Rack Rate', '1390', '7964'),
('583', ' Special Rate', '164', '1748'),
('120',' Rack Rate','120','8507');

## TB_PAYMENTS
INSERT INTO `TB_PAYMENTS` (`PAYMENT_ID`,`CUSTOMER_ID`, `BOOKING_ID`,`DATE_PAYMENT_MADE`,`PAYMENT_METHOD_ID`,`PAYMENT_AMOUNT`) VALUES
('101','3978','493','2021-05-17','1011','1000.0'),
('102','2934','639','2020-06-07','1012','2500.0'),
('103','5823','840','2020-06-07','1013','3000.0'),
('104','863','829','2020-06-07','1014','1000.0'),
('105','131','948','2020-06-07','1015','1000.0'),
('106','53','875','2020-06-07','1016','5000.0'),
('107','237','92','2020-06-07','1017','1000.0'),
('108','1452','10','2020-06-07','1018','2000.0'),
('109','616','48','2020-06-07','1019','3000.0'),
('110','10','850','2020-06-07','1110','4000.0'),
('111','1643','493','2020-06-07','1111','2000.0'),
('112','532','3','2020-06-07','1112','1400.0'),
('113','5167','490','2020-06-07','1113','1500.0'),
('114','48','3496','2020-06-07','1114','1600.0'),
('115','77','12','2020-06-07','1115','1800.0'),
('116','743','324','2020-06-07','1116','1120.0'),
('117','108','349','2020-06-07','1117','1230.0'),
('118','4904','1390','2020-06-07','1118','1234.0'),
('119','8675','164','2020-06-07','1119','1500.0'),
('120','3326','120','2020-06-07','1120','1800.0');

## REF_TB_PAYMENT_METHODS
INSERT INTO `REF_TB_PAYMENT_METHODS` (`PAYMENT_METHOD_ID`,`PAYMENT_METHOD_DESC`)VALUES
('1011','card'),
('1012','cash'),
('1013','cash'),
('1014','card'),
('1015','card'),
('1016','bank transfer'),
('1017','cash'),
('1018','cash'),
('1019','card'),
('1110','bank transfer'),
('1111','cash'),
('1112','card'),
('1113','cash'),
('1114','bank transfer'),
('1115','cash'),
('1116','cash'),
('1117','cash'),
('1118','card'),
('1119','card'),
('1120','bank trabsfer');

## REF_TB_BOOKINGS
INSERT INTO `REF_TB_BOOKINGS` (`BOOKING_ID`,`PAYMENT_ID`,`ROOM_ID`,`CUSTOMER_ID`,`DATE_BOOKING_MADE`,`TIME_BOOKING_MADE`,`BOOKING_START_DATE`,`BOOKING_END_DATE`,`DATE_PAYMENT_MADE`)VALUES
('493','101','4486','3978','2021-05-07','12:38:26','2020-06-07','2020-06-15','2022-02-13'),
('639','102','7964','2934','2021-02-24','05:55:14','2021-06-08','2021-06-26','2022-02-13'),
('840','103','3727','5823','2022-03-08','07:34:31','2020-07-07','2020-07-15','2022-02-13'),
('829','104','8873','863','2021-04-07','00:27:34','2021-08-07','2021-08-12','2022-02-13'),
('948','105','4898','131','2022-06-07','09:11:48','2022-08-14','2022-08-29','2022-02-13'),
('875','106','2110','53','2021-07-12','07:01:07','2021-06-07','2021-06-15','2022-02-13'),
('92','107','7745','237','2022-08-07','00:50:01','2020-12-07','2020-12-27','2022-02-13'),
('10','108','1963','1452','2021-08-23','03:03:00','2021-06-07','2021-06-15','2022-02-13'),
('48','109','213','616','2021-09-06','03:51:07','2021-06-07','2021-06-15','2022-02-13'),
('850','110','5863','10','2022-10-13','02:53:11','2022-12-07','2022-12-29','2022-02-13'),
('3','112','2926','532','2022-07-13','10:48:21','2020-12-17','2020-12-29','2022-02-13'),
('490','113','4078','5167','2022-01-02','06:43:22','2022-12-23','2022-12-29','2022-02-13'),
('3496','114','1748','48','2021-10-13','07:36:53','2021-12-02','2021-12-29','2022-02-13'),
('12','115','3316','77','2021-02-13','11:49:27','2021-05-11','2021-06-29','2022-02-13'),
('324','116','3634','743','2021-02-13','10:02:29','2021-05-07','2021-06-29','2022-02-13'),
('349','117','5413','108','2021-04-21','10:31:14','2020-05-21','2020-05-29','2022-02-13'),
('1390','118','7964','4904','2021-02-13','00:19:10','2021-05-07','2021-06-29','2022-02-13'),
('164','119','1748','8675','2021-02-13','11:18:32','2021-05-11','2021-06-29','2022-02-13'),
('120','120','8507','3326','2022-02-13','01:40:51','2020-05-26','2020-06-29','2022-02-13'),
('800',NULL,'4486','3978','2021-07-07','12:38:26','2020-08-07','2020-07-15',NULL),
('300',NULL,'2110','2934','2021-08-07','12:38:26','2020-09-07','2020-08-15',NULL),
('400',NULL,'3316','53','2021-09-07','12:38:26','2020-10-07','2020-09-15',NULL);

## TB_CUSTOMERS_RATING
INSERT INTO `TB_CUSTOMER_RATING` (`CUSTOMER_RATING_ID`, `CUSTOMER_RATING`,`CUSTOMER_RATING_COMMENTS`, `CUSTOMER_ID`, `BOOKING_ID`, `ROOM_ID`) VALUES
('1','5','Amazing staff!','3978','493', '4486'),
('2','4',NULL, '2934','639', '7964'),
('3','4','Lovely beach view and breakfast.', '5823', '840', '3727'),
('4','3' ,NULL,'863', '829', '8873'),
('5','2' ,'Terrible smell coming from the toilet. Would not recommend.','53', '948', '4898'),
('6','3' ,NULL, '237','875', '2110');

----------------------------- TRIGGERS -----------------------------
delimiter //
CREATE TRIGGER TRG_BOOKINGS AFTER UPDATE
ON TB_PAYMENTS
FOR EACH ROW
UPDATE REF_TB_BOOKINGS SET DATE_PAYMENT_MADE = (SELECT DATE_PAYMENT_MADE FROM TB_PAYMENTS WHERE REF_TB_BOOKINGS.PAYMENT_ID = TB_PAYMENTS.PAYMENT_ID);//
delimiter ;

CREATE TABLE IF NOT EXISTS TB_HOTEL_LOGS(
	ID_LOG INTEGER UNSIGNED AUTO_INCREMENT,
    BOOKING_ID INT NOT NULL,
	CUSTOMER_ID INT(8) NOT NULL,
    DATE_BOOKING_MADE DATETIME,
    PRIMARY KEY (ID_LOG)
);

##TESTING THE TRIGGER FOR THE UPDATE
UPDATE TB_PAYMENTS
set TB_PAYMENTS.PAYMENT_AMOUNT = 2000.00
where TB_PAYMENTS.BOOKING_ID = 120;
#SELECT * FROM TB_PAYMENTS;
SELECT * FROM REF_TB_BOOKINGS WHERE BOOKING_ID = 120;
#PAYMENT 2020-06-07
#BOOKINGS 2022-02-13

delimiter //
CREATE TRIGGER TRB_INSERT_LOG_TB BEFORE DELETE 
ON REF_TB_BOOKINGS
FOR EACH ROW
INSERT INTO TB_HOTEL_LOGS (ID_LOG, BOOKING_ID, CUSTOMER_ID, DATE_BOOKING_MADE)
VALUES (ID_LOG, OLD.BOOKING_ID, OLD.CUSTOMER_ID, OLD.DATE_BOOKING_MADE);//
delimiter ;

##TESTING THE TRIGGER FOR DELETE
#DELETE FROM REF_TB_BOOKINGS WHERE BOOKING_ID = '324';
set SQL_SAFE_UPDATES = 0;
SELECT * FROM TB_HOTEL_LOGS;

------------------------------ FOREIGN KEYS -------------------------------

## TB_HOTEL FK - TB_HOTEL_CHAIN (`CHAIN_ID`)
ALTER TABLE `TB_HOTEL`
ADD CONSTRAINT `fk_TB_HOTEL_1`
  FOREIGN KEY (`CHAIN_ID`)
  REFERENCES `TB_HOTEL_CHAIN` (`CHAIN_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

## TB_ROOM FK - TB_HOTEL (`HOTEL_ID`)
ALTER TABLE `TB_ROOM`
ADD CONSTRAINT `fk_TB_ROOM_1`
  FOREIGN KEY (`HOTEL_ID`)
  REFERENCES `TB_HOTEL` (`HOTEL_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
## REF_TB_BOOKINGS` FK - TB_PAYMENTS ( `PAYMENT_ID` ), TB_ROOM (`ROOM_ID`), TB_CUSTOMER(`CUSTOMER_ID`) 
ALTER TABLE `REF_TB_BOOKINGS`
ADD CONSTRAINT `fk_TB_BOOKINGS_1`
  FOREIGN KEY (`PAYMENT_ID`)
  REFERENCES `TB_PAYMENTS` (`PAYMENT_ID`)
ON DELETE RESTRICT
ON UPDATE CASCADE;
ALTER TABLE `REF_TB_BOOKINGS`
ADD CONSTRAINT `fk_TB_BOOKINGS_2`
  FOREIGN KEY (`ROOM_ID`)
  REFERENCES `TB_ROOM` (`ROOM_ID`)
ON DELETE RESTRICT
ON UPDATE CASCADE;
ALTER TABLE `REF_TB_BOOKINGS`
ADD CONSTRAINT `fk_TB_BOOKINGS_3`
  FOREIGN KEY (`CUSTOMER_ID`)
  REFERENCES `TB_CUSTOMER` (`CUSTOMER_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

## TB_PAYMENTS` FK - TB_CUSTOMER ( `CUSTOMER_ID` ), TB_BOOKING (`BOOKING_ID`), TB_PAYMENT_METHODS(`PAYMENT_METHOD_ID`) 
ALTER TABLE `TB_PAYMENTS`
ADD CONSTRAINT `fk_TB_PAYMENTS_1`
  FOREIGN KEY (`CUSTOMER_ID`)
  REFERENCES `TB_CUSTOMER` (`CUSTOMER_ID`)
    ON DELETE RESTRICT
  ON UPDATE CASCADE;
  ALTER TABLE `TB_PAYMENTS`
ADD CONSTRAINT `fk_TB_PAYMENTS_2`
  FOREIGN KEY (`BOOKING_ID`)
  REFERENCES `REF_TB_BOOKINGS` (`BOOKING_ID`)
    ON DELETE RESTRICT
  ON UPDATE CASCADE;
  ALTER TABLE `TB_PAYMENTS`
ADD CONSTRAINT `fk_TB_PAYMENTS_3`
  FOREIGN KEY (`PAYMENT_METHOD_ID`)
  REFERENCES `REF_TB_PAYMENT_METHODS` (`PAYMENT_METHOD_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

## TB_CUSTOMER FK - TD_CITY (`CITY_ID`)
ALTER TABLE `TB_CUSTOMER`
ADD CONSTRAINT `fk_CUSTOMER_1`
  FOREIGN KEY (`CITY_ID`)
  REFERENCES `TB_CITY` (`CITY_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
## TB_CITY FK - TD_COUNTRY (`COUNTRY_ID`)
ALTER TABLE `TB_CITY`
ADD CONSTRAINT `fk_CITY_1`
  FOREIGN KEY (`COUNTRY_ID`)
  REFERENCES `TB_COUNTRY` (`COUNTRY_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
## LNK_TB_RATE_PERIOD` FK - TB_BOOKING ( `BOOKING_ID` ), TB_ROOM_ID (`ROOM_ID`) 
ALTER TABLE `LNK_TB_RATE_PERIOD`
ADD CONSTRAINT `fk_LNK_TB_RATE_PERIOD_1`
  FOREIGN KEY (`BOOKING_ID`)
  REFERENCES `REF_TB_BOOKINGS` (`BOOKING_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
ALTER TABLE `LNK_TB_RATE_PERIOD`
ADD CONSTRAINT `fk_LNK_TB_RATE_PERIOD_2`
  FOREIGN KEY (`ROOM_ID`)
  REFERENCES `TB_ROOM` (`ROOM_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
# TB_CUSTOMER_RATING` FK - TB_CUSTOMER ( CUSTOMER_ID ), TB_BOOKING ( `BOOKING_ID` ), TB_ROOM_ID (`ROOM_ID`) 
ALTER TABLE `TB_CUSTOMER_RATING`
ADD CONSTRAINT `fk_TB_CUSTOMER_RATING_1`
  FOREIGN KEY (`CUSTOMER_ID`)
  REFERENCES `TB_CUSTOMER` (`CUSTOMER_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
ALTER TABLE `TB_CUSTOMER_RATING`
ADD CONSTRAINT `fk_TB_CUSTOMER_RATING_2`
  FOREIGN KEY (`BOOKING_ID`)
  REFERENCES `REF_TB_BOOKINGS` (`BOOKING_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  ALTER TABLE `TB_CUSTOMER_RATING`
ADD CONSTRAINT `fk_TB_CUSTOMER_RATING_3`
  FOREIGN KEY (`ROOM_ID`)
  REFERENCES `TB_ROOM` (`ROOM_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

