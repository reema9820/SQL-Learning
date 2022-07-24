
#default date- time
select now(); 

#returns date part alone
select date(now()); 
#returns date part alone (current system date)
select curdate();

##ddmmyyyy
select date_format(curdate(),'%d/%m/%y');

# adding 28 days ti the current date
select date_format(adddate(curdate(),28), '%d/%m/%Y') as 'due_date';

select dayname(curdate());
select extract(YEAR from curdate() );
select year(curdate());
select date_format(curdate(),'%d %b %y');
select date_format(curdate(),'%d %b %y %a');
select date_format(curdate(),'%D %b %y %a');

#string functions
select substr('reema',1,4);

