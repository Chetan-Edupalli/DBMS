create database tour;
use tour;

#1
Drop procedure if exists while_loop;
Delimiter $$
create procedure while_loop()
begin
declare n int;
declare x varchar(50);
set n=1;
set x='';
while n<=20 do
set x= CONCAT(x,n,',');
set n = n+2;
end while;
select x;
end$$
call while_loop();

#2
drop table if exists tourism;
create table tourism
(
ID int(50),
Place varchar(50) not null
);

drop procedure if exists ADD1;
Delimiter $$
create procedure ADD1()
begin
declare a int default 2;
declare b int;
while a<=12 do
if(a mod 2=0)then
set b=a+1;
insert into tourism values(a,concat('Place',cast(b as char)));
end if;
set a=a+1;
end while;
end$$
call ADD1();
select*from tourism;

#3
drop procedure if exists while_loop;
Delimiter $$
create procedure while_loop()
begin
declare a int default 0;
while a<=6 do
select*from tourism limit 2 offset a;
set a=a+2;
end while;
end$$
call while_loop;

#q4
drop procedure if exists tuples;
delimiter $$
create procedure tuples()
begin
declare a int default 4;
declare b int default 1;
while b<4 do
select * from tourism where id = a*b;
set b = b + 1;
end while;
end$$
call tuples();

#5
drop table if exists place_name;
create table place_name
(
name varchar(50)
);

drop procedure if exists insert_elements;
Delimiter $$
create procedure insert_elements(in var int)
begin
declare a varchar(50);
set a=(select Place from tourism where ID=var);
insert into place_name 
values(a);
end$$

drop procedure if exists copy;
Delimiter $$
create procedure copy()
begin
declare a int default 2;
declare b int default 1;
while b<=6 do
set a=a*b;
call insert_elements(a);
set b=b+2;
end while;
end $$
call copy();
select*from place_name;
