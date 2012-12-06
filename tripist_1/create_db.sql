CREATE DATABASE tripist_db DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON tripist_db.* TO 'id001' IDENTIFIED BY '12345';

use tripist_db;

CREATE TABLE users (
	uid VARCHAR(15) NOT NULL PRIMARY KEY, 
	pwd VARCHAR(15) NOT NULL, 
	email VARCHAR(20) NOT NULL,
	nationality VARCHAR(20) NOT NULL,
	craretime datatime(20) NOT NULL
);

CREATE TABLE travle (
	tripid VARCHAR(10) NOT NULL PRIMARY KEY,
	startday datetime NOT NULL,
	endday datetime NOT NULL,
	tabletype VARCHAR(10) NOT NULL,
	gid VARCHAR(10) NOT NULL
);

CREATE TABLE mass (
	gid VARCHAR(15) NOT NULL PRIMARY KEY,
	uid VARCHAR(15) NOT NULL
);

