drop database schooldb;

CREATE DATABASE schooldb;

USE schooldb; 

CREATE TABLE subjects
( 
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL, 
  capacity INT NOT NULL 
);

 INSERT INTO subjects 
  VALUES (1, 'English', 300), 
         (2, 'Computer', 450), 
         (3, 'Civil', 400),
         (4, 'Maths', 400),
         (5, 'History', 300);
         
CREATE TABLE student
(  
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  gender VARCHAR(50) NOT NULL,
  age INT NOT NULL  
);

INSERT INTO student
  VALUES (1, 'Jolly', 'Female', 20), 
         (2, 'Jon', 'Male', 22),
         (3, 'Sara', 'Female', 25),
         (4, 'Laura', 'Female', 18),
         (5, 'Alan', 'Male', 20),
         (6, 'Kate', 'Female', 22),
         (7, 'Joseph', 'Male', 18),
         (8, 'Mice', 'Male', 23),
         (9, 'Wise', 'Male', 21),
         (10, 'Elis', 'Female', 27);
         
select * from subjects;
select * from student;  

alter table stu_marks change  sub_id dep_id  int not null;
select st.id, st.name, sub.name, sm.mark
from stu_marks sm
inner join student st 
		on st.id = sm.stu_id
inner join subjects sub
	on sub.id = sm.sub_id;
	

## Uncorrelated Sub-query
 
SELECT * FROM
  student 
  WHERE dep_id not in
  (
    SELECT id from department WHERE dep_id < 4
  ) order by name;  
  
  SELECT id from department WHERE name in ( 'Computer', 'Maths');

select * from stu_marks;
desc student;
desc stu_marks;

## Correlated Subquery
select * from student;

alter table stu_marks change sub_id dep_id int not null;

desc stu_marks;

## Correlated Sub-query example
SELECT   st.name, sub.name, sm.mark
FROM     stu_marks sm 
  inner join student st 
  on	sm.stu_id = st.id
inner join subjects sub
	on sub.id = sm.sub_id
  WHERE    sm.mark >
  (SELECT   AVG (avg.mark)
     FROM     stu_marks avg
     WHERE      avg.sub_id = sm.sub_id) 
order by 2,1;  
     
select stu_marks.sub_id, name, avg(mark)
from stu_marks 
inner join subjects 
	on subjects.id = stu_marks.sub_id
group by stu_marks.sub_id;    

## creating a view for above average students on each subject

create or replace view above_avg_stu_marks as
SELECT   st.name as stu_name, sub.name as sub_name, sm.mark
FROM     stu_marks sm 
  inner join student st 
  on	sm.stu_id = st.id
inner join subjects sub
	on sub.id = sm.sub_id
  WHERE    sm.mark >
  (SELECT   AVG (avg.mark)
     FROM     stu_marks avg
     WHERE      avg.sub_id = sm.sub_id) 
order by 2,1;   

select * from above_avg_stu_marks
where sub_name = 'English';

select * from above_avg_stu_marks 
where stu_name in (select stu_name from above_avg_stu_marks
group by stu_name
having count(stu_name) >= 4);
     
