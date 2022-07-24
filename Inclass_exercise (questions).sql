## Creating the database
create database if not exists banking;

## Using the database
use banking;

desc bank_inventory_pricing;
select * from bank_inventory_pricing;

#Q1. Print product, price, sum of quantity more than 5 sold during all three months.  
select distinct month from bank_inventory_pricing;

select 
	product, 
	ifnull(price, 0.0) as Price, 
    sum(quantity) as quantity_sold
from bank_inventory_pricing
group by product
having sum(quantity) > 5;

#Q2.Print product, quantity , month and count of records for which 
## estimated_sale_price is less than purchase_cost

select product, quantity, month, count(*) as "Count of Records"
from bank_inventory_pricing
where estimated_sale_price < purchase_cost
group by product;

#Q3. Extarct the 3rd highest value of column Estimated_sale_price 
## from bank_inventory_pricing dataset
select estimated_sale_price
from bank_inventory_pricing
order by 1 desc
limit 2,1;

#Q4. Count all duplicate values of column Product from table bank_inventory_pricing
select product, count(product) as 'Dup Count'
from bank_inventory_pricing
group by product
having count(product) > 1;

#Q5. Create a view 'bank_details' for the product 'PayPoints' and 
## Quantity is greater than 2 

create or replace view bank_details as
	select * from bank_inventory_pricing
    where product = 'PayPoints' and
		quantity > 2;

select * from bank_details;
select quantity, product from bank_inventory_pricing
where quantity > 2 and product = 'PayPoints';

#Q6 Update view bank_details1 and add new record in bank_details1.
-- --example(Producct=PayPoints, Quantity=3, Price=410.67)

create or replace view bank_details1 as
	select product, quantity, price 
    from bank_inventory_pricing;
    
insert into bank_details1 values ('PayPoints', 3, 410.67);

select * from bank_inventory_pricing where product = 'PayPoints';

#Q7.Real Profit = revenue - cost  Find for which products, branch level real profit 
## is more than the estimated_profit in Bank_branch_PL.
select 
	branch, product,
	(revenue - cost) as real_profit,
    estimated_profit
	from bank_branch_pl
order by 1, 2;

select 
	branch, 
    product, 
	sum(revenue - cost) as sum_real_profit, 
    sum(estimated_profit) as sum_est_profit
from bank_branch_pl
group by branch, product
having sum(revenue - cost) > sum(estimated_profit);

#Q8.Find the least calculated profit earned during all 3 periods
select month, min(revenue - cost)
from bank_branch_pl
group by month;

#Q9. In Bank_Inventory_pricing, 
-- a) convert Quantity data type from numeric to character 
-- b) Add then, add zeros before the Quantity field.  

## a
alter table bank_inventory_pricing modify quantity varchar(10) not null;

## b
update  bank_inventory_pricing set
	quantity = lpad(quantity,10,"0");
    
select quantity from bank_inventory_pricing limit 5;   


#Q10. Write a MySQL Query to print first_name , last_name of the titanic_ds whose first_name Contains ‘U’

#Q11.Reduce 30% of the cost for all the products and print the products whose  
##  calculated profit at branch is exceeding estimated_profit .

select branch, product, 
sum(revenue - (cost *.7)) as sum_real_profit, 
sum(estimated_profit) as sum_est_profit
from bank_branch_pl
group by branch, product
having  sum(revenue - (cost *.7)) > sum(estimated_profit);

#Q12.Write a MySQL query to print the observations from the Bank_Inventory_pricing 
## table excluding the values “BusiCard” And “SuperSave” from the column Product
select * from bank_inventory_pricing
where product not in ('BusiCard','SuperSave');

#Q13. Extract all the columns from Bank_Inventory_pricing 
## where price between 220 and 300
select * from bank_inventory_pricing
where price between 220 and 300; 

#Q14. Display all the non duplicate fields in the Product from 
## Bank_Inventory_pricing table and display first 5 records.
select distinct product from bank_inventory_pricing
limit 5;

#Q15.Update price column of Bank_Inventory_pricing with an increase of 15% 
## when the quantity is more than 3.
update bank_inventory_pricing set
	price = price * 1.15
where quantity > 3;

#Q16. Show Round off values of the price without displaying decimal scale 
##  from Bank_Inventory_pricing
select round(price), floor(price), price from bank_inventory_pricing;

#Q17.Increase the length of Product size by 30 characters from Bank_Inventory_pricing.
alter table bank_inventory_pricing modify product varchar(30) not null;

use banking;
#Q18. Add '100' in column price where quantity is greater than 3 
## and dsiplay that column as 'new_price' 
select price, quantity, case 
				when quantity > 3 then price + 100
                else price
			  end as new_price
from bank_inventory_pricing;

select price, price + 100 as new_price
from bank_inventory_pricing
where quantity > 3;

use banking;

#Q19. Display all saving account holders have “Add-on Credit Cards" and “Credit cards" 
desc bank_account_details;

select * from bank_account_details;

select customer_id, account_type, balance_amount, account_status
from bank_account_details as bad
where account_type = 'SAVINGS' and
exists (select account_type from bank_account_details bad1
		where bad1.customer_id = bad.customer_id and
				bad1.account_type = 'Credit Card') and
exists (select account_type from bank_account_details bad2
		where bad2.customer_id = bad.customer_id and
				bad2.account_type = 'Add-on Credit Card');
#Q20.
# a) Display records of All Accounts , their Account_types, the transaction amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 
# c) After retrieving all records of accounts and their linked accounts, display the  
## transaction amount of accounts appeared  in another column.
select 
	ad.customer_id, ad.account_number, 
	ad.account_type, at.transaction_amount,
	br.linking_account_number, br.account_type
from bank_account_details as ad
left join bank_account_transaction as at
on at.account_number = ad.account_number 
left join bank_account_relationship_details as br
on br.linking_account_number = ad.account_number and
	br.customer_id = ad.customer_id;
select * from bank_account_details where customer_id = 123001;
select * from bank_account_relationship_details where customer_id = 123001;

#Q21.Display all type of “Credit cards”  accounts including linked “Add-on Credit Cards" 
# type accounts with their respective aggregate sum of transaction amount. 
# Ref: Check linking relationship in bank_transaction_relationship_details.
# Check transaction_amount in bank_account_transaction. 

select ad.customer_id, ad.account_number, sum(tr.transaction_amount)
from bank_account_details as ad
inner join bank_account_transaction as tr
on tr.account_number = ad.account_number and
	ad.account_type like '%card%' 
group by customer_id;


#Q22. Compare the aggregate transaction amount of current month versus 
##  aggregate transaction with previous months.
# Display account_number, transaction_amount , 
-- sum of current month transaction amount ,
-- current month transaction date , 
-- sum of previous month transaction amount , 
-- previous month transaction date.
with monthly_cum_transactions as (
select month(transaction_date) as Months,
		account_number, sum(transaction_amount) as trn_amount
from bank_account_transaction
group by month(transaction_date) 
order by 1 desc, 2),
cur_month_tran as (
select account_number, trn_amount
 from monthly_cum_transactions
 where months = (select max(months) from monthly_cum_transactions)),
 prv_month_tran as (
 select account_number, sum(trn_amount) as trn_amount
 from monthly_cum_transactions
where Months < (select max(months) from monthly_cum_transactions)
group by account_number)
select pr.account_number, pr.trn_amount as 'Prev Trn Amount', 
		cr.trn_amount as 'Curr Trn Amount'
from prv_month_tran as pr
left join cur_month_tran cr on
	cr.account_number = pr.account_number;

#Q23.Display individual accounts absolute transaction of every next  month is greater than the previous months .

#Q24. Find the no. of transactions of credit cards including add-on Credit Cards
select count(*) 
from	bank_account_transaction tr
inner join bank_account_details ac
on tr.account_number = ac.account_number and
	ac.account_type like '%ard%';

select count(*) 
from	bank_account_transaction tr
where exists (select 1 from bank_account_details ac
where  tr.account_number = ac.account_number and
	ac.account_type like '%ard%');    
    
#Q25.From employee_details retrieve only employee_id , first_name ,last_name phone_number ,
## salary, job_id where department_name is Contracting (Note
#Department_id of employee_details table must be other than the list within IN operator.

select * from department_details;

select e.employee_id, first_name, last_name, phone_number, salary, job_id
from employee_details e
inner join department_details d
on d.department_id = e.department_id and
	d.department_name = 'Contracting';
    
#Q26. Display savings accounts and its corresponding Recurring deposits 
## transactions are more than 4 times.

select distinct account_type from bank_account_details;
with bank_trns as (select ac.customer_id, ac.account_number, 
	ac.account_type, tr.transaction_amount
from bank_account_details ac
inner join bank_account_transaction tr
on tr.account_number = ac.account_number 
where ac.account_type in ( 'SAVINGS', 'RECURRING DEPOSITS') and
	exists (select 1 from bank_account_details ac1
			where ac1.customer_id = ac.customer_id and
					ac1.account_type like 'Rec%')),
cus_more_4_tran as (
select customer_id, count(customer_id) as 'Counts'
from bank_trns 
group by customer_id 
having count(customer_id) > 4)
select * from bank_trns as b
where b.customer_id in (select customer_id from cus_more_4_tran);

#Q27. From employee_details fetch only employee_id, ,first_name, last_name , phone_number ,
## email, job_id where job_id should not be IT_PROG.
 select employee_id, first_name, last_name, phone_number, email, job_id
 from 	employee_details
 where job_id <> 'IT_PROG';
 
#Q29.From employee_details retrieve only employee_id , first_name ,last_name phone_number ,
## salary, job_id where manager_id is '60' (Note
#Department_id of employee_details table must be other than the list within IN operator.
 select employee_id, first_name, last_name, phone_number, salary, job_id
 from 	employee_details
 where department_id = 60;
 
#Q30.Create a new table as emp_dept and insert the result obtained after performing 
## inner join on the two tables employee_details and department_details.
drop table if exists emp_dept;
create table emp_dept as
	select e.*, d.department_name from employee_details e
    inner join department_details d on
    d.department_id = e.department_id;
select * from emp_dept; 

desc bank_account_transaction;
select * from bank_account_transaction;

update bank_account_transaction set
	trn_date = str_to_date(transaction_date, '%Y-%m-%d');

alter table bank_account_transaction add column trn_date date not null;
alter table bank_account_transaction drop column transaction_date;
alter table bank_account_transaction change trn_date transaction_date date not null;