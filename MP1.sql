/*
drop schema if exists miniproject;
create database miniproject;
use miniproject;
DROP TABLE if exists demand;
DROP TABLE if exists ProdAvail;
DROP TABLE if exists agriproducts;
DROP TABLE if exists farm;
DROP TABLE if exists village;
DROP TABLE if exists farmer;

CREATE TABLE Village (
VillageName VARCHAR(20) not null unique,
VillageID int NOT NULL auto_increment,
primary key(VillageID)
);

create table Farmer(
FarmerName VARCHAR(20) not null,
ContactNO VARCHAR(10) unique,
FarmerID int not null auto_increment,
primary key(FarmerID)
);

create table Farm(
FarmID int not null auto_increment,
FarmAreaInAcre float,
FarmIncome int,
FarmerID int not null,
VillageID int not null,
primary key(FarmID),
FOREIGN KEY(VillageID) REFERENCES Village (VillageID) on delete cascade on update cascade,
FOREIGN KEY(FarmerID) REFERENCES Farmer (FarmerID) on delete cascade on update cascade
);

CREATE TABLE AgriProducts(
ProdID INT NOT NULL auto_increment,
ProdName VARCHAR(10) not null unique,
ExpiryInDays INT,
Rate INT,
RateDescription VARCHAR(10),
primary key(ProdID)
);

insert into agriproducts(ProdName, ExpiryInDays, Rate, RateDescription)
values
('Mango',5,250,'per dozen'),
('Cashew nut',180,700,'per killo'),
('Coconut',60,25,'per unit'),
('Betel nut',360,450,'per kilo');

CREATE TABLE ProdAvail(
FarmID INT NOT NULL,
ProdID INT NOT NULL,
Inventory INT NOT NULL,
FOREIGN KEY (FarmID) REFERENCES Farm(FarmID) on delete cascade on update cascade,
FOREIGN KEY (ProdID) REFERENCES AgriProducts(ProdID) on delete cascade on update cascade
);

create table Demand(
ProdID INT NOT NULL,
City VARCHAR(10) NOT NULL,
Quantity INT NOT NULL,
QuantityDescription VARCHAR(10),
FOREIGN KEY (ProdID) REFERENCES AgriProducts(ProdID) on delete cascade on update cascade
);

drop table if exists customerorder;
create table customerorder(
CustName VARCHAR(20) not null,
CustNo VARCHAR(10) not null,
CustCity VARCHAR(10) not null,
ReqProdID int,
ReqQuantity int not null,
Amount int not null,
foreign key (ReqProdID) references AgriProducts(ProdID) on delete cascade on update cascade
);

drop procedure if exists Hello;
delimiter $$
create procedure Hello()
begin
select 'Hello World' as Hello;
end $$
delimiter ;

drop procedure if exists FarmerInfoInsert;
delimiter //
create procedure FarmerInfoInsert(x varchar(20), y varchar(10) )
begin
insert into Farmer(FarmerName, ContactNO) values(x,y);
end //
delimiter ;

call FarmerInfoInsert('Sayli','7748465201');
-- call FarmerInfoInput('Farmer Name','Contact NO')

drop procedure if exists VillageInfoInsert;
delimiter //
create procedure VillageInfoInsert(x varchar(20))
begin
insert into village(VillageName) values(x);
end //
delimiter ;

call VillageInfoInsert('Ratnagiri');

drop procedure if exists FarmInfoInsert;
delimiter //
create procedure FarmInfoInsert(x VARCHAR(20),y VARCHAR(10),z VARCHAR(20),m int,n int)
begin
if (not exists(select FarmerID from farmer where FarmerName=x) and not exists(select FarmerID from farmer where ContactNO=y)) then
	if exists(select FarmerID from farmer where ContactNO=y) then
		select 'ContactNO is already connected to the another farmer' as error;
    end if;
    call FarmerInfoInsert(x,y);
end if;
if not exists(select VillageID from village where VillageName=z) then
    call VillageInfoInsert(z);
end if;
insert into farm(FarmerID,VillageID,FarmAreaInAcre,FarmIncome)
values(
(select FarmerID from farmer where ContactNO=y),
(select VillageID from village where VillageName=z),
m,n
);
end; //
delimiter ;

create view v1 as select FarmID,FarmerName,ContactNO,VillageName,FarmIncome from farm,farmer,village
where farmer.FarmerID=farm.FarmerID
and village.VillageID=farm.VillageID;

drop view if exists v2;
create view v2 as select FarmID,FarmerName,ContactNO,VillageName,FarmIncome,ProdName from farm,farmer,village,agriproducts
where farmer.FarmerID=farm.FarmerID
and village.VillageID=farm.VillageID;

-- call FarmInfoInsert('Farmer Name','Contact NO','Village of farm',Farm area,Farm Income)
call FarmInfoInsert('Saurabh','7745005820','Kasheli',5,54000);

-- SELECT * FROM agriproducts;
-- SELECT * FROM farm;
-- SELECT * FROM farmer;
-- SELECT * FROM prodavail;
-- SELECT * FROM demand;
-- SELECT * FROM village;

insert into village(VillageName) values
('Khedshi'),
('Nachane'),
('Bhatye'),
('Nakhare'),
('Golawali'),
('Pawas'),
('Niwendi'),
('Pomendi');
insert into farmer(FarmerName,ContactNO) values
('Aditi','5612134653'),
('Siddhi','6848611654'),
('Swaroop','8647841346'),
('Ninad','4684311313'),
('Shubham','7846331346'),
('Pranit','8478464136');
insert into farm(FarmAreaInAcre,FarmIncome,FarmerID,VillageID) values
(2.3,54260,4,4),
(4.5,98461,3,3),
(3.3,49862,5,5),
(4.1,46565,6,6),
(6.4,79161,7,7),
(4.8,65131,8,8),
(4.6,47861,1,9),
(5.2,45121,2,10),
(4.2,43211,7,4),
(2.4,65132,3,5),
(5.5,74641,2,8),
(1.2,47651,5,1);
insert into prodavail(FarmID,ProdID,Inventory) values
(2,3,180),
(2,4,200),
(3,1,150),
(3,4,179),
(4,3,156),
(4,2,134),
(5,2,113),
(5,4,99),
(6,1,77),
(6,3,74),
(7,1,125),
(7,4,78),
(8,1,167),
(8,2,95),
(9,2,128),
(9,3,193),
(10,3,95),
(10,4,69),
(11,2,76),
(11,4,55),
(12,1,46),
(12,3,38),
(13,4,25),
(13,1,49),
(1,4,86),
(1,1,132),
(1,3,46);

drop view if exists v3;
create view v3 as
select FarmerName,ContactNO,VillageName,ProdName,Inventory,REPLACE(RateDescription,'per','In') as Quantity from prodavail,farmer,agriproducts,village,farm
where prodavail.FarmID=farm.FarmID
and farm.FarmerID=farmer.FarmerID
and farm.VillageID=village.VillageID
and prodavail.ProdID=agriproducts.ProdID
order by FarmerName;

drop function if exists TotalAmount;
delimiter //
create function TotalAmount(x VARCHAR(10),y int)
returns int
deterministic
begin
declare m int;
declare n int; 
set m = (select Rate from agriproducts where ProdName=x);
set n=m*y;
return n;
end; //
delimiter ;

drop procedure if exists dailyprod;
delimiter //
create procedure dailyprod()
begin
declare x int;
declare y int;
declare z int;
declare finished int default 0;
declare c1 cursor for select ProdID,Inventory,FarmID from prodavail for update;
declare continue handler for not found set finished=1;
open c1;
cursor_c1_loop:loop
	fetch c1 into x,y,z;
    if finished=1 then
		leave cursor_c1_loop;
	end if;
    if x=1 then 
		update prodavail set Inventory=Inventory+2 where ProdID=x and FarmID=z ;
	elseif x=2 then
		update prodavail set Inventory=Inventory+2 where ProdID=x and FarmID=z ;
	elseif x=3 then
		update prodavail set Inventory=Inventory+2 where ProdID=x and FarmID=z ;
	else
		update prodavail set Inventory=Inventory+2 where ProdID=x and FarmID=z ;
	end if;
end loop cursor_c1_loop;
close c1;
end; //
delimiter ;

-- call dailyprod();


drop trigger if exists entry;
delimiter //
create trigger entry
after insert
on customerorder for each row
begin
declare x VARCHAR(10);
if not exists(select * from demand where City=new.CustCity and ProdID=new.ReqProdID) then
	set x=(select RateDescription from agriproducts where ProdID=new.ReqProdID);
    insert into demand(ProdID,City,Quantity,QuantityDescription) value
    (new.ReqProdID,new.CustCity,new.ReqQuantity,x);
else
	update demand set Quantity=Quantity+new.ReqQuantity where City=new.CustCity;
end if;
end; //
delimiter ;

drop procedure if exists placeorder;
delimiter //
create procedure placeorder(x VARCHAR(20),y VARCHAR(10),z VARCHAR(10),m VARCHAR(10), n int)
begin
declare p int;
declare q int;
if not exists(select ProdID from agriproducts where ProdName=m) then
	Select 'Sorry, Such product is not available at our inventory' as error1;
else
	set p=(select ProdID from agriproducts where ProdName=m);
    set q=TotalAmount(m,n);
    insert into customerorder values (x,y,z,p,n,q);
    if exists(
    select FarmerName,ContactNO,VillageName,ProdName,sum(Inventory) as TotQuan,REPLACE(RateDescription,'per','In') as Quantity from prodavail,farmer,agriproducts,village,farm
	where ProdName=m
	and prodavail.FarmID=farm.FarmID
	and farm.FarmerID=farmer.FarmerID
	and farm.VillageID=village.VillageID
	and prodavail.ProdID=agriproducts.ProdID
	group by FarmerName 
    having TotQuan > n
	order by FarmerName
	) then
	select FarmerName,ContactNO,VillageName,ProdName,sum(Inventory) as TotQuan,REPLACE(RateDescription,'per','In') as Quantity from prodavail,farmer,agriproducts,village,farm
	where ProdName=m
	and prodavail.FarmID=farm.FarmID
	and farm.FarmerID=farmer.FarmerID
	and farm.VillageID=village.VillageID
	and prodavail.ProdID=agriproducts.ProdID
	group by FarmerName 
    having TotQuan > n
	order by FarmerName;
    else 
		select 'Order quantity is cannot be able to deliver by single farmer' as error1;
	end if;
end if;
end; //
delimiter ;

-- call placeorder('Customer Name','Customer ContactNo','Customer's city','product name','Quantity')
-- call placeorder('Saurabh','9878568431','Ranadurg','Mango',10);
*/