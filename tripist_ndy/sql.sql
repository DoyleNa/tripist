create database tripist_db;
grant all on tripist_db.* to 'skehdlf' identified by 'ndi9150';


 create table users(
 userid varchar(30) primary key,
 passwd varchar(30),
 email varchar(50),
 nationality varchar(50));

 create table travel(
 tripid int auto_increment primary key,
 tripname varchar(50),
 start_day varchar(30),
 group_name varchar(50));
 
create table detail_travel(
num int auto_increment primary key,
destination varchar(50),
vehicle varchar(20),
vehicle_detail varchar(50),
to_do varchar(100),
end_day varchar(30),
tripid int,
foreign key(tripid) references travel(tripid)
on delete cascade
on update cascade
);

 create table tgroup(
 group_name varchar(50),
 userid varchar(30),
 tripid int,
 foreign key(userid) references users(userid)
 on delete cascade on update cascade,
 foreign key(tripid) references travel(tripid));
 
 insert into users(userid,passwd,email,nationality) values('doyle','skehdlf1','ndi655@gamil.com','korea');