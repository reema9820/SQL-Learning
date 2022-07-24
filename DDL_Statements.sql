## To create a database
create database batch27;

## To display available databases in the server
show databases;

## To drop a database
drop database shan;

## Using the created database
use batch27;

## To create a table
create table customer (
	custid	smallint	primary key,
    custname varchar(30) not null);
    
## To display the structure of the created table
desc customer;    

## To add a new column in the existing table
alter table customer add column city varchar(30);

## To modify existing column constraint
alter table customer modify city varchar(30) not null;

## To add a column in between existing columns
alter table customer add column country varchar(30) not null after custname;

create table c1 as select * from customer;
desc c1;
    
create table customer1 (
	custid	smallint	not null,
    custname varchar(30) not null,
    primary key (custid));   
    
desc customer1;    

## to drop a table
drop table if exists c1;

desc c1;

drop table if exists orders;
create table orders (
	order_id 	int  primary key,
    order_date 	date not null,
    order_qty	tinyint not null,
 	ord_cust_id	smallint not null,
    foreign key (ord_cust_id) references customer(custid));
    
desc orders;    
insert into customer values (1, 'ABCD', 'India','Bangalore');
insert into orders values (1, str_to_date('07/06/2022','%m/%d/%Y'), 10, 1);

select * from orders;
select * from customer;

truncate table orders;
commit;
delete from customer;
set FOREIGN_KEY_CHECKS = 0;  ## disabling the foreign key checks

truncate table customer;
set FOREIGN_KEY_CHECKS = 1;  ## enabling the foreign key checks

desc customer;

alter table customer change city city_name varchar(30) not null;

alter table customer modify city_name varchar(25) null;

desc customer;

create table c1 as select * from customer;

desc c1;

select * from c1;
insert into c1 values (1, 'abcd','india','blr');
insert into c1 values (1, 'xyz','some country','some city');

## to delete a record based on condition
delete from c1 where city_name like '%some%';

## To add a primary key
alter table c1 add primary key(custid);

## To drop a primary key
alter table c1 drop primary key;

alter table c1 add primary key(country);

## To drop a column
alter table c1 drop column city_name;

use batch27;
## To renamea table
rename table c1 to customer_1;

desc customer_1;

## DML Statements
## INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3);
## INSERT INTO table_name VALUES (value1, value2, value3);
insert into customer_1 values (2, 'Shan','India','Bangalore'), 
							(3, 'Amy', 'USA','Boston');
                            
select * from customer_1;    

insert into customer_1 values (4, 'John','UK', NULL);   

## Another variant
insert into customer_1 (custid, custname, country) 
			values (5, 'Bill','Mexico'), (6, 'Kathy','USA');

## Adding a default constraint            
alter table customer_1 modify city_name varchar(25) null default 'USA';  

desc customer_1; 
insert into customer_1 (custid, custname, country) 
			values (7, 'Will','USA');        
select * from customer_1;    

desc customer;
## 
alter table customer modify city_name varchar(25) null default 'Unknown';  

select * from customer;  

insert into customer
		select * from customer_1
        where city_name is not null;
        
delete from customer;        