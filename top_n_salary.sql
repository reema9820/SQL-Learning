use batch27;

desc emp_details;

select emp_id, first_name, last_name, salary from emp_details
order by salary desc
limit 5;

select salary from emp_details 
order by salary desc 
limit 2,1;

select min(salary) from (select salary from emp_details 
order by salary desc 
limit 3) as t;

with top_3_salaries as (
select salary from emp_details 
order by salary desc
limit 3)
select min(salary) from top_3_salaries;