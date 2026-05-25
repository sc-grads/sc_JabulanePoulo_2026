-- ============================================
-- SECTION 1: DATABASE CONTEXT AND BASIC SELECTS
-- ============================================

-- Switches the current database context to AdventureWorks2022
USE AdventureWorks2022;

-- Retrieves all columns and rows from the SalesOrderHeader table
SELECT * 
FROM Sales.SalesOrderHeader

-- Filters the results to only show orders placed
-- between 1 January 2021 and 31 April 2021
-- (Note: April only has 30 days, so '2021-04-31' is invalid)
WHERE OrderDate BETWEEN '2021-01-01' AND '2021-04-31';


-- ============================================
-- SECTION 2: UPDATE OPERATIONS
-- ============================================

-- Updates the OrderDate column in the SalesOrderHeader table
-- Sets the OrderDate to the current system date and time
UPDATE Sales.SalesOrderHeader
SET OrderDate = GETDATE()

-- Only updates rows where the OrderDate is 1 January 2021
WHERE [OrderDate] = '1/1/2021';


-- ============================================
-- SECTION 3: SELECT AND DROP
-- ============================================

-- Retrieves all columns and rows again from the SalesOrderHeader table
SELECT * 
FROM [Sales].[SalesOrderHeader];

-- Permanently deletes the SalesOrderHeader table
-- including all its data and structure
DROP TABLE [Sales].[SalesOrderHeader];


-- ============================================
-- SECTION 4: CREATE TABLES WITH FOREIGN KEYS
-- ============================================

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


-- ============================================
-- SECTION 5: VIEWS CONCEPT
-- ============================================

-- what is views
-- Views are virtual tables that store SQL queries
-- They don't store data physically but show data from underlying tables


-- ============================================
-- SECTION 6: ADVANCED SELECTS WITH JOINS
-- ============================================

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
    Person.PhoneNumberType.Name
FROM Person.Person
INNER JOIN Person.PersonPhone
    ON Person.Person.BusinessEntityID =
       Person.PersonPhone.BusinessEntityID
INNER JOIN Person.PhoneNumberType
    ON Person.PersonPhone.PhoneNumberTypeID =
       Person.PhoneNumberType.PhoneNumberTypeID
ORDER BY Person.Person.FirstName;


-- ============================================
-- SECTION 7: SELECT STATEMENT DETAILS
-- ============================================

-- Retrieves all columns and all rows from the Address table
SELECT *
FROM Person.Address;

-- Retrieves only the City, AddressID, and ModifiedDate columns
SELECT City, AddressID, ModifiedDate
FROM [Person].[Address];

-- Retrieves only the first 10 rows from the Address table
SELECT TOP 10 *
FROM [Person].[Address];


-- ============================================
-- SECTION 8: ADVENTUREWORKS2019 EXAMPLES
-- ============================================

-- Switches the database context to AdventureWorks2019
USE [AdventureWorks2019];
GO

-- Retrieves all columns and rows from the Address table
SELECT * 
FROM Person.Address;

-- Retrieves only AddressID, City, and ModifiedDate columns
SELECT AddressID, City, ModifiedDate
FROM Person.Address;

-- Retrieves City, AddressID, and ModifiedDate columns in different order
SELECT City, AddressID, ModifiedDate
FROM Person.Address;

-- Retrieves only the first 10 rows from the Address table
SELECT TOP 10 *
FROM Person.Address;


-- ============================================
-- SECTION 9: WHERE CLAUSE FILTERING
-- ============================================

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

-- Date filtering examples
SELECT *
FROM Person.Address
WHERE ModifiedDate >= '2013-11-08 00:00:00';

SELECT *
FROM Person.Address
WHERE ModifiedDate <= '2013-11-08 00:00:00';

-- LIKE pattern matching
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'Mat%';

SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ew';

SELECT *
FROM Person.Person
WHERE FirstName LIKE '%EW';


-- ============================================
-- SECTION 10: AGGREGATE FUNCTIONS
-- ============================================

SELECT *
FROM HumanResources.EmployeePayHistory;

-- Maximum pay rate
SELECT MAX(Rate)
FROM HumanResources.EmployeePayHistory;

SELECT MAX(Rate) AS MaxPayrate
FROM HumanResources.EmployeePayHistory;

-- Minimum pay rate
SELECT MIN(Rate) AS [Min Pay rate]
FROM HumanResources.EmployeePayHistory;


-- ============================================
-- SECTION 11: AND/OR CONDITIONS
-- ============================================

SELECT *
FROM Production.ProductCostHistory
WHERE StartDate = '2013-05-30 00:00:00';

SELECT *
FROM Production.ProductCostHistory
WHERE StartDate = '2013-05-30 00:00:00'
AND StandardCost >= 200;

SELECT *
FROM Production.ProductCostHistory
WHERE (StartDate = '2013-05-30 00:00:00'
       AND StandardCost >= 200)
   OR ProductID > 800;

SELECT *
FROM Production.ProductCostHistory
WHERE (StartDate = '2013-05-30 00:00:00'
       AND StandardCost >= 200)
AND ProductID > 800;

-- IN operator
SELECT *
FROM Production.ProductCostHistory
WHERE ProductID IN (802, 803, 820, 900);

-- NULL checks
SELECT *
FROM Production.ProductCostHistory
WHERE EndDate IS NULL;

SELECT *
FROM Production.ProductCostHistory
WHERE EndDate IS NOT NULL;


-- ============================================
-- SECTION 12: ORDER BY
-- ============================================

SELECT *
FROM HumanResources.EmployeePayHistory
ORDER BY Rate;

SELECT *
FROM HumanResources.EmployeePayHistory
ORDER BY Rate ASC;

SELECT *
FROM HumanResources.EmployeePayHistory
ORDER BY Rate DESC;

SELECT *
FROM HumanResources.EmployeePayHistory
WHERE ModifiedDate >= '2010-06-30 00:00:00'
ORDER BY ModifiedDate DESC;

-- Date functions
SELECT *
FROM HumanResources.EmployeePayHistory
WHERE YEAR(ModifiedDate) >= '2014'
ORDER BY ModifiedDate DESC;

SELECT *
FROM HumanResources.EmployeePayHistory
WHERE MONTH(ModifiedDate) = '06'
ORDER BY ModifiedDate DESC;


-- ============================================
-- SECTION 13: GROUP BY
-- ============================================

SELECT COUNT(*), PostalCode
FROM Person.Address
GROUP BY PostalCode;

SELECT COUNT(*) AS NoOfAddresses, PostalCode
FROM Person.Address
GROUP BY PostalCode
ORDER BY PostalCode;

SELECT COUNT(*), City
FROM Person.Address
GROUP BY City;

SELECT COUNT(*), City, PostalCode
FROM Person.Address
GROUP BY City, PostalCode;

-- HAVING clause
SELECT COUNT(*) AS CountOfProduct, Color
FROM Production.Product
WHERE Color = 'Yellow'
GROUP BY Color;

SELECT COUNT(*) AS CountOfProduct, Color
FROM Production.Product
GROUP BY Color
HAVING Color = 'Yellow';

SELECT COUNT(*) AS CountOfProduct, Color, Size
FROM Production.Product
GROUP BY Color, Size
HAVING Size >= '44';


-- ============================================
-- SECTION 14: TABLE CREATION AND DELETION
-- ============================================

drop table salesstaff

create table salesstaff
(
    staffid int not null primary key,
    firstname nvarchar(50) not null,
    lastname nvarchar(50) not null,
    countryregion nvarchar(50) not null
)

-- INSERT operations
insert into salesstaff
select [BusinessEntityID],[FirstName],[LastName],[CountryRegionName] from [Sales].[vSalesPerson]

-- DELETE operations
delete salesstaff
delete from salesstaff
delete from salesstaff where countryregion = 'united states'

-- Transaction with rollback
begin tran
delete from salesstaff where countryregion = 'united states'
rollback tran

-- Transaction with commit
begin tran
delete from salesstaff where countryregion = 'united states'
commit

-- DELETE with subquery
delete from salesstaff where staffid in (select [BusinessEntityID] from [Sales].[vSalesPerson] where SalesLastYear = 0)

-- DELETE with JOIN
delete salesstaff 
from [Sales].[vSalesPerson] sp
inner join salesstaff ss
on sp.[BusinessEntityID] = ss.staffid
where sp.saleslastyear = 0


-- ============================================
-- SECTION 15: JOINS DEMONSTRATION
-- ============================================

USE OurFirstDatabase
GO

SELECT * FROM DBO.STUDENT
SELECT * FROM DBO.COURSE

-- INNER JOIN
SELECT * FROM STUDENT s
INNER JOIN COURSE c
ON s.ROLLNO = c.ROLLNO

-- LEFT JOIN
SELECT S.ROLLNO,S.STUDENTNAME, C.COURSEID FROM STUDENT S
LEFT JOIN COURSE C
ON S.ROLLNO = C.ROLLNO

-- RIGHT JOIN
SELECT S.ROLLNO, S.STUDENTNAME, C.COURSEID FROM STUDENT S
RIGHT JOIN COURSE C
ON S.ROLLNO = C.ROLLNO

-- FULL JOIN
SELECT S.ROLLNO, S.STUDENTNAME, C.COURSEID FROM STUDENT S
FULL JOIN COURSE C
ON S.ROLLNO = C.ROLLNO


-- ============================================
-- SECTION 16: SUBQUERIES
-- ============================================

SELECT * FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory]
WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM [HumanResources].[EmployeePayHistory] WHERE Rate > 60)

SELECT * FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory]
WHERE BusinessEntityID = (SELECT BusinessEntityID FROM [HumanResources].[EmployeePayHistory] WHERE Rate = 39.06)

SELECT * FROM [Production].[Product]
WHERE ProductID IN (SELECT ProductID FROM [Production].[ProductInventory] WHERE Quantity >= 300)


-- ============================================
-- SECTION 17: MULTIPLE TABLE INSERTS
-- ============================================

create table salesstaff
(   
    staffid int not null primary key,
    fName nvarchar(30) not null,
    lName nvarchar(30) not null,
)

INSERT INTO salesstaff (staffid, fName, lName) VALUES (200,'Jabulane','Poulo')
INSERT INTO salesstaff (staffid, fName, lName) VALUES (300,'Siya','Poulo'),(325,'John','Wick'),(314,'Tony','Stark'),(315,'John','Snow')

-- Table with IDENTITY
create table salesstaffnew
(   
    ID INT NOT NULL Identity Primary key,
    staffid int not null,
    fName nvarchar(30),
    lName nvarchar(30),
)

INSERT INTO salesstaffnew (staffid, fName, lName) VALUES (300,'Siya','Poulo'),(325,'John','Wick'),(314,'Tony','Stark'),(315,'John','Snow')

-- INSERT with SELECT
create table NameOnlyTable
(   
    fName nvarchar(30),
    lName nvarchar(30),
)

INSERT NameOnlyTable(fName, lName)
select fname,lname from salesstaffNew where id >= 3

-- SELECT INTO for backup
select * into salessaffNew_bkp from salesstaffnew

-- TRUNCATE vs DELETE
truncate table salesstaff


-- ============================================
-- SECTION 18: IDENTITY COLUMNS
-- ============================================

create table employeenew (
    id int identity (1,1) not null,
    employeename nvarchar(50) not null
)

insert into employeenew (employeename)
values ('Money'),('Power'),('Respect'),('Banana')

delete from employeenew
truncate table employeenew


-- ============================================
-- SECTION 19: STORED PROCEDURES
-- ============================================

-- Basic stored procedure
CREATE PROCEDURE [dbo].[SelectAllPersonAddress]
AS
SELECT * FROM Person.Address
go;

EXECUTE [dbo].[SelectAllPersonAddress]

-- Stored procedure with parameters
CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30))
AS
BEGIN
    SET NOCOUNT ON
    SELECT * FROM Person.Address where City = @city;
END
GO

EXEC SelectAllPersonAddressWithParams @city = 'New York'
EXEC SelectAllPersonAddressWithParams 'Miami'

-- Stored procedure with default parameter
CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30) = 'New York')
AS
BEGIN
    SET NOCOUNT ON
    SELECT * FROM Person.Address where City = @city;
END
GO

-- Stored procedure with encryption
CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParamswithEncryption] (@City NVARCHAR(30) = 'New York',@stateProvinceid int)
WITH ENCRYPTION
AS
BEGIN
    SET NOCOUNT ON
    SELECT * FROM Person.Address where City = @city;
END
GO


-- ============================================
-- SECTION 20: BUILT-IN FUNCTIONS
-- ============================================

select count(Rate) from [HumanResources].[EmployeePayHistory]

print upper('dotnet')
print convert(int,15.56)
print getdate()
print day(getdate())


-- ============================================
-- SECTION 21: USER-DEFINED FUNCTIONS
-- ============================================

-- Scalar function
CREATE FUNCTION fnGetEmpFullName(@FirstName varchar(50), @LastName varchar(50))
RETURNS varchar(101)
AS
BEGIN
    RETURN (SELECT @FirstName + ' ' + @LastName);
END
GO

SELECT [dbo].fnGetEmpFullName(Firstname, Lastname) as Fullname, salary 
FROM FunctionEmployee

-- Table-valued function
CREATE FUNCTION fnGetEmployee()
RETURNS TABLE
AS
RETURN (SELECT * FROM FunctionEmployee)
GO

SELECT * FROM fnGetEmployee()


-- ============================================
-- SECTION 22: BACKUP AND RESTORE DEMONSTRATION
-- ============================================

CREATE TABLE SQLBackupRestoreTest (
    ID INT NOT NULL PRIMARY KEY,
    loginname VARCHAR(100) NOT NULL,
    logindate DATETIME NOT NULL DEFAULT getdate()
)

-- Sample data for backup testing
insert into SQLBackupRestoreTest (ID,loginname) values (1, 'test1')
insert into SQLBackupRestoreTest (ID,loginname) values (2, 'test2')
-- ... continue as needed

-- RESTORE examples
USE [master]
RESTORE DATABASE [AdventureWorks2016] FROM DISK = N'C:\SQL_BACKUPS\AdventureWorks2016_full.BAK' 
WITH FILE = 1, NORECOVERY, NOUNLOAD, STATS = 5

RESTORE DATABASE [AdventureWorks2016_RestoreTest] WITH RECOVERY