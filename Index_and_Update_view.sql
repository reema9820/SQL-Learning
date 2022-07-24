use store_sales;

select * from my_sales where sales > 50000;

insert into my_sales values ('April','Dairy',75000), ('April','Vegetables',60000);

update my_sales set
	sales = sales * (1.1)
where month = 'April';    

create or replace view monthly_product_sales_view as
select month, prod_name, sum(sales) Total_sales
from my_sales
group by month, prod_name
having sum(sales) > 90000;

select month, sum(Total_sales) 
from monthly_product_sales_view 
group by month;

create table sales (
	id int,
    qty	int,
    price float) ; 
    
alter table sales add column tot_prdt_sales float;
describe sales;
    
update sales set
	tot_prdt_sales = (qty * price);
        
select * from sales;
insert into sales values (3, 15, 15, (qty * price));
    
create table orders (
	order_id int,
    sale_value float);
    
insert into orders values (1,  
	(select sum(Total_product_sales)     
		from (select *, (qty * price) Total_product_sales
			from sales) as t));
            
select sum(Total_product_sales) from tempdb.t;     

		from (select *, (qty * price) Total_product_sales
			from sales) as t)            
select * from orders;   
select *, (qty * price) Total_product_sales
			from sales;   
insert into sales values (1, 10, 10.25), (2, 5, 101);   

select * from sales; 

select sum(Total_product_sales) from
(select *, (qty * price) Total_product_sales
from sales) t;

select * from sales;

create or replace view subset_view as
	select qty, tot_prdt_sales
    from sales
    where qty > 5;

select * from subset_view;    

select * from sales;

create or replace view sales_view as
	select * from sales
    where qty > 10;
    
select * from sales_view;   
select * from sales;

insert into sales_view values (4, 12, 25, (qty * price)), 
							(5, 20, 15, (qty * price));  
                            
select * from sales;   

create index sales_id_idx on sales(id,qty); 
alter table sales drop index sales_unique_idx;

select * from sales where id = 3 and qty > 10;

use store_sales;

select * from sales;

select id, sum(tot_prdt_sales) 
from sales
where qty >= 15
group by id
having sum(tot_prdt_sales) > (select avg(tot_prdt_sales) from sales);

select avg(tot_prdt_sales) from sales;


                        