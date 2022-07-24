use customer_info;

select * from products;

create table products_auditlog as
	select *, now() last_update from products;

    
delimiter //

create trigger prd_insert_trig 
	before insert on products for each row
begin
	if new.discount < 0 then
		set new.discount = null;
	end if;
end //

delimiter //
     
create trigger prd_update_trig 
	before update on products for each row
begin
	insert into products_auditlog values
		(old.prdid, old.prdname, old.price, old.discount, now());
end //

delimiter //
create trigger prd_delete_trig
	after delete on products for each row
begin
	insert into products_auditlog values
		(old.prdid, old.prdname, old.price, old.discount, now());
end //    
    
delimiter ;       
        
insert into products (prdname, price, discount)
	values ('123',23.90, -10.0), ('456',23.56,15);
    
update products set 
		discount = 10
where prdid = 1;   

delete from products where prdid = 7;
     
select * from products;    
select * from products_auditlog;    

show triggers;
