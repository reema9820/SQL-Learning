
# joins: based on certain condition
# union: merging data from multiple tables
use batch27;
set FOREIGN_KEY_CHECKS = 0;  
drop table if exists customer;
set FOREIGN_KEY_CHECKS = 0;

#create a table
create table customer(
cust_id int,
first_name  varchar(20),
last_name  varchar(20),
city varchar(20),
telephone varchar(10));

insert into customer values (101, 'John','Bill', 'New York', '207998701'),
							(102, 'Joe','Amy', 'New Jersey', '207998702'),
							(103, 'Gary','George', 'Chicago', '207998703'),
							(104, 'Mark','Mark', 'Texas', '207998704');
                            
drop table if exists orders;
create table orders(
cust_id int,
order_id int,
order_date date,
shipper_id varchar(10));

insert into orders values (101,1,'2020-10-10','A111'),
(102,2,'2020-10-11','A112'),
(103,3,'2020-10-12','A113'),
(104,4,'2020-10-12','A114'),
(104,5,'2020-10-14','A115');

insert into customer values (105,'amy','joe','texas','207998705');

#inner join
select
c.cust_id,
c.first_name,
c.last_name,
c.telephone,
c.city,
o.order_date,
o.shipper_id
from customer as c
inner join orders as o
on o.cust_id=c.cust_id;



#shakila 
#query: filmid, title, length, category name for all the movies where category is action

use sakila;
select * from film;
select * from film_category;
select * from category;

select
f.film_id,
f.title,
f.length,
ca.name
from film as f
inner join category as ca
inner join film_category as fc
on f.film_id=fc.film_id and ca.category_id=fc.category_id
where ca.name='Action' ;

# inner join example
select
f.film_id,
f.title,
f.length,
ca.name
from film as f
inner join category as ca
inner join film_category as fc
on f.film_id=fc.film_id and ca.category_id=fc.category_id
where ca.name in ('Action','family') ;

##left join
use batch27;
#left join
select
c.cust_id as'cust_cust_id',
c.first_name,
c.last_name,
c.telephone,
c.city,
o.cust_id as 'order_cust_id',
o.order_id,
o.order_date,
o.shipper_id
from customer as c
left join orders as o
on o.cust_id=c.cust_id;


## RIGHT JOIN QUERY
insert into orders values
(106,6,'2020-10-18','A115'),
(106,7,'2020-10-19','A115');


## RIGHT JOIN
select
c.cust_id as'cust_cust_id',
c.first_name,
c.last_name,
c.telephone,
c.city,
o.cust_id as 'order_cust_id',
o.order_id,
o.order_date,
o.shipper_id
from customer as c
RIGHT join orders as o
on o.cust_id=c.cust_id;

##SELF JOIN
CREATE TABLE employee(
    emp_id tinyint,
	emp_name VARCHAR(20),
    Age tinyint,
    job_title varchar(20),
    manager_id tinyint);
    
insert into employee values 
(1,'Allex',34,'Manager',null),
(2,'Mia',25,'Team Lead',1),
(3,'Sara',30,'Sr. Programmer',2),
(4,'Allen',29,'Programmer',2),
(5,'John',45,'Admin',1);

# using left join because we need to select all the employees
#inner join also used
select 
	e.emp_id,
	e.emp_name as ' Employee_name',
    e.age,
    e.job_title,
    e1.emp_name as'Supervisor_name'
from employee e
left join employee e1
on e.manager_id=e1.emp_id;
    

#union join the data from two tables
create table t1(
id int not null,
v1 char(1) not null default 'A');

insert into t1 values (1,'A'), 
(2,'B'),(3,'C');

insert into t1(id) values(5),(6),(7);
select * from t1;
 
 create table t2(
 id int not null,
 v2 char(1) not null default 'A');
 
 insert into t2 values(1,'A'),(2,'B'),(3,'B'),(4,'C');
 insert into t2(id) values (9),(8),(10);
 
select id,v1 from t1;
select id,v2 from t2;

#union (removes duplicates)
select * from t1
union
select * from t2;

#union all(has duplicates)
select * from t1
union all
select * from t2;

# demonstrating the count of union all record
select count(*) from
(select * from t1
union all
select * from t2) as t;



#full order 
use batch27;
#left join
select
c.cust_id as'cust_cust_id',
c.first_name,
c.last_name,
c.telephone,
c.city,
o.cust_id as 'order_cust_id',
o.order_id,
o.order_date,
o.shipper_id
from customer as c
left join orders as o
on o.cust_id=c.cust_id
union
select
c.cust_id as'cust_cust_id',
c.first_name,
c.last_name,
c.telephone,
c.city,
o.cust_id as 'order_cust_id',
o.order_id,
o.order_date,
o.shipper_id
from customer as c
RIGHT join orders as o
on o.cust_id=c.cust_id;


