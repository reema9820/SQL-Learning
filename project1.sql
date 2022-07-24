create database project1;
use project1;
select * from emp_record_table;
select * from proj_table;
select * from data_science_team;
#3
#3.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, 
# and make a list of employees and details of their department.
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
from emp_record_table;

#4 4.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
# less than two
select EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
WHERE EMP_RATING<2;

#	greater than four 
select ï»¿EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
WHERE EMP_RATING>4;
#	between two and four
select ï»¿EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
from emp_record_table
WHERE EMP_RATING BETWEEN 2 AND 4;

#5 5.	Write a query to concatenate the FIRST_NAME and the LAST_NAME of 
#employees in the Finance department from the employee table and then give the resultant column alias as NAME.
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS NAME
FROM  emp_record_table
WHERE DEPT='FINANCE';

#6 6.	Write a query to list only those employees who have someone reporting to them.
# Also, show the number of reporters (include the President and the CEO of the organization).
ALTER TABLE emp_record_table CHANGE COLUMN EMP_IDD EMP_ID VARCHAR(5) NOT NULL;

select MANAGER_ID, count(distinct EMP_ID) as count  from emp_record_table
group by MANAGER_ID;


(SELECT DISTINCT MI.MANAGER_ID,EMP.FIRST_NAME,EMP.LAST_NAME,EMP.ROLE
FROM emp_record_table as EMP
inner join emp_record_table as MI
ON MI.MANAGER_ID=EMP.EMP_ID);


#7.	Write a query to list down all the employees from the healthcare and finance domain using union.
#Take data from the employee record table.
SELECT * from emp_record_table where dept='healthcare'
union
SELECT * from emp_record_table where dept='finance';

#8 8.	Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING
# grouped by dept. Also include the respective employee rating along with the max emp rating for the department.

with max_emp_rating as ( select DEPT, max(emp_rating)  as MAX_RATING from emp_record_table group by dept )
select  emp.EMP_ID, emp.FIRST_NAME, emp.LAST_NAME, emp.ROLE, emp.DEPT, emp.EMP_RATING,m. MAX_RATING 
from emp_record_table as emp 
INNER JOIN max_emp_rating as m
on emp.dept=m.dept
order by dept;

#9 9.	Write a query to calculate the minimum and the maximum salary of the employees in each role. 
#Take data from the employee record table.
select min(salary),max(salary),role
from emp_record_table
group by role;

#10 (10.	Write a query to assign ranks to each employee based on their experience. 
#Take data from the employee record table.
# rank function
SELECT emp_id, first_name, last_name,exp ,
RANK () OVER (
ORDER BY exp
) AS Rank_no 
FROM  emp_record_table
order by exp;


#11 11.	Write a query to create a view that displays employees in various countries whose salary is more than six thousand. 
#Take data from the employee record table.
select * from emp_record_table;
create or replace view coun as (select emp_id,first_name,last_name,country,salary from emp_record_table where salary>6000);
select * from coun
order by country;

#12 12.	Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
select * from emp_record_table;

select 

select * from emp_record_table
where exp>10;

#12 12.	Write a nested query to find employees with experience of more than ten years.
# Take data from the employee record table
select * from emp_record_table;
select emp_id,first_name,last_name,exp from emp_record_table where exp>10;

#15  Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME 
#is ‘Eric’ in the employee table after checking the execution plan.
# 16 Write a query to calculate the bonus for all the employees, based on their ratings and salaries 
#(Use the formula: 5% of salary * employee rating).

with bonus_table as( select emp_id, (0.05 *salary*emp_rating) as bonus from emp_record_table)
select e.emp_id, e.emp_rating,e.salary,b.bonus
from emp_record_table e
left join bonus_table b
on e.emp_id=b.emp_id
order by 1,2;
#17 17.	Write a query to calculate the average salary distribution based on the continent and country.
# Take data from the employee record table.
select continent,country,avg(salary)
from emp_record_table
group by 1,2
order by 1,2;