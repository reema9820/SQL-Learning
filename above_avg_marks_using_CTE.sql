use schooldb;

## Getting above average marks students for each subjects
## using CTE.

with sub_avg_marks as (
	select sub_id, avg(mark) as avg_mark
    from stu_marks
    group by sub_id )
select st.name as student_name, sb.sub_name as subject_name, sm.mark
from stu_marks sm
inner join students as st on
	st.id = sm.stu_id
inner join subjects as sb on
	sb.sub_id = sm.sub_id
inner join sub_avg_marks as sam on
	sam.sub_id = sm.sub_id and
    sm.mark > sam.avg_mark
order by st.name, sm.mark;


with avg_marks as(
select sub_id, avg(mark) as avg_mark from stu_marks group by sub_id)
select stu.name,sm.mark,s.sub_name
from students as stu
inner join stu_marks as sm
on stu.id=sm.sub_id
inner join subjects as s
on s.sub_id=sm.sub_id
inner join avg_marks as sam 
on sam.sub_id=sm.sub_id and sm.mark>sam.avg_mark
order by stu.name, sm.mark;


