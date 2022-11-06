create database business;
use business;
create table employee
(
eid varchar(100) primary key,
name varchar(100),
gender varchar(10),
city varchar(100),
age int(100),
doj date,
salary float,
cid varchar(100)
);

desc employee;

insert into employee
values('e01','archi','female','delhi',45,date'2021-02-15',60000.8,'c10');
insert into employee
values('e02','sumon','male','chennai',35,date'2021-02-10',50000.1,'c11');
insert into employee
values('e03','ruchi','female','mumbai',40,date'2021-02-18',55000.8,'c12');
insert into employee
values('e04','sameer','male','delhi',42,date'2021-02-17',51000.0,'c10');
insert into employee
values('e05','prasun','male','chennai',39,date'2021-02-25',65000.0,'c11');
insert into employee
values('e06','pritam','male','mumbai',38,date'2021-02-26',62000.0,'c12');

select*from employee;

create table customer
(
cid varchar(100),
name varchar(100),
gender varchar(100),
city varchar(100),
age int(100),
occupation varchar(100),
salary int(100),
pid varchar(100)
);

desc customer;

insert into customer
values('c10','priya','female','delhi','30','scholar',25000,'p005');
insert into customer
values('c11','ranjit','male','chennai','50','doctor',50000,'p006');
insert into customer
values('c12','shyamol','male','mumbai','35','professor',70000,'p007');

delete from customer 
where cid='c11';

select*from customer;

create table product
(
pid varchar(100),
name varchar(100),
warehouse_location varchar(100),
weight float,
price int(100)
);

desc product;

insert into product
values('p005','tv','delhi',15.2,38000);
insert into product
values('p006','ac','chennai',10.9,40000);
insert into product
values('p007','induction','delhi',2.7,28000);

select*from product;

#1
select e.eid,e.name,e.doj
from employee e
where e.doj=(select min(e.doj) from employee e);

#2
select e.name,e.salary,e.city
from employee e
where (e.city,e.salary) in (select e.city,max(e.salary) from employee e group by e.city )
order by e.salary desc;

#3
select e.eid,e.name
from employee e
where e.cid in (select c.cid from customer c ,product p 
where c.city <> p.warehouse_location and c.pid=p.pid);


#4
update employee e, product p, customer c
set e.salary=e.salary + 1000
where e.cid = (select c.cid from product p, customer c
where p.price>30000 and c.salary>30000 and p.pid=c.pid);
select*from employee;

#5
delete from employee e
where e.cid=
(select c.cid from customer c where c.age> 40);

#6
select c.cid,c.name,c.age,p.warehouse_location
from (customer c right join product p on c.pid = p.pid);