use customer_info;

drop table if exists testtbl;
create table testtbl (
	id	int not null,
    col1	varchar(10));

create unique index cust_id_idx on testtbl(id); 

alter table testtbl drop index cust_id_idx;  

create index cust_id_idx on testtbl(id); 

insert into testtbl values (1, 'abc');
insert into testtbl values (2, 'def'); 

show index from testtbl;    

use sakila;

## Creating a non-unique index on title column
create index title_idx on film_text(title);

alter table film_text drop index idx_title_description;

## Use query plan to check the performace before and after index creation.
select title, description 
from film_text 
where title like 'LADY STAGE';
