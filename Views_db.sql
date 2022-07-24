USE schooldb;
drop table above_avg_students;
create view above_avg_students as(
select st.name as stu_name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
inner join (select sub_id, round(avg(mark)) as avg_mark from stu_marks 
					group by sub_id) as am
	on sm.sub_id = am.sub_id and sm.mark > am.avg_mark
order by 2, 1);  
select sub_name, avg(mark) from above_avg_students
group by sub_name;

use schooldb;
create view dept_view as
	select name as dept_name, capacity
    from department;

create or replace view dept_view as
	select * from department;
    
select * from dept_view;

    
#horizontal view: for rows only
use sakila;
select * from category;

create or replace view hoe as 
select * from category
where name like 'ac%';

select * from hoe;

# with views updation , underlying table gets updated

    
    