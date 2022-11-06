create database office;
use office;
drop table employee;
create table employee
(
eid varchar(100) not null,
ename varchar(100) not null,
eaddress varchar(100) not null,
emonthlysalary int(100) not null
);

#1
drop trigger if exists before_insert_salary;
delimiter //
create trigger before_insert_salary
before insert on employee for each row
begin
set new.emonthlysalary=new.emonthlysalary+100;
end //
insert into employee 
values('e01','puja','chennai',25000),
('e02','rani','gujrat',30000);
select * from employee;

#2
drop table if exists final_salary;
create table Final_salary(
eid varchar(100) not null,
ename varchar(100) not null,
eaddress varchar(100) not null,
emonthlysalary int(100) not null
);
drop trigger if exists total_salary;
delimiter //
create trigger total_salary
after insert on employee for each row
begin
insert into Final_salary(eid,ename,eaddress,emonthlysalary)
values(new.eid,new.ename,new.eaddress,new.emonthlysalary);
end //
insert into employee
values('e03','rajkumar','kolkata',20000),
('e04','ram','noida',35000);
select * from employee;
select * from final_salary;

#3
drop table if exists emp_info;
CREATE TABLE emp_info
(    
describe_change varchar(100) not null  
);  
drop trigger if exists before_update_info
delimiter //
create trigger before_update_info
before update
on employee for each row
begin
if old.eaddress <> new.eaddress then
insert into emp_info 
values(concat('trying to update eaddress.'));
end if;
if old.eid <> new.eid then
insert into emp_info 
values(concat('trying to update eid.'));
end if;
if old.ename <> new.ename then
insert into emp_info 
values(concat('trying to update ename.'));
end if;
if old.emonthlysalary <> new.emonthlysalary then
insert into emp_info 
values(concat('trying to update emonthlysalary.'));
end if;
end //
update employee set ename = 'pinki' where eid='e02';  
select * from emp_info;
update employee set eaddress = 'delhi' where eid = 'e01';
select * from emp_info;
update employee set emonthlysalary = '50000' where eid='e02';  
select * from emp_info;
update employee set eid = 'e05' where eid='e04';  
select * from emp_info;
select * from employee;

#4
drop table if exists emp_info;
CREATE TABLE emp_info
(    
describe_change varchar(150) not null  
);  
drop trigger if exists after_update_info
delimiter //
create trigger after_update_info
after update
on employee for each row
begin
if old.eaddress <> new.eaddress then
insert into emp_info 
values(concat('Previous value of eaddress is ',old.eaddress,' New Value is ', new.eaddress));
end if;
if old.eid <> new.eid then
insert into emp_info 
values(concat('Previous value of eid is ',old.eid,' New Value is ', new.eid));
end if;
if old.ename <> new.ename then
insert into emp_info 
values(concat('Previous value of ename is ',old.ename,' New Value is ', new.ename));
end if;
if old.emonthlysalary <> new.emonthlysalary then
insert into emp_info 
values(concat('Previous value of emonthlysalary is ',old.emonthlysalary,' New Value is ', new.emonthlysalary));
end if;
end //
update employee set eid = 'e04' where eid='e05';
select * from emp_info;
update employee set ename = 'rani' where eid='e01';  
select * from emp_info;
update employee set eaddress = 'Kerala' where eid = 'e02';
select * from emp_info;
update employee set emonthlysalary = '40000' where eid = 'e02';
select * from emp_info;
select * from employee;

#5
drop table total_salary_calc;
create table total_salary_calc
(
emp_total_salary int
);
insert into total_salary_calc(emp_total_salary)
select sum(emonthlysalary) from employee;
select * from total_salary_calc;

drop table if exists Final_salary;
create table Final_salary
(
descriptions varchar(100) 
);
drop trigger if exists total_salary;
delimiter //
create trigger total_salary
after delete
on employee for each row
begin
declare emp_total_salary_temp int;
set emp_total_salary_temp =  (select emp_total_salary from total_salary_calc);
update total_salary_calc set emp_total_salary = emp_total_salary_temp - old.emonthlysalary;
insert into Final_salary
values(concat('Old total Salary was ', emp_total_salary_temp ,' and after deleting the details of ', old.eid ,' , total salary is' , ( select emp_total_salary from total_salary_calc)));
end //

delete from employee where eid = 'e01';
select * from employee;
select * from Final_salary;