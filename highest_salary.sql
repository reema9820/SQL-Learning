select * from customer_info.employee1;
use customer_info;
## Select the 2nd highest salary 

select salary from employee1
order by salary desc;

select salary from (select salary from employee1
order by salary desc limit 2) sal
order by salary 
limit 1;

select salary from employee1
order by salary desc
limit 3;

use customer_info;

select min(sales) 
from (select sales from product_sales order by 1 desc limit 3) sal;

## Selecting 3rd highest value (first method)
select sales 
from (select sales from product_sales 
	order by sales desc
    limit 3) as sal
order by 1
limit 1;    

## 3rd highest sale value (another method)
select sales from product_sales 
	order by sales desc
    limit 2,1;
    
## 3rd lowest sale value (another method)
select sales from product_sales 
	order by sales 
    limit 2,1;
    
## nth highest sale value (another method)
select sales from product_sales 
	order by sales desc
    limit n-1,1;