Create database Travel
go 
use Travel
go
create table Person(
PID int NOT NULL,
Pname char(50),
Brith date,
Nation char(50),
Address char(50),
)

INSERT INTO Person VALUES (1,'Hoang','2002/09/11','Viet Nam','Ha Noi')
INSERT INTO Person VALUES (2,'Robert','1972/11/22','US','Kentucky')
INSERT INTO Person VALUES (3,'Giovanni','2000/04/17','Italy','San Marino')
INSERT INTO Person VALUES (4,'Leo','1991/06/05','UK','London')
INSERT INTO Person VALUES (5,'Jeanne','1999/02/27','France','Montpellier')

SELECT * FROM PERSON

create table ID(
IDID int NOT NULL,
IDprovide date,
IDexpired date,
)

insert into ID values (00241,'2017/05/19','2019/09/04')
insert into ID values (00740,'2005/07/19','2008/02/29')
insert into ID values (00930,'2016/10/24','2019/10/25')
insert into ID values (00877,'2009/11/03','2015/08/17')
insert into ID values (00129,'2007/02/08','2013/02/14')



select * from ID

create table VISA(
VID int NOT NULL,
Vprovide date,
Vexpired date,
)
insert into VISA values (9123,'2001/01/11','2013/12/10')
insert into VISA values (2996,'2004/03/01','2017/03/17')
insert into VISA values (4690,'2009/12/03','2018/11/30')
insert into VISA values (6869,'2010/07/01','2021/07/20')
insert into VISA values (2062,'2020/07/14','2026/07/13')

select * from VISA

create table Invitation(
IID int NOT NULL,
Iprovide date,
Iexpired date,
)

insert into Invitation values (5117,'2010/06/01','2011/12/14')
insert into Invitation values (2188,'2012/05/16','2013/02/04')
insert into Invitation values (1965,'2015/05/22','2015/11/17')
insert into Invitation values (7328,'2016/12/26','2018/11/26')
insert into Invitation values (6753,'2017/11/10','2019/05/31')

select * from Invitation

create table Procedur(
PID int not null, 
IDID int not null,
VID int not null,
IID int not null,
Time char(20),
Reason char(50),
Place char(50),
)

insert into Procedur values (1,00129,2062,1965,'1 week','Go to a wedding','HCM City')
insert into Procedur values (2,00241,2996,2188,'3 month','Travel','Canada - Alberta')
insert into Procedur values (3,00740,4690,5117,'10 years','Go to make a living','Australia')
insert into Procedur values (4,00877,6869,6753,'2 week','Go to meeting','Viet Nam')
insert into Procedur values (5,00930,9123,7328,'10 day','Travel','Russia - Baykit')

select * from Procedur


Alter table Procedur ADD CONSTRAINT PrID PRIMARY KEY (IID,VID,PID,IDID)
Alter table Person ADD CONSTRAINT PID PRIMARY KEY (PID)
Alter table ID ADD CONSTRAINT IDID PRIMARY KEY (IDID)
Alter table VISA ADD CONSTRAINT VID PRIMARY KEY (VID)
Alter table Invitation ADD CONSTRAINT IID PRIMARY KEY (IID)

ALTER TABLE Procedur
   ADD CONSTRAINT fk_htk_IID
   FOREIGN KEY (IID)
   REFERENCES Invitation (IID)

ALTER TABLE Procedur
   ADD CONSTRAINT fk_htk_VID
   FOREIGN KEY (VID)
   REFERENCES VISA (VID)

ALTER TABLE Procedur
   ADD CONSTRAINT fk_htk_PID
   FOREIGN KEY (PID)
   REFERENCES Person (PID)

ALTER TABLE Procedur
   ADD CONSTRAINT fk_htk_IDID
   FOREIGN KEY (IDID)
   REFERENCES ID (IDID)

-- Tính số người nhập cảnh trong ngày

select COUNT(*)as"Người nhập cảnh trong ngày" from Person

--Tính số người xuất cảnh trong ngày

select COUNT(*)as"Người xuất cảnh trong ngày" from Person

--Liệt kê số người xuất cảnh dùng hộ chiếu

select * from Procedur
where VID is null

-- Liệt kê số người nhập cảnh dùng visa

select * from Procedur
where VID is not null

--Đếm số người sử dụng XNC theo các loại giấy tờ

select count(*) as "Số người sử dụng xnc theo các loại giấy tờ" from Person
join Procedur on Person.PID = Procedur.PID
where IDID is not null

-- Đếm số người sử dụng XNC theo các loại thông tin giấy tờ cho phép xuất cảnh hoặc nhập cảnh

select count(*) as "Số người sử dụng xnc theo các loại thông tin giấy tờ cho phép xuất cảnh hoặc nhập cảnh" from Person
join Procedur on Person.PID = Procedur.PID
where IID is not null OR VID IS NOT NULL

-- Liệt kê những người nhập cảnh và quốc tịch VN
select person.PID,Pname,Brith,Nation,Address from Person 
join Procedur on Person.PID = Procedur.PID
where Place = 'Viet Nam'
-- Liệt kê những người là nam, xuất cảnh với mục đích du lịch
select person.PID,Pname,Brith,Nation,Address from Person 
join Procedur on Person.PID = Procedur.PID
where Reason = 'Travel'
