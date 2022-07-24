create database schooldb;
use schooldb;

create table department(
id tinyint primary key,
name varchar(20) not null,
capacity smallint not null);

create table students(
id smallint primary key,
name varchar(20) not null,
gender varchar(10) not null,
age tinyint not null,
dep_id tinyint not null references department(id));

create table subjects(
sub_id int primary key,
sub_name varchar(20) not null);

insert into subjects values
(1,'Java'),
(2,'Python'),
(3,'SQL'),
(4,'Web Design');

create table stu_marks(
stu_id int not null references student(id),
sub_id int not null references subjects(sub_id),
mark int not null);

select * from department;
select * from students;
select * from subjects;

select name from student order by id;
select * from  subjects;
select * from stu_marks;

#query gives avg marks of each subject
select sm.sub_id,s.sub_name, round(avg(mark))
from stu_marks sm
inner join subjects s
on s.sub_id=sm.sub_id
group by sub_id;

#creating a table of marks, subject and student name
select st.name as stu_name,s.sub_name,sm.mark
from stu_marks sm
inner join subjects s
on s.sub_id=sm.sub_id
inner join students st on
st.id=sm.stu_id;

#getting the resulyt of students who scored above than avg marks in each subject
select st.name as stu_name,s.sub_name,sm.mark
from stu_marks sm
inner join students st on st.id=sm.stu_id
inner join subjects s on s.sub_id=sm.sub_id
# avg mark of each subject
inner join (select sub_id,round(avg(mark)) as avg_mark from stu_marks
			group by sub_id) as am
            
            on sm.sub_id=am.sub_id and sm.mark>am.avg_mark
order by 2,1;


select avg(mark) as avg_mark 
					from stu_marks 
					where stu_marks.sub_id = sm.sub_id;
select st.name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
where sm.mark > (select avg(mark) as avg_mark 
					from stu_marks 
					where stu_marks.sub_id = sm.sub_id)
order by 2, 1;  


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




