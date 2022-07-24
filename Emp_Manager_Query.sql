create database perf_mapping;

use perf_mapping;

create table employee(
	EMP_ID			char(4)		primary key,
    FIRST_NAME		varchar(25) 	not null,
    LAST_NAME		varchar(25)		not null,
    GENDER			char(1)			not null,
    ROLE			varchar(25)		not null,
    DEPT			varchar(25)		not null,
    EXP				tinyint			not null,
    COUNTRY			varchar(25)		NOT NULL,
	CONTINENT		varchar(25)		NOT NULL,
    SALARY			int				not null,
    EMP_RATING		tinyint			not null,
	MANAGER_ID		char(4)			not null);

alter table employee add foreign key (MANAGER_ID) references employee(emp_id);

select 
	e.emp_id, concat(e.first_name,' ', e.last_name) as Emp_name, 
    e.manager_id, concat(m.first_name,' ', m.last_name) as Manager_Name 
from employee e
inner join employee m
	on m.emp_id = e.manager_id;

select emp_id, manager_id, first_name, last_name from employee;

##3.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT 
##		from the employee record table, and make a list of employees and details of their department.
select 
	emp_id,
    first_name,
    last_name,
    gender,
    dept
from employee;

## 4.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING 
##		if the EMP_RATING is: 
##			●	less than two
##			●	greater than four 
##			●	between two and four
select 
	emp_id,
    first_name,
    last_name,
    gender,
    dept,
    emp_rating
from employee
where emp_rating < 2;

select 
	emp_id,
    first_name,
    last_name,
    gender,
    dept,
    emp_rating
from employee
where emp_rating > 4 ;

select 
	emp_id,
    first_name,
    last_name,
    gender,
    dept,
    emp_rating
from employee
where emp_rating between 2 and 4 ;

## 5.	Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees
##		in the Finance department from the employee table and then give the 
##		resultant column alias as NAME.
select 
	concat(first_name, ' ', last_name) as Name
from 
	employee
where 
	dept = 'FINANCE';
    
## 6.	Write a query to list only those employees who have someone reporting to them. 
##		Also, show the number of reporters (include the President and the CEO of the organization).  

select 
	m.manager_id, 
	e.first_name, 
    e.last_name, 
    count(m.manager_id) 'No of Rep Employees'
from employee m
inner join employee e on
		e.emp_id = m.manager_id
group by m.manager_id;  
  
select distinct manager_id from employee; 

## 7.	Write a query to list down all the employees from the healthcare and 
##		finance domain using union. Take data from the employee record table.   

select emp_id, first_name, last_name, dept
from employee
where dept = 'FINANCE'
union
select emp_id, first_name, last_name, dept
from employee
where dept = 'HEALTHCARE';

## 8.	Write a query to list down employee details such as EMP_ID, FIRST_NAME, 
##		LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
##		Also include the respective employee rating along with the 
##		max emp rating for the department.

select 	e.emp_id, 
		e.first_name, 
		e.last_name, 
        e.role, e.dept, 
        e.emp_rating, 
        (select max(d.emp_rating) from employee_demo d
			where d.dept = e.dept) "Dept Max Rating"
from employee_demo e;

select 	e.emp_id, 
		e.first_name, 
		e.last_name, 
        e.role, e.dept, 
        e.emp_rating, 
        max(emp_rating) over (partition by dept) as  "Dept Max Rating"
from employee_demo e;
## 9.	Write a query to calculate the minimum and the maximum salary 
##		of the employees in each role. Take data from the employee record table.

select role, min(salary) 'Min Salary', 
		max(salary) 'Max Salary'
from	employee
group by role;     

## 10.	Write a query to assign ranks to each employee based on their experience. 
##		Take data from the employee record table.   
select 
	first_name, 
    last_name, 
    exp,
    dense_rank() over (order by exp desc) 'Rank'
from 
	employee;
    
drop table if exists data_sciene_team;
    
create table if not exists data_science_team (
	EMP_ID			char(4)		primary key,
    FIRST_NAME		varchar(25) 	not null,
    LAST_NAME		varchar(25)		not null,
    GENDER			char(1)			not null,
    ROLE			varchar(25)		not null,
    DEPT			varchar(25)		not null,
    EXP				tinyint			not null,
    COUNTRY			varchar(25)		NOT NULL,
	CONTINENT		varchar(25)		NOT NULL
);

drop table if exists project;
    
create table project (
	PROJ_ID 	char(4)		primary key,
	PROJ_Name 	varchar(30)	not null,
	DOMAIN 		varchar(30)	not null,
	START_DATE 	char(10) not null,
	CLOSURE_DATE char(10) not null,
	DEV_QTR 	char(2) not null,
	STATUS 		varchar(20) not null
);
alter table project add column stdt date null;
alter table project add column cldt date null;

update project set
	stdt = str_to_date(replace(start_date,'/','-'),"%m-%d-%Y"),
    cldt = str_to_date(replace(closure_date,'/','-'),"%m-%d-%Y");
    
alter table project drop column start_date;
alter table project drop column closure_date;    

alter table project rename column stdt to start_date;
alter table project rename column cldt to closure_date; 

alter table project modify column start_date date not null after domain;
alter table project modify column closure_date date not null after start_date;

select * from project;  

## 14

drop function if exists check_jobprofile;

delimiter //
create function check_jobprofile (
		experience tinyint
)
returns varchar(30)
deterministic
begin
	declare job_profile		varchar(30);
    if (experience <= 2) then
		set job_profile = 'JUNIOR DATA SCIENTIST';
	elseif (experience <= 5) then
		set job_profile = 'ASSOCIATE DATE SCIENTIST';
	elseif (experience <= 10) then
		set job_profile = 'SENIOR DATA SCIENTIST';
	elseif (experience <= 12) then
		set job_profile = 'LEAD DATA SCIENTIST';
	else
		set job_profile = 'MANAGER';
	end if;
	return (job_profile);
end //
delimiter ;

select * from data_science_team;
select emp_id, role, check_jobprofile(exp) as der_role 
from data_science_team;

## 15

select first_name from employee where first_name = 'Eric';

## Creating index on first name
create index emp_fn_idx on employee(first_name);

alter table employee drop index emp_fn_idx;

## 16.	Write a query to calculate the bonus for all the employees, based on 
##		their ratings and salaries (Use the formula: 5% of salary * employee rating).

select 	
	first_name, 
	last_name, 
    salary, 
    emp_rating,
    round((salary * .05 * emp_rating),0) as Bonus,
    salary + round((salary * .05 * emp_rating),0) as total_payout
from
	employee_demo;
    
## 17.	Write a query to calculate the average salary distribution based on the  
##		continent and country. Take data from the employee record table.    

select continent, country, round(avg(salary),0) as "Avg. Salary"
from employee
group by continent, country;


## Selecting the emp_rating along with dept max rating 
## using window function
select
	emp_id, first_name, last_name, emp_rating,
    max(emp_rating) over (partition by dept) as max_rating
from
	employee_demo;
    
select
	emp_id, first_name, last_name, emp_rating,
    rank() over (order by emp_rating desc) as emp_rank,
    dense_rank() over (order by emp_rating desc) as emp_dense_rank
from
	employee_demo;