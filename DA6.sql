create database company;
use company;

drop table if exists employee;
create table employee
(
eid varchar(20) not null,
name varchar(20) not null,
gender varchar(20) not null,
city varchar(20) not null,
age int not null,
doj varchar(20) not null,
salary float not null,
cid varchar(20) not null
);
desc employee;

insert into employee
values('e01','archi','female','delhi',45,'2021-02-15',60000.8,'c10'),
('e02','sumon','male','chennai',35,'2021-02-10',50000.1,'c11'),
('e03','ruchi','female','mumbai',40,'2021-02-18',55000.8,'c12'),
('e04','sameer','male','delhi',42,'2021-02-17',51000,'c10'),
('e05','prasun','male','chennai',39,'2021-02-25',65000,'c11'),
('e06','pritam','male','mumbai',38,'2021-02-26',62000,'c12');
select * from employee;

#1
drop procedure if exists EmpP
delimiter $$
create procedure EmpP(in EmpId varchar(5),out AboveAVG boolean)
begin
declare AvgSalary float default 0;
declare EmpSalary float default 0;
select avg(salary) into AvgSalary 
from employee;
select salary into EmpSalary 
from employee where eid=EmpId;
if EmpSalary>AvgSalary 
then
set AboveAVG = true;
else
set AboveAVG = false;
end if;
end$$

drop procedure if exists EmpR
delimiter $$
create procedure EmpR(in EmpId varchar(5), out result varchar(50))
begin
declare SalValue varchar(10);
call EmpP(EmpId, @isAboveAVG);
if @isAboveAVG = 0 
then
set SalValue = 'Low';
else
set SalValue = 'High';
end if;
set result = concat(EmpId," ", (select name from employee where eid = EmpId)," is getting ",SalValue," Salary");
 end$$
 
call EmpR('e01',@result); 
select @result;
call EmpR('e02',@result);
select @result;
call EmpR('e03',@result);
select @result;
call EmpR('e04',@result);
select @result;
call EmpR('e05',@result);
select @result;
call EmpR('e06',@result);
select @result;

#2
drop procedure if exists EmpA
delimiter $$
create procedure EmpA(in EmpId varchar(20), out res int)
begin
declare MaxAge int ;
declare MinAge int;
declare CurEmp int;
set MinAge = (select min(age) from employee);
set MaxAge = (select max(age) from employee);
set CurEmp = (select age from employee where eid = EmpId); 
if CurEmp = MaxAge
then
set res = 1;
elseif CurEmp = MinAge 
then
set res = 2;
else
set res = 3;
end if;
end $$

drop procedure if exists EmpF
delimiter $$
create procedure EmpF(in input varchar(20), out result varchar(100))
begin
declare status varchar(50);
call EmpA(input, @RESULT);
if @RESULT = 1 
then
set status = 'Oldest';
elseif @RESULT = 2 
then
set status = 'Youngest';
else
set status = 'neither Youngest nor Oldest';
end if;
set result = concat(input,' is ' ,status,' employee residing in ', (select city from employee where eid = input) );
end$$

call EmpF('e01',@result); 
select @result;
call EmpF('e02',@result);
select @result;
call EmpF('e03',@result);
select @result;
call EmpF('e04',@result);
select @result;
call EmpF('e05',@result);
select @result;
call EmpF('e06',@result);
select @result;