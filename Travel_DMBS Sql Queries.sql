create database if not exists travel_DBMS;

use travel_DBMS;

create table Passenger ( Passenger_Id int NOT NULL AUTO_INCREMENT , Passenger_name varchar(255), 
Category varchar (50), Gender Varchar (50),Boarding_City varchar (50),
Destination_City varchar(50),Distance int ,Bus_Type varchar(50),PRIMARY KEY (Passenger_Id), 
foreign key(Bus_Type,Distance) references Price (Bus_Type,Distance));
    
Create Table Price (Bus_Type varchar(50),Distance int, price int, primary key (Bus_Type,Distance));

-- Passenger Table Values ----
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Sejal', 'AC', 'F','Bengaluru','Chennai',350,'Sleeper');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Anmol', 'Non-AC' ,'M' , 'Mumbai','Hyderabad',700,'Sitting');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values  ('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
insert into Passenger (Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type) values ('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

-- Price Table Values ---
insert into Price values ('Sleeper',350,770);
insert into Price values ('Sleeper',500,1100);
insert into Price values ('Sleeper',600,1320);
insert into Price values ('Sleeper',700,1540);
insert into Price values ('Sleeper',1000,2200);
insert into Price values ('Sleeper',1200,2640);
insert into Price values ('Sleeper',1500,2700);
insert into Price values ('Sitting',500,620);
insert into Price values ('Sitting',600,744);
insert into Price values ('Sitting',700,868);
insert into Price values ('Sitting',1000,1240);
insert into Price values ('Sitting',1200,1488);
insert into Price values ('Sitting',1500,1860);

Select * from Passenger;
Select * from Price;


-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s? ----

select Gender,count(Gender) from Passenger where Distance >=600 group by Gender ;

-- 4) Find the minimum ticket price for Sleeper Bus.

select min(price) as Min_Price from Price where Bus_Type ='Sleeper';

-- 5) Select passenger names whose names start with character 'S'

select Passenger_name from Passenger where Passenger_name like 'S%' ;

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output

select P.Passenger_name, P.Boarding_City,P.Destination_City, PR.Bus_Type,PR.Price from Passenger P 
inner join Price PR ON P.Bus_Type = PR.Bus_Type and
P.Distance = PR.Distance; 

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s

select P.Passenger_name, PR.Price from Passenger P 
inner join Price PR ON P.Bus_Type = PR.Bus_Type 
and P.Distance = PR.Distance 
and P.Distance = 1000 
and P.Bus_Type = 'Sitting' ;

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

select Bus_Type, Price from Price where distance = (select Distance from Passenger where Passenger_Name ='Pallavi' and  Boarding_City in ('Bengaluru','Panaji') and Destination_City in ('Bengaluru','Panaji'));

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select Distinct (Distance) from Passenger order by  Distance desc;

-- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables

SELECT Passenger_name, (Distance / (SELECT SUM(Distance) FROM Passenger )) * 100 AS 
Perc_distance FROM Passenger ;

-- 11) Display the distance, price in three categories in table Price

select  Distance ,Price,
CASE
WHEN Price>1000 THEN 'Expensive'
WHEN Price>500 and Price<1000 THEN 'Average Cost'
Else 'Cheap Otherwise'
End as Categories
from Price;
