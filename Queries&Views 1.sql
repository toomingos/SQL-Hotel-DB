USE booking_system;

--------------- QUERIES -------------------
#F.1 - NAME OF CUSTOMERS THAT BOOKED A ROOM BETWEEN 01/05/2021 AND 01/01/2022
SELECT  CONCAT(c.CUSTOMER_FIRSTNAME, " ", c.CUSTOMER_SURNAME) AS FullName
FROM TB_CUSTOMER c INNER JOIN
     REF_TB_BOOKINGS b
     ON c.CUSTOMER_ID = b.CUSTOMER_ID
WHERE b.BOOKING_START_DATE BETWEEN '2021-05-01' AND '2022-01-01'
GROUP BY c.CUSTOMER_FIRSTNAME, c.CUSTOMER_SURNAME; 

# F.1 - Efficiency analysis:
# Duration of approx: 0.000 sec 
# REF_TB_BOOKINGS's key is NULL and all rows are iterated, which means it is not finding a key to iterate through it.
# To optimize this query an index should be created on "BOOKING_START_DATE", decreasing the iteration from 22 to 10.
# TB_CUSTOMER's key is primary and only one row is iterated to retrieve the query output, which means it is optimal.

#F.2 - 3 BEST ROOM TYPES BASED ON NUMBER OF TIMES IT GOT BOOKED 
SELECT r.ROOM_TYPE_DESC AS MostBookedTypesofRoom
FROM TB_ROOM r INNER JOIN
	REF_TB_BOOKINGS b 
    ON b.ROOM_ID = r.ROOM_ID
GROUP BY r.ROOM_TYPE_DESC
ORDER BY COUNT(b.ROOM_ID) DESC
LIMIT 3;

# F.2 - Efficiency analysis:
# Duration of approx: 0.016 sec 
# REF_TB_BOOKINGS's key is fk_TB_BOOKINGS_2 and all rows are iterated to count the number of times each room was booked.
# Since it must go through each row to find the room with the most bookings, it is already optimal.
# TB_ROOM's key is primary and only one row is iterated to retrieve the query output, which means it is optimal.


#F.3 - TOTAL AND AVERAGE AMOUNT OF $ FROM BOOKINGS IN THE LAST 2 YEARS
SELECT CONCAT(MIN(b.BOOKING_START_DATE), "  -  ", MAX(b.BOOKING_START_DATE)) AS PeriodofBookings, 
	   ROUND(SUM(p.PAYMENT_AMOUNT), 2) AS TotalSales, 
       ROUND(SUM(p.PAYMENT_AMOUNT)/2, 2) AS YearlyAverage, 
       ROUND(AVG(p.PAYMENT_AMOUNT),2) AS MonthlyAverage
FROM  REF_TB_BOOKINGS b INNER JOIN
	  TB_PAYMENTS p
      ON b.BOOKING_ID = p.BOOKING_ID
WHERE b.BOOKING_START_DATE BETWEEN '2020-01-01' AND '2022-12-31';

# F.3 - Efficiency analysis:
# Duration of approx: 0.000 sec 
# REF_TB_BOOKINGS's key is Null and all rows are iterated, which means it is not finding a key to iterate through it.
# To optimize this query an index should be created on "BOOKING_START_DATE", decreasing the iteration from 22 on TB_BOOKINGS to 1.
# Doing that, TB_PAYMENTS must be iterated only in the time frame specified to retrieve the sum and average of payments, which means it is optimal.

# F.4 - TOTAL $ BOOKINGS BY GEOGRAPHICAL LOCATION 
SELECT D.COUNTRY_NAME AS COUNTRY, 
       C.CITY_NAME AS CITY,
       ROUND(SUM(p.PAYMENT_AMOUNT), 2) AS TotalSales 
FROM  REF_TB_BOOKINGS b INNER JOIN
	  TB_PAYMENTS p
      ON b.BOOKING_ID = p.BOOKING_ID
      INNER JOIN TB_CUSTOMER CT 
      ON B.CUSTOMER_ID = CT.CUSTOMER_ID  
      INNER JOIN TB_CITY C
      ON C.CITY_ID = Ct.CITY_ID
      INNER JOIN TB_COUNTRY D 
      ON C.COUNTRY_ID = D.COUNTRY_ID
GROUP BY D.COUNTRY_NAME, C.CITY_NAME
ORDER BY 1;

# F.4 - Efficiency analysis:
# Duration of approx: 0.015 sec 
# TB_PAYMENTS's key is NULL and all rows are iterated through, but in order to sum the sales by region that must happen, so it is already optimized.
# TB_COUNTRY's, TB_PAYMENTS', TB_CUSTOMER's, REF_TB_BOOKINGS's, and TB_CITY's keys are primary and only one row is iterated to retrieve the output, so it is already optimal.


## F.5 - LOCATIONS WHERE SERVICES WERE SOLD WITH OVERALL CUSTOMER'S RATING
SELECT D.COUNTRY_NAME AS COUNTRY, 
       C.CITY_NAME AS CITY,
       CR.CUSTOMER_RATING AS CUSTOMER_RATING
FROM  REF_TB_BOOKINGS b INNER JOIN 
	  TB_PAYMENTS p
      ON b.BOOKING_ID = p.BOOKING_ID
      INNER JOIN TB_CUSTOMER CT  
      ON B.CUSTOMER_ID = CT.CUSTOMER_ID
      INNER JOIN TB_CUSTOMER_RATING CR
      ON B.CUSTOMER_ID = CR.CUSTOMER_ID
      INNER JOIN TB_CITY C 
      ON C.CITY_ID = Ct.CITY_ID
      INNER JOIN TB_COUNTRY D  
      ON C.COUNTRY_ID = D.COUNTRY_ID
WHERE b.BOOKING_START_DATE BETWEEN '2020-01-01' AND '2022-12-31'
AND B.PAYMENT_ID IS NOT NULL
GROUP BY D.COUNTRY_NAME, C.CITY_NAME, CR.CUSTOMER_RATING
ORDER BY 1;

# F.5 - Efficiency analysis:
# Duration of approx: 0.000 sec 
# CUSTOMER_RATING's key is NULL and all rows are iterated through, but in order to find the overall rating that must happen, so it is already optimized.
# TB_COUNTRY's, TB_PAYMENTS', TB_CUSTOMER's, REF_TB_BOOKINGS's, and TB_CITY's keys are primary and only one row is iterated to retrieve the output, so it is already optimal.

-------------- VIEWS ------------------

# G.1 - VIEW FOR INVOICE HEAD AND TOTALS
create or replace view INVOICE_HEAD_TOTALS as
select pay.PAYMENT_ID as invoice_number,
		book.DATE_BOOKING_MADE as date_of_issue,
		concat(cust.CUSTOMER_FIRSTNAME,' ',cust.CUSTOMER_SURNAME) as client_name,
		cit.CITY_NAME as client_city,
		cou.COUNTRY_NAME as client_country,
		'Bookmearoom' as company_name,
		'nomane Road 1' as company_address,
		'Lisbon' as company_city,
		'Portugal' as company_country,
		sum(datediff(book.BOOKING_END_DATE,book.BOOKING_START_DATE)*room.ROOM_PRICE) as invoice_subtotal,
		0.06 as tax_rate,
		round(sum(datediff(book.BOOKING_END_DATE,book.BOOKING_START_DATE)*room.ROOM_PRICE)*0.06, 2) as tax_value,
		round(sum(datediff(book.BOOKING_END_DATE,book.BOOKING_START_DATE)*room.ROOM_PRICE)*(1+0.06),2) as invoice_total
from tb_customer as cust
	join tb_city as cit on cust.CITY_ID = cit.CITY_ID
	join tb_country as cou on cou.COUNTRY_ID = cit.COUNTRY_ID
	join ref_tb_bookings as book on cust.CUSTOMER_ID = book.CUSTOMER_ID
	join tb_room as room on room.ROOM_ID = book.ROOM_ID
	join tb_payments as pay on book.BOOKING_ID = pay.BOOKING_ID
group by 1,2,3,4,5,6,7,8,9,11
order by date_of_issue;


# G.2 - VIEW FOR INVOICE DETAILS
create or replace view INVOICE_DETAILS as
select pay.PAYMENT_ID as invoice_number,
		concat(book.BOOKING_ID,'-',book.ROOM_ID) as item_ref,
		room.ROOM_ADDITIONAL_NOTES as item_name,
		room.ROOM_PRICE as unit_cost,
		datediff(book.BOOKING_END_DATE,book.BOOKING_START_DATE) as qty,
		room.ROOM_PRICE * datediff(book.BOOKING_END_DATE,book.BOOKING_START_DATE)  as amount 
from ref_tb_bookings as book
	join tb_room as room on book.ROOM_ID = room.ROOM_ID
	join tb_payments as pay on book.BOOKING_ID = pay.BOOKING_ID
;




    