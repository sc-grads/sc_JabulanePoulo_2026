-- Switches the current database context to AdventureWorks2022
USE AdventureWorks2022;

-- Retrieves all columns and rows from the SalesOrderHeader table
SELECT * 
FROM Sales.SalesOrderHeader

-- Filters the results to only show orders placed
-- between 1 January 2021 and 31 April 2021
-- (Note: April only has 30 days, so '2021-04-31' is invalid)
WHERE OrderDate BETWEEN '2021-01-01' AND '2021-04-31';


-- Updates the OrderDate column in the SalesOrderHeader table
-- Sets the OrderDate to the current system date and time
UPDATE Sales.SalesOrderHeader
SET OrderDate = GETDATE()

-- Only updates rows where the OrderDate is 1 January 2021
WHERE [OrderDate] = '1/1/2021';


-- Retrieves all columns and rows again from the SalesOrderHeader table
SELECT * 
FROM [Sales].[SalesOrderHeader];


-- Permanently deletes the SalesOrderHeader table
-- including all its data and structure
DROP TABLE [Sales].[SalesOrderHeader];



-- Create parent table first
CREATE TABLE Sales.storenew(
    store_id INT PRIMARY KEY,   -- Primary key added
    sales INT
);

-- Create child table
CREATE TABLE Sales.visits(
    visit_id INT PRIMARY KEY IDENTITY(1,1),

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,

    visited_at DATETIME,

    phone VARCHAR(20),

    store_id INT NOT NULL,

    FOREIGN KEY (store_id)
        REFERENCES Sales.storenew(store_id)
);

-- Selects specific columns from the Person table
-- and creates a temporary table called #TempPersonTable
-- containing only people with the title 'Mr.'
SELECT BusinessEntityID, FirstName, LastName
INTO #TempPersonTable
FROM [Person].[Person]
WHERE Title = 'Mr.';


what is views

-- Retrieves the BusinessEntityID, FirstName,
-- LastName, and Title columns from the Person table
-- for all people whose title is 'Mr.'
SELECT BusinessEntityID, FirstName, LastName, Title
FROM [Person].[Person]
WHERE Title = 'Mr.';

-- Selects all matching records from the joined tables
-- TOP (100) PERCENT means return all rows
SELECT TOP (100) PERCENT

    -- Retrieves the person's first name
    Person.Person.FirstName,

    -- Retrieves the person's last name
    Person.Person.LastName,

    -- Retrieves the person's phone number
    Person.PersonPhone.PhoneNumber,

    -- Retrieves the type of phone number
    -- (for example: Cell, Home, Work)
    Person.PhoneNumberType.Name

-- Main table containing person information
FROM Person.Person

-- Joins the PersonPhone table to match each person
-- with their phone numbers using BusinessEntityID
INNER JOIN Person.PersonPhone
    ON Person.Person.BusinessEntityID =
       Person.PersonPhone.BusinessEntityID

-- Joins the PhoneNumberType table to identify
-- the type of each phone number
INNER JOIN Person.PhoneNumberType
    ON Person.PersonPhone.PhoneNumberTypeID =
       Person.PhoneNumberType.PhoneNumberTypeID

-- Sorts the final results alphabetically
-- by first name
ORDER BY Person.Person.FirstName;

Select statements in details

-- Retrieves all columns and all rows
-- from the Address table
SELECT *
FROM Person.Address;


-- Retrieves only the City, AddressID,
-- and ModifiedDate columns
-- from the Address table
SELECT City, AddressID, ModifiedDate
FROM [Person].[Address];


-- Retrieves only the first 10 rows
-- from the Address table
SELECT TOP 10 *
FROM [Person].[Address];


-- Switches the database context to AdventureWorks2019
USE [AdventureWorks2019];
GO


-- Retrieves all columns and rows from the Address table
SELECT * 
FROM Person.Address;


-- Retrieves only AddressID, City, and ModifiedDate columns
SELECT AddressID, City, ModifiedDate
FROM Person.Address;


-- Retrieves City, AddressID, and ModifiedDate columns
-- in a different column order
SELECT City, AddressID, ModifiedDate
FROM Person.Address;


-- Retrieves only the first 10 rows from the Address table
SELECT TOP 10 *
FROM Person.Address;

--------------------------------------------------

-- Retrieves addresses with PostalCode = 98011
SELECT *
FROM Person.Address
WHERE PostalCode = '98011';


-- Retrieves addresses where PostalCode is not 98011
SELECT *
FROM Person.Address
WHERE PostalCode != '98011';


-- Another way to check for not equal
SELECT *
FROM Person.Address
WHERE PostalCode <> '98011';


-- Counts addresses where PostalCode is not 98011
SELECT COUNT(*)
FROM Person.Address
WHERE PostalCode <> '98011';


-- Retrieves records modified on or after 8 Nov 2013
SELECT *
FROM Person.Address
WHERE ModifiedDate >= '2013-11-08 00:00:00';


-- Retrieves records modified on or before 8 Nov 2013
SELECT *
FROM Person.Address
WHERE ModifiedDate <= '2013-11-08 00:00:00';


-- Retrieves people whose first name starts with "Mat"
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'Mat%';


-- Retrieves people whose first name ends with "ew"
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ew';


-- Retrieves people whose first name ends with "EW"
-- SQL Server is usually case-insensitive
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%EW';


-- Retrieves all employee pay history records
SELECT *
FROM HumanResources.EmployeePayHistory;


-- Retrieves the highest pay rate
SELECT MAX(Rate)
FROM HumanResources.EmployeePayHistory;


-- Retrieves the highest pay rate with an alias
SELECT MAX(Rate) AS MaxPayrate
FROM HumanResources.EmployeePayHistory;


-- Retrieves the minimum pay rate
SELECT MIN(Rate) AS [Min Pay rate]
FROM HumanResources.EmployeePayHistory;


-- Retrieves product cost history for a specific start date
SELECT *
FROM Production.ProductCostHistory
WHERE StartDate = '2013-05-30 00:00:00';


-- Retrieves products with a specific start date
-- and StandardCost greater than or equal to 200
SELECT *
FROM Production.ProductCostHistory
WHERE StartDate = '2013-05-30 00:00:00'
AND StandardCost >= 200;


-- Retrieves records that either:
-- match the date and cost condition
-- OR have ProductID greater than 800
SELECT *
FROM Production.ProductCostHistory
WHERE (StartDate = '2013-05-30 00:00:00'
       AND StandardCost >= 200)
   OR ProductID > 800;


-- Retrieves records matching all conditions
SELECT *
FROM Production.ProductCostHistory
WHERE (StartDate = '2013-05-30 00:00:00'
       AND StandardCost >= 200)
AND ProductID > 800;


-- Retrieves records where ProductID is one of the listed values
SELECT *
FROM Production.ProductCostHistory
WHERE ProductID IN (802, 803, 820, 900);


-- Retrieves records where EndDate has no value
SELECT *
FROM Production.ProductCostHistory
WHERE EndDate IS NULL;


-- Retrieves records where EndDate contains a value
SELECT *
FROM Production.ProductCostHistory
WHERE EndDate IS NOT NULL;

--------------------------------------------------

-- Retrieves employee pay history ordered by Rate ascending
SELECT *
FROM HumanResources.EmployeePayHistory
ORDER BY Rate;


-- Explicit ascending order
SELECT *
FROM HumanResources.EmployeePayHistory
ORDER BY Rate ASC;


-- Orders employee pay history by Rate descending
SELECT *
FROM HumanResources.EmployeePayHistory
ORDER BY Rate DESC;


-- Retrieves records modified after 30 June 2010
-- sorted from newest to oldest
SELECT *
FROM HumanResources.EmployeePayHistory
WHERE ModifiedDate >= '2010-06-30 00:00:00'
ORDER BY ModifiedDate DESC;


-- Retrieves records where ModifiedDate year is 2014 or later
SELECT *
FROM HumanResources.EmployeePayHistory
WHERE YEAR(ModifiedDate) >= '2014'
ORDER BY ModifiedDate DESC;


-- Retrieves records where the month is June
SELECT *
FROM HumanResources.EmployeePayHistory
WHERE MONTH(ModifiedDate) = '06'
ORDER BY ModifiedDate DESC;

--------------------------------------------------

-- Retrieves addresses with PostalCode 98011
SELECT *
FROM Person.Address
WHERE PostalCode = '98011';


-- Counts addresses with PostalCode 98011
SELECT COUNT(*)
FROM Person.Address
WHERE PostalCode = '98011';


-- Counts addresses grouped by PostalCode
SELECT COUNT(*), PostalCode
FROM Person.Address
GROUP BY PostalCode;


-- Counts addresses grouped by PostalCode
-- and renames the count column
SELECT COUNT(*) AS NoOfAddresses, PostalCode
FROM Person.Address
GROUP BY PostalCode;


-- Counts addresses grouped by PostalCode
-- and sorts by PostalCode
SELECT COUNT(*) AS NoOfAddresses, PostalCode
FROM Person.Address
GROUP BY PostalCode
ORDER BY PostalCode;


-- Counts addresses grouped by City
SELECT COUNT(*), City
FROM Person.Address
GROUP BY City;


-- Counts addresses grouped by both City and PostalCode
SELECT COUNT(*), City, PostalCode
FROM Person.Address
GROUP BY City, PostalCode;

--------------------------------------------------

-- Retrieves all products
SELECT *
FROM Production.Product;


-- Counts yellow products grouped by Color
SELECT COUNT(*) AS CountOfProduct, Color
FROM Production.Product
WHERE Color = 'Yellow'
GROUP BY Color;


-- Groups products by Color
-- then filters groups to only Yellow
SELECT COUNT(*) AS CountOfProduct, Color
FROM Production.Product
GROUP BY Color
HAVING Color = 'Yellow';


-- Counts products grouped by Color and Size
-- only showing groups where Size >= 44
SELECT COUNT(*) AS CountOfProduct, Color, Size
FROM Production.Product
GROUP BY Color, Size
HAVING Size >= '44';

drop table salesstaff

-----------------------------------------

create table salesstaff
(
staffid int not null primary key,
firstname nvarchar(50) not null,
lastname nvarchar(50) not null,
countryregion nvarchar(50) not null
)

----------------------------------------------

insert into salesstaff
select [BusinessEntityID],[FirstName],[LastName],[CountryRegionName] from [Sales].[vSalesPerson]

-------------------------------------

delete salesstaff

----------------------


delete from salesstaff

--------------------------

delete from salesstaff where countryregion =  'united states'

-----------------------------
begin tran
delete from salesstaff where countryregion =  'united states'

rollback tran

------------------------------

begin tran
delete from salesstaff where countryregion =  'united states'

commit

------------------------

delete from salesstaff where staffid in (select [BusinessEntityID] from [Sales].[vSalesPerson] where SalesLastYear = 0)

-------------------------------------

delete salesstaff 
from  [Sales].[vSalesPerson] sp
inner join salesstaff ss
on sp.[BusinessEntityID] = ss.staffid
where sp.saleslastyear = 0

USE OurFirstDatabase
GO
SELECT * FROM DBO.STUDENT
GO

SELECT * FROM DBO.COURSE

SELECT * FROM STUDENT s
INNER JOIN COURSE c
ON s.ROLLNO = c.ROLLNO

SELECT S.ROLLNO,S.STUDENTNAME, C.COURSEID FROM STUDENT S
LEFT JOIN COURSE C
ON S.ROLLNO = C.ROLLNO

SELECT S.ROLLNO, S.STUDENTNAME, C.COURSEID FROM STUDENT S
RIGHT JOIN COURSE C
ON S.ROLLNO = C.ROLLNO

SELECT S.ROLLNO, S.STUDENTNAME, C.COURSEID FROM STUDENT S
FULL JOIN COURSE C
ON S.ROLLNO = C.ROLLNO

--[AdventureWorks2022].[HumanResources].[EmployeePayHistory]
--[Production].[Product]
--[Production].[ProductInventory]

SELECT * FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory]
WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM [HumanResources].[EmployeePayHistory] WHERE Rate > 60 )



--ALL TABLES GET CREATED IN DBO SCHEMA UNLESS WE CREATE A NEW SCHEMA

SELECT * FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory]
WHERE BusinessEntityID = (SELECT BusinessEntityID FROM [HumanResources].[EmployeePayHistory] WHERE Rate = 39.06 )

SELECT * FROM [Production].[Product]
WHERE ProductID IN (SELECT ProductID FROM [Production].[ProductInventory] WHERE Quantity >= 300)


create table salesstaff
(   
     staffid int not null primary key,
     fName nvarchar(30) not null,
     lName nvarchar(30) not null,
)

INSERT INTO salesstaff (staffid, fName, lName) VALUES (200,'Jabulane','Poulo')

SELECT * FROM salesstaff

INSERT INTO salesstaff (staffid, fName, lName) VALUES (300,'Siya','Poulo'),(325,'John','Wick'),(314,'Tony','Stark'),(315,'John','Snow')

create table salesstaffnew
(   
     ID INT NOT NULL Identity Primary key,
     staffid int not null,
     fName nvarchar(30) ,
     lName nvarchar(30) ,
)

INSERT INTO salesstaff (staffid, fName, lName) VALUES (300,'Siya','Poulo'),(325,'John','Wick'),(314,'Tony','Stark'),(315,'John','Snow')

SELECT * FROM salesstaffNew

INSERT INTO salesstaffnew (staffid, fName, lName) VALUES (300,'Siya','Poulo'),(325,'John','Wick'),(314,'Tony','Stark'),(315,'John','Snow')

create table NameOnlyTable
(   
     
     fName nvarchar(30) ,
     lName nvarchar(30) ,
)

Select * from NameOnlyTable

INSERT NameOnlyTable( fName, lName)
select fname,lname from salesstaffNew where id >= 3

select * into salessaffNew_bkp from salesstaffnew

select * from salessaffNew_bkp

select * from salesstaff
truncate  table salesstaff

create table employeenew (
id int identity (1,1) not null,
employeename nvarchar(50) not null
)

insert into employeenew
(employeename)
values ('Money'),('Power'),('Respect'),('Banana')

select * from employeenew

delete from employeenew

truncate table  employeenew

CREATE PROCEDURE [dbo].[SelectAllPersonAddress]
AS
SELECT * FROM  Person.Address
go;

GO

execute [dbo].[SelectAllPersonAddress]

drop procedure [dbo].[SelectAllPersonAddress]


CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30))
AS

BEGIN
SET NOCOUNT ON

SELECT * FROM  Person.Address where City = @city;

END
GO


exec SelectAllPersonAddressWithParams @city = 'New York'

exec SelectAllPersonAddressWithParams 'Miami'


drop procedure [SelectAllPersonAddressWithParams]


CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30) = 'New York')
AS

BEGIN
SET NOCOUNT ON

SELECT * FROM  Person.Address where City = @city;

END
GO


exec SelectAllPersonAddressWithParams 'Miami'


CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30) = 'New York',@stateProvinceid int)
AS

BEGIN
SET NOCOUNT ON

SELECT * FROM  Person.Address where City = @city;

END
Go;

CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParamswithEncryption] (@City NVARCHAR(30) = 'New York',@stateProvinceid int)
AS

BEGIN
SET NOCOUNT ON

SELECT * FROM  Person.Address where City = @city;

END
GO


select count(Rate)
   from [HumanResources].[EmployeePayHistory]

   print upper('dotnet')
   print convert(int,15.56)
   print getdate()
   print day(getdate())

CREATE TABLE [dbo].[FunctionEmployee](
	[EmpID] [int] NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Salary] [int] NULL,
	[Address] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

insert into [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) values (1,'Abbas','Mehmood', 20000, 'Delhi')
insert into [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) values (2,'Imran','Afzal', 50000, 'Delhi')
insert into [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) values (3,'James','Dino', 90000, 'Delhi')
insert into [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) values (4,'Jaga','Babu', 70000, 'Delhi')

select * from [dbo].[FunctionEmployee]

Create function fnGetEmpFullName
( @FirstName varchar(50), @LastName varchar(50))
returns varchar(101)
As
begin
return (select @FirstName + ' '+@LastName);
end
GO

select [dbo].fnGetEmpFullName (Firstname,Lastname) as Fullname , salary from FunctionEmployee

select firstname + ' ' +lastname as Fullname , salary from FunctionEmployee


create function fnGetEmployee()
returns Table
As
return (select * from FunctionEmployee)
GO

select * from fnGetEmployee()