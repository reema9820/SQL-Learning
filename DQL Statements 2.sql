
# default table
 use sakila;
 
 select * from actor;
 
 # select first and last name from actor table
 select 
	first_name,last_name
from 
	actor;
    

##select all the record where f_name is johnny
select 
	first_name,last_name
from 
	actor
where
	first_name='Johnny';
   
   
##select all the record where f_name start with A   
select 
	first_name,last_name
from 
	actor
where
	first_name like "A%";
    
 ##select all the record where f_name start with A and B     
select 
	first_name,last_name
from 
	actor
where
	first_name like "A%" or first_name like "B%"  
order by first_name desc;
    
##select all the record where f_name start with A     
select 
	first_name,last_name
from 
	actor
where
	first_name like 'a___' 
order by first_name desc;

##select all the record where first_name<=5
select 
	first_name,last_name
from 
	actor
where
	first_name<=5
order by first_name desc;


## name is in here
select * from category;
select category_id from category
where name in('Action', 'drama', 'family');

## name is not in here
select * from category;
select category_id from category
where name not in('Action', 'drama', 'family');

## using or instead of in
select * from category;
select category_id from category
where name='Action' or name='drama' or name='family';

# select length between 100 and 120 minutes
select film_id, title,length
from film
where length between 100 and 120;

# select length not between 100 and 120 minutes
select film_id, title,length
from film
where length not between 100 and 120;

# select length bless than 90 min
select film_id, title,length
from film
where length< 90;

# select title (lord)
SELECT title
from film 
where title like '%Lord%';

# length column is in descnding order and title is in ascending order
select title, length 
from film
where length>100
order by length desc, title;

#aggregate functions
# You have a lot of transactional data, and you want to use functions for calc sum,min ,max, avg, this are aggregate functions

use batch27;
select * from cus_sales;

#geting unique customer id from cus_sales
select count(*) as 'Total number Sales' from cus_sales;
select distinct customerid from cus_sales;


select count(distinct customerid)  as 'dist-customers' from cus_sales;

select
	min(salesvalue) as'min sales',
	max(salesvalue) as'max sales',
	round(avg(salesvalue),2) as'avg sales',
	sum(salesvalue) as'Total sales'
from 
	cus_sales;
# grouping by each customer
select
	customerid,
	min(salesvalue) as'min sales',
	max(salesvalue) as'max sales',
	round(avg(salesvalue),2) as'avg sales',
	sum(salesvalue) as'Total sales'
from 
	cus_sales
group by
    customerid;
    
# fimnding the number of times customer has done some transaction
select customerid, count(customerid)
from cus_sales
group by customerid;

# having class used for aggregate value
# where class is for individual filtering for data which is already there, where as you can use having for creating new filters
#having class is used to filter aggregate data and where class is used to filter individual data
select
	customerid,

	sum(salesvalue) as'Total sales'
from 
	cus_sales
group by
    customerid
having
	sum(salesvalue)>5000;
    

use sakila;

# get number of films whose length is more than 100 min;
select count(film_id)
from film
where length> 100;

# for each rating see the avg length

select * from film;

# avg length for a rating
select rating, round(avg(length)) as 'avg_length'
from film
group by rating;

# avg length for pg rating
select rating, round(avg(length)) as 'avg_length'
from film
where rating like 'pg%'
group by rating;

#write a query last name should be first first name last
select * from actor;

select concat(last_name,", " , first_name) as 'lf'
from actor;

    
