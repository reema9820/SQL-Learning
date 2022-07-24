use batch27;

select * from customer;
select * from orders;
insert into customer values (2, 'ABCD', 'India','Bangalore');
insert into orders values (1, str_to_date('2022/07/07','%Y/%m/%d'), 10, 1),
	(2, str_to_date('2022/07/06','%Y/%m/%d'), 20, 2);
desc orders;

alter table orders add column product_id smallint null after order_date,
add column unit_price decimal(10,2) null after product_id;
select * from orders;

## Updating the Values for newldy add column
##UPDATE table_name SET column1 = value1, column2 = value2,... WHERE condition;
update orders set
product_id=1,
unit_price=15.75
where order_id=2;
select * from orders;

insert into orders values (3, str_to_date('2022/07/07','%Y/%m/%d'), 3, 21.25, 5, 1),
	(4, str_to_date('2022/07/06','%Y/%m/%d'), 3, 21.25, 3, 2);
    
select * from orders;

# deleting particular order
delete from orders 
where order_id =4;
select * from orders;








