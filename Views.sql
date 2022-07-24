# using the school db database;
use schooldb;

create or replace view above_avg_students as
select st.name as stu_name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
inner join (select sub_id, round(avg(mark)) as avg_mark from stu_marks 
					group by sub_id) as am
	on sm.sub_id = am.sub_id and sm.mark > am.avg_mark
order by 2, 1;  


select * from above_avg_students
where sub_name in ( 'JAVA', 'SQL');

select stu_name, avg(mark) from above_avg_students
group by stu_name
having count(stu_name) > 2;

select sub_name, avg(mark) from above_avg_students
group  by sub_name;

desc above_avg_students;

-- create view below_avg_students as
create or replace view below_avg_students as (select st.name as stu_name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
inner join (select sub_id, round(avg(mark)) as avg_mark from stu_marks 
					group by sub_id) as am
	on sm.sub_id = am.sub_id and sm.mark < am.avg_mark
order by 2, 1); 

select sub_name, avg(mark) from below_avg_students
group  by sub_name; 

select * from department;

create or replace view dept_view (dep_name, total_students) as
	select name, capacity
    from department;
    
desc dept_view;    
    
select dep_name, total_students from dept_view where total_students > 300;    
use schooldb;
create or replace view dept_hor_view as
	select * from department;
    
select * from dept_hor_view;    

delete from dept_hor_view where id = 6;

select * from department;

insert into dept_hor_view values (6,'Economics',250);


