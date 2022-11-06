create database organization;
use organization;
create table employee
(
id int(100) primary key,
name varchar(100) not null,
age int(100),
department varchar(100),
address varchar(100),
salary int(100)
);

desc employee;

insert into employee
values(1,'Prabhat',25,'sales','Delhi',25000);
insert into employee
values(2,'Rimpa',27,'manufacturing','Mumbai',20000);
insert into employee
values(3,'Saikat',31,'manufacturing','Kolkata',30000);
insert into employee
values(4,'Sagar',29,'finance','Noida',34000);
insert into employee
values(5,'Naina',30,'finance','Kerala',29000);
insert into employee
values(6,'Rahul',28,'finance','Chennai',27000);

select * from employee;
#2
insert into employee
(id,name,age,department,address,salary)
values(7,'Raktim',25,'design','Nodia',31000);
#3
select * from employee where age<=30 and address='Mumbai';
#4
select name,age from employee where age between 25 and 27;
select name,age from employee where age in(25,27);
#5
select name,salary from employee where salary=(select min(salary) from employee);
#6
select department,count(*) from employee group by department;
#7
update employee 
set age=32 
where address='Kerala';
#8
select * from employee order by salary desc;
#9
select department, count(*) from employee 
group by department 
having count(*)>2
order by count(*)desc;
#10
select avg(salary) from employee;