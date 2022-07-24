use batch27;
#multiple temp_table created in a single query
drop table emp_details;
create table emp_details(
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
   
desc emp_details;
select * from emp_details limit 3;

#select top5 salary
select * from emp_details
order by salary desc
limit 5;

#select the third highest salary
# offset: discard two rows
# limit 2,1 : offset is 2, means remove 2 rows and return the third row(since here 1 is given)
select salary from emp_details
order by salary desc
limit 2,1;

#selecting minimum
select min(salary)  from ( select * from emp_details
order by salary desc
limit 3) as t;

#with cte

with top_3_sal as (
select salary from emp_details
order by salary desc
limit 3)
select min(salary) from top_3_sal;

select salary from 
(select * from emp_details as emp
order by salary desc
limit 3);

select count(emp_id) from emp_details;
with manager_ids as(
	select distinct manager_id as Manager_id
	from emp_details),
	manager_details as (
		select m.Manager_id, concat(e.first_name,' ',e.last_name) as Manager_name
		from manager_ids m
		inner join emp_details e on
			e.emp_id=m.Manager_id)

select e.emp_id, e.first_name, e.last_name,e.role,
	m.Manager_id, m.Manager_name
from emp_details e
left join manager_details m on
	m.Manager_id=e.MANAGER_ID
order by Manager_id,manager_name;


# common table expresssion for school_db table

# CTE for student avg table
# select sub_id, avg(mark) as avg_mark from stu_marks group by sub_id;
with sub_avg_marks as(
select sub_id, avg(mark) as avg_mark
from stu_marks
group by sub_id)
select st.name as student_name, sb.sub_name as subject_name, sm.mark
from stu_marks sm
inner join students as st on
st.id=sm.stu_id
inner join subjects as sb on
sb.sub_id=sm.sub_id
inner join sub_avg_marks as sam on
sam.sub_id=sm.sub_id and
sm.mark>sam.avg_mark
order by st.name,sm.mark;