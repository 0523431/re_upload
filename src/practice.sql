SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS Bookmark;
DROP TABLE IF EXISTS Comment;
DROP TABLE IF EXISTS Expense;
DROP TABLE IF EXISTS Travel;
DROP TABLE IF EXISTS Member;




/* Create Tables */

CREATE TABLE Bookmark
(
	email varchar(20) NOT NULL,
	expenseNum  NOT NULL,
	PRIMARY KEY (email, expenseNum),
	UNIQUE (email)
);


CREATE TABLE Comment
(
	comNum  NOT NULL,
	expenseNum  NOT NULL,
	email varchar(20) NOT NULL,
	comTime date,
	content varchar(210),
	PRIMARY KEY (comNum),
	UNIQUE (email)
);


CREATE TABLE Expense
(
	expenseNum  NOT NULL,
	email varchar(20) NOT NULL,
	travelNum int,
	type1 int NOT NULL,
	price int NOT NULL,
	type2 int NOT NULL,
	peocnt int NOT NULL,
	seldate int,
	selhour int,
	selminute int,
	realtime date,
	title varchar(20) NOT NULL,
	content varchar(210),
	latitude int,
	longitude int,
	img1 varchar(200),
	img2 varchar(200),
	img3 varchar(200),
	img4 varchar(200),
	PRIMARY KEY (expenseNum),
	UNIQUE (email)
);


CREATE TABLE Member
(
	email varchar(20) NOT NULL,
	password varchar(20) NOT NULL,
	nickname varchar(20) NOT NULL,
	profile varchar(200) NOT NULL,
	PRIMARY KEY (email),
	UNIQUE (email),
	UNIQUE (password),
	UNIQUE (nickname)
);


CREATE TABLE Travel
(
	travelNum int NOT NULL AUTO_INCREMENT,
	email varchar(20) NOT NULL,
	traveltitle varchar(20),
	start date,
	end date,
	currency int,
	budget int,
	background varchar(200) NOT NULL,
	PRIMARY KEY (travelNum),
	UNIQUE (email)
);



/* Create Foreign Keys */

ALTER TABLE Bookmark
	ADD FOREIGN KEY (expenseNum)
	REFERENCES Expense (expenseNum)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Comment
	ADD FOREIGN KEY (expenseNum)
	REFERENCES Expense (expenseNum)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Bookmark
	ADD FOREIGN KEY (email)
	REFERENCES Member (email)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Comment
	ADD FOREIGN KEY (email)
	REFERENCES Member (email)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Expense
	ADD FOREIGN KEY (email)
	REFERENCES Member (email)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Travel
	ADD FOREIGN KEY (email)
	REFERENCES Member (email)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE Expense
	ADD FOREIGN KEY (travelNum)
	REFERENCES Travel (travelNum)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



