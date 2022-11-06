create database fat;
use fat;

drop table if exists CUSTOMER;
create table CUSTOMER
(
CID varchar(100) primary key,
NAME varchar(100) not null
);

drop table if exists PRODUCT;
create table PRODUCT
(
PCODE varchar(100) primary key,
PNAME varchar(100) not null,
UNIT_PRICE int(100) not null
);

drop table if exists CUST_ORDER;
create table CUST_ORDER
(
OCODE varchar(100) primary key,
ODATE date not null,
CID varchar(100) not null,
foreign key (CID)
references CUSTOMER(CID)
);

drop table if exists ORDER_PRODUCT;
create table ORDER_PRODUCT
(
OCODE varchar(100) not null,
PCODE varchar(100) not null,
NOU int(100) not null,
foreign key (OCODE)
references CUST_ORDER(OCODE),
foreign key (PCODE)
references PRODUCT(PCODE)
);

#a
desc CUSTOMER;
desc PRODUCT;
desc CUST_ORDER;
desc ORDER_PRODUCT;

#b
insert into CUSTOMER
values('c01','jhon'),
('c02','priya'),
('c03','aditya'),
('c04','rani');

insert into PRODUCT
values('p01','Laptop',90000),
('p02','Mouse',1000),
('p03','server',300000),
('p04','Air conditioner',50000);

insert into CUST_ORDER
values('c101',date'2021-02-15','c01'),
('c102',date'2021-02-14','c02'),
('c103',date'2021-02-13','c03'),
('c104',date'2021-02-12','c04');

insert into ORDER_PRODUCT
values('c101','p01',4),
('c102','p02',12),
('c103','p03',2),
('c104','p04',5);

select * from CUSTOMER;
select * from PRODUCT;
select * from CUST_ORDER;
select * from ORDER_PRODUCT;

#c
alter table PRODUCT
add constraint checkPNAME
check (PNAME ="Laptop" or PNAME ="Mouse" or PNAME ="Server" or PNAME ="Air conditioner");
#checking constraint
insert into PRODUCT
values('p05','Mobile',30000);

#d
select * from PRODUCT
where UNIT_PRICE > (select avg(UNIT_PRICE) from PRODUCT);

#e
select NAME
from CUSTOMER 
where CID = (select CID from CUST_ORDER 
where OCODE=(select OCODE from ORDER_PRODUCT 
having max(NOU)));

#f
drop procedure if exists tc;
delimiter //
create procedure tc(in PCODE varchar(100), in UNIT_PRICE int, in NOU int, out Total_cost int)
begin
declare cost float;
set cost=(select UNIT_PRICE from PRODUCT
where PRODUCT.PCODE=PCODE);
set Total_cost=cost*NOU;
end //
call tc('p01',90000,4, @RESULT);
select @RESULT;

#g
delimiter //
create trigger pc
before insert 
on PRODUCT for each row
begin
if new.PNAME='Computer' then set new.PNAME='Laptop';
end if;
end //

insert into PRODUCT values('p05','Computer',90000);
select * from PRODUCT;