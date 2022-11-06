create database mtt;
use mtt;

drop table if exists SAILOR;
create table SAILOR
(
SID varchar(100) primary key,
NAME varchar(100) not null,
DOB date not null,
GENDER varchar(100) not null
);

drop table if exists BOAT;
create table BOAT
(
BID varchar(100) primary key,
BTYPE enum ('D','S') not null,
BNAME varchar(100) not null,
COLOUR varchar(100) not null
);

drop table if exists SAILS;
create table SAILS
(
SID varchar(100) not null,
BID varchar(100) not null,
DOT date primary key,
SHIFT enum ('FN','AN') not null,
foreign key (SID)
references SAILOR(SID),
foreign key (BID)
references BOAT(BID)
);

#a
desc SAILOR;
desc BOAT;
desc SAILS;

#b
insert into SAILOR
values('s01','jhon',date'2002-02-15','male');
insert into SAILOR
values('s02','priya',date'2000-01-15','female');
insert into SAILOR
values('s03','aditya',date'2001-03-15','male');
select * from SAILOR;

insert into BOAT
values('b01','S','ferry','red');
insert into BOAT
values('b02','S','queens','blue');
insert into BOAT
values('b03','D','merry','white');
select * from BOAT;

insert into SAILS
values('s01','b01',date'2021-06-14','FN');
insert into SAILS
values('s02','b02',date'2021-05-13','AN');
insert into SAILS
values('s03','b03',date'2021-04-12','FN');
select * from SAILS;

#d
select * from BOAT 
where BTYPE='S' and COLOUR='red';

#e
drop procedure if exists find_name;
delimiter $$
create procedure find_name(in SAILID varchar(100),out SNAME varchar(100))
begin
set SNAME=(select NAME from SAILOR where SID=SAILID);
end $$
call find_name('s01',@result);
select(@result);

#f
drop procedure if exists find_name;
delimiter $$
create procedure find_name(in SAILID varchar(100),out SNAME varchar(100))
begin
set SNAME=(select NAME from SAILOR where SID=SAILID);
if SNAME is null then
insert into msgs values ("No such value exists");
select * from msgs;
end if;
end $$
call find_name('5',@result);
select(@result);
