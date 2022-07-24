create database project2;
use project2;
DROP TABLE route_details;
CREATE TABLE route_details(
route_id INT(10) UNIQUE ,
flight_num INT(10) CHECK(flight_num >1000),
origin_airport VARCHAR(225),
destination_airport VARCHAR(225),
aircraft_id VARCHAR(225),
distance_miles INT(10) CHECK(distance_miles>0) );

# 3.	Write a query to display all the passengers who have travelled in routes 01 to 25 from the passengers_on_flights table.
select customer.first_name, customer.last_name, passenger.route_id from customer as customer
inner join passengers_on_flights  as passenger
on customer.customer_id = passenger.customer_id
where passenger.route_id between 0 and 25
order by passenger.route_id;

#4. 4.	Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.
select * from ticket_details
order by customer_id;
select count(distinct customer_id), sum(price_per_ticket) from ticket_details where class_id='Bussiness';


# 5 full name
select concat(first_name,' ',last_name) as Full_Name from customer;

# 6 	Write a query to extract the customers who have registered and booked a ticket from the customer and ticket_details tables.
select distinct(c.customer_id), concat(first_name,' ',last_name) as Full_Name from customer c
inner join ticket_details td on 
c.customer_id=td.customer_id
order by customer_id;

#7 Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates)from the ticket_details table.
select * from ticket_details;
select * from customer;
select * from passengers_on_flights;

select c. first_name, c.last_name, t.customer_id, t.brand, t.class_id from customer c	
join ticket_details t
on c.customer_id = t.customer_id
where t.brand = "emirates"
order by t. customer_id;

# 8.	Write a query to identify the customers who have travelled more than once 
#by Economy Plusclass using Group By and Having clause on thepassengers_on_flights table.
select c.customer_id,first_name, c.last_name,p.class_id
from customer c
inner join passengers_on_flights p
on c.customer_id=p.customer_id
where p.class_id='economy' and (Select COUNT(p.customer_id)
FROM passengers_on_flights p
GROUP BY p.customer_id
HAVING COUNT(p.customer_id)>1);

 #9 9.	Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table.


select  if(sum(price_per_ticket)>10000,"Yes Revenue has Crossed 10000",
"no Revenue has Crossed not 10000") as Total_Revenue from ticket_details;

#10 10.	Write a query to create and grant access to a new user to perform operations on a database.

#11 11.	Write a query to find the maximum ticket price for each class using window functions on the ticket_details table. 

#12. 12.	Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table.





