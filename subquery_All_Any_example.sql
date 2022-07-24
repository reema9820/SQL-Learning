drop database if exists schooldb;

create database schooldb;

use schooldb;
create table department (
	id			tinyint	primary key,
    name		varchar(20)	not null,
    capacity	smallint not null
);

create table students (
	id		smallint	primary key,
    name	varchar(30)	not null,
    gender	varchar(10)	not null,
    age		tinyint	not null,
    dep_id	tinyint not null references department(id)
);

create table subjects (
	sub_id	int	primary key,	
    sub_name	varchar(20) not null);

insert into subjects values
	(1, 'Java'),
    (2, 'Python'),
    (3, 'SQL'),    
	(4, 'Web Design'); 
    
create table stu_marks (
	stu_id	int	not null references student(id),
    sub_id	int	not null references subjects(sub_id),
    mark	int	not null);

select * from department;
select * from students;    
select * from subjects;

select name from student order by id;
select * from subjects; 
select * from stu_marks;

## This query will give the average marks of each subject
select st.name as stu_name, s.sub_name, sm.mark
from stu_marks sm
inner join subjects s
	on s.sub_id = sm.sub_id
inner join students st on
	st.id = sm.stu_id;

select sm.sub_id, s.sub_name, round(avg(mark) )
from stu_marks sm
inner join subjects s
	on s.sub_id = sm.sub_id
group by sub_id;
                    
select st.name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
where sm.mark > ANY(select round(avg(mark)) from stu_marks 
					group by sub_id)
order by 2, 1; 

select st.name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
where sm.mark > ALL(select round(avg(mark)) from stu_marks 
					group by sub_id)
order by 2, 1; 

select st.name, s.sub_name, sm.mark
from stu_marks sm
inner join student st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
where sm.mark > (select max(avg_mark) 
				from (select avg(mark) as avg_mark from stu_marks 
                group by sub_id) as avg)
order by 2, 1;  

## Getting the results of students who scored above average
## marks in the respective subject.
select st.name as stu_name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
inner join (select sub_id, round(avg(mark)) as avg_mark from stu_marks 
					group by sub_id) as am
	on sm.sub_id = am.sub_id and sm.mark > am.avg_mark
order by 2, 1;  

## The same results achieved using Correlated Sub Query
#costly operation for million records
select * from stu_marks;
select * from students;
select * from subjects;
select avg(mark), stu_marks.sub_id  from stu_marks where stu_marks.sub_id = sub_id;
                    
select st.name, s.sub_name, sm.mark
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
where sm.mark > (select avg(mark) as avg_mark 
					from stu_marks 
					where stu_marks.sub_id = sm.sub_id)
order by 2, 1;  # column indexes(subname, name) # doesn't mean that it is weiteen as sub_name , name in table 


select * from stu_marks limit 5;

select * from cus_sales;

desc cus_sales;
alter table cus_sales modify CustomerId char(2) not null;

alter table stu_marks add primary key (stu_id);
alter table students modify id int not null;
alter table stu_marks add foreign key (stu_id) references students(id);
alter table stu_marks add foreign key (sub_id) references subjects(sub_id);





#avg marks in at least three subjects

select name from (select st.name
from stu_marks sm
inner join students st on st.id = sm.stu_id
inner join subjects s on s.sub_id = sm.sub_id
where sm.mark > (select max(avg_mark) 
				from (select avg(mark) as avg_mark from stu_marks 
                group by sub_id) as avg)
             )  as above_avg
group by name
having count(name) >2
order by name;

