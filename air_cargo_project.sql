drop database if exists air_cargo;

create database air_cargo;

use air_cargo;

##
## Creating Tables
##

drop table if exists customer;

create table customer (
	customer_id		tinyint	primary key,
	first_name 		varchar(30)	not null,
	last_name 		varchar(30) not null,
	date_of_birth 	date not null,
	gender 			char(1)
);

drop table if exists routes;

create table routes (
	Route_id 		tinyint 	primary key,
	Flight_num 		smallint 	not null,
	Origin_airport 	char(3) 	not null,
	Destination_airport 	char(3)	not null,
	Aircraft_id 	varchar(15)	not null,
	Distance_miles 	smallint not null,
    constraint check_miltes check (distance_miles > 0),
    constraint check_flight_num check (flight_num > 0)
);

drop table if exists flight_passengers;

create table flight_passengers (
	customer_id		tinyint not null references customer(customer_id),
    aircraft_id 	varchar(20)	not null,	
	route_id 		tinyint not null references route(route_id),
	depart			char(3)	not null,
	arrival 		char(3)	not null,
	seat_num 		varchar(10)	not null,
	class_id 		varchar(20)	not null,
	travel_date 	date not null,
	flight_num 		smallint
);

drop table if exists ticket_details;

create table ticket_details (
	p_date 			date not null,
	customer_id 	tinyint not null references customer(customer_id),
	aircraft_id 	varchar(20) not null,
	class_id 		varchar(20) not null,
	no_of_tickets 	tinyint not null,
	a_code 			char(3)	not null,
	price_per_ticket smallint not null,
	brand 			varchar(30) not null
);
