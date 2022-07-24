use batch27;
select * from customer;

#selecting with required column
select custname, country from customer;

##select all the customers who belong to the country ----
insert into customer values (3, 'Ria', 'USA','Boston');
select custname from customer where country='USA';
select * from customer where country='USA';
