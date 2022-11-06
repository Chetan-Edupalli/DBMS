create database lib;
use lib;
create table books
(
id int(1),
nam varchar(50),
price int(10)
);
show tables;
describe books;
alter table books
add primary key(id);
alter table books
add PubYear year;
alter table books
modify column price float(10,2);
alter table books
add Publisher varchar(50),
add AuthName varchar(50);
alter table books
rename column AuthName to FirstName,
add LastName varchar(50);
alter table books rename book_details;
desc book_details;
alter table book_details
drop column Publisher;
alter table book_details
modify nam varchar(50) not null;
drop table book_details;
create table books
(
id int primary key,
name varchar(50),
description blob
);
describe books;
show databases;
create table stock
(
id int primary key,
name varchar(50),
purchase int not null
);
desc stock;
show tables;

create table book
(
id int(10) primary key,
price int(100) unique
);
insert into book
values(1,200);
insert into book
values(2,500);
insert into book
values(3,700);
insert into book
values(4,1200);

select*from book;

drop tables publisher;

create table book
(
BID int(100) primary key,
BName varchar(100),
Author_name char(100),
price int(100) not null,
Year_of_publication date
);

alter table book
add unique(BName,Year_of_publication);

create table publisher
(
PID int(100) primary key,
Pname varchar(100)
);

alter table book
add PID int not null,
add foreign key(PID) references publisher(PID);

alter table book
add constraint rst_price check(price>=500 and price<=1000);

alter table publisher
modify column Pname varchar(100) default 'Elsevier';

create table book
(
BID int(100) primary key,
BName varchar(100),
Author_name char(100),
price int(100) not null,
Year_of_publication date
);

create table publisher
(
PID int(100) primary key,
Pname varchar(100)
);

alter table book
add PID int not null,
add foreign key(PID) references publisher(PID);