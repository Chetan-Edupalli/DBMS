create database BOOKS;
use BOOKS;

#1
create table book
(
BID int(100) primary key,
BName varchar(100),
Author_name char(100),
price int(100) not null,
Year_of_publication date
);

#3
alter table book
add unique(BName,Year_of_publication);

#4
create table publisher
(
PID int(100) primary key,
Pname varchar(100)
);

alter table book
add PID int not null,
add foreign key(PID) references publisher(PID);

#5
alter table book
add constraint rst_price check(price between 500 and 1000);

#6
alter table publisher
alter Pname set default ('Elsevier');
desc publisher;

#7
insert into publisher
values(101,default);

insert into publisher
values(102,default);

insert into book
values(1,'2states','chetan',1000,date'2021-02-15',101);

#primary key error
insert into book
(BName,Author_name,price,Year_of_publication,PID)
values('2States','chetan',1000,date'2021-02-15',101);

#Not null error
insert into book
values(1,'2states','chetan',null,date'2021-02-15',101);

#uinque error
insert into book
values(2,'2states','chetan',1000,date'2021-02-15',102);

#foreign key error
insert into book
values(2,'states','baghat',1000,date'2020-02-16',103);

#price constraint
insert into book
values(2,'states','baghat',300,date'2020-02-16',102);