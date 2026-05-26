-- ====================================================================
-- COMPREHENSIVE SQL TUTORIAL WITH EXPLANATIONS
-- ====================================================================
-- This script covers:
-- 1. Database context and basic operations
-- 2. SELECT statements and filtering
-- 3. Data modification (UPDATE, DELETE, INSERT)
-- 4. Table creation and relationships
-- 5. Joins and subqueries
-- 6. Aggregate functions and grouping
-- 7. Stored procedures and functions
-- 8. Backup and restore concepts
-- ====================================================================

-- ====================================================================
-- SECTION 1: DATABASE CONTEXT AND BASIC SELECTS
-- ====================================================================

-- USE: Changes the current database context
-- All subsequent queries will run against AdventureWorks2022
USE AdventureWorks2022;

-- SELECT * : Retrieves ALL columns from a table
-- The asterisk (*) is a wildcard meaning "every column"
-- FROM specifies which table to query
-- WHERE filters rows based on conditions
SELECT * 
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2021-01-01' AND '2021-04-31';
-- Note: April has 30 days, so '2021-04-31' is invalid and will cause an error
-- Correct would be '2021-04-30'


-- ====================================================================
-- SECTION 2: UPDATE OPERATIONS (Modifying existing data)
-- ====================================================================

-- UPDATE: Changes values in existing rows
-- SET: Specifies which column to change and the new value
-- GETDATE(): SQL Server function that returns current date and time
UPDATE Sales.SalesOrderHeader
SET OrderDate = GETDATE()  -- Sets OrderDate to today's date/time
WHERE [OrderDate] = '1/1/2021';  -- Only affects rows with this specific date
-- WARNING: Without WHERE clause, ALL rows would be updated!


-- ====================================================================
-- SECTION 3: SELECT AND DROP (Removing tables)
-- ====================================================================

-- Verify the changes we made
SELECT * FROM [Sales].[SalesOrderHeader];

-- DROP TABLE: Completely removes a table and all its data
-- This action is PERMANENT and cannot be undone (unless you have a backup)
DROP TABLE [Sales].[SalesOrderHeader];
-- CAUTION: DROP deletes both structure AND data, unlike TRUNCATE or DELETE


-- ====================================================================
-- SECTION 4: CREATE TABLES WITH FOREIGN KEYS (Relationships)
-- ====================================================================

-- CREATE TABLE: Defines a new table structure
-- PRIMARY KEY: Uniquely identifies each row (no duplicates, no NULLs)
CREATE TABLE Sales.storenew(
    store_id INT PRIMARY KEY,   -- Each store gets a unique ID
    sales INT                    -- Sales amount for the store
);

-- IDENTITY(1,1): Auto-incrementing column starting at 1, increasing by 1
-- FOREIGN KEY: Creates a relationship - links to parent table's PRIMARY KEY
-- REFERENCES: Specifies which table/column this foreign key points to
CREATE TABLE Sales.visits(
    visit_id INT PRIMARY KEY IDENTITY(1,1),  -- Auto-numbered visit ID
    first_name VARCHAR(50) NOT NULL,          -- REQUIRED value
    last_name VARCHAR(50) NOT NULL,           -- REQUIRED value
    visited_at DATETIME,                      -- Can be NULL
    phone VARCHAR(20),                        -- Can be NULL
    store_id INT NOT NULL,                    -- REQUIRED - which store was visited
    FOREIGN KEY (store_id) REFERENCES Sales.storenew(store_id)
    -- This ensures every store_id exists in storenew table
);

-- SELECT INTO: Creates a new table (temporary or permanent) from query results
-- #TempPersonTable: The # sign creates a TEMPORARY table (exists only for session)
SELECT BusinessEntityID, FirstName, LastName
INTO #TempPersonTable  -- Temporary table (session-scoped)
FROM [Person].[Person]
WHERE Title = 'Mr.';
-- This creates a temporary table with only Mr. records


-- ====================================================================
-- SECTION 5: VIEWS - Virtual Tables
-- ====================================================================

-- WHAT IS A VIEW?
-- A view is a stored query that acts like a virtual table
-- Benefits:
-- 1. Security: Hide sensitive columns
-- 2. Simplicity: Complex joins become simple SELECT * FROM view
-- 3. Consistency: Everyone uses same logic
-- 4. Performance: Can be indexed (indexed views)

-- Example view definition (not executed here, just explanation):
-- CREATE VIEW vw_MrPersons AS
-- SELECT BusinessEntityID, FirstName, LastName
-- FROM Person.Person
-- WHERE Title = 'Mr.';
-- Then you can query: SELECT * FROM vw_MrPersons


-- ====================================================================
-- SECTION 6: ADVANCED SELECTS WITH JOINS
-- ====================================================================

-- Basic filtered SELECT
SELECT BusinessEntityID, FirstName, LastName, Title
FROM [Person].[Person]
WHERE Title = 'Mr.';

-- TOP (100) PERCENT: Returns all rows (redundant but sometimes used in views)
-- INNER JOIN: Returns ONLY rows that have matches in BOTH tables
-- Three-table join example:
SELECT TOP (100) PERCENT
    Person.Person.FirstName,           -- Person's first name
    Person.Person.LastName,            -- Person's last name
    Person.PersonPhone.PhoneNumber,    -- Their phone number
    Person.PhoneNumberType.Name        -- Type: Cell, Home, Work
FROM Person.Person
INNER JOIN Person.PersonPhone
    ON Person.Person.BusinessEntityID = Person.PersonPhone.BusinessEntityID
    -- ON clause: How the tables are related
INNER JOIN Person.PhoneNumberType
    ON Person.PersonPhone.PhoneNumberTypeID = Person.PhoneNumberType.PhoneNumberTypeID
ORDER BY Person.Person.FirstName;  -- Sorts results alphabetically by first name


-- ====================================================================
-- SECTION 7: SELECT STATEMENT DETAILS - Column Selection
-- ====================================================================

-- SELECT *: Returns every column (convenient but not best for production)
SELECT * FROM Person.Address;

-- Explicit column list: Better performance, clearer intent
SELECT City, AddressID, ModifiedDate FROM [Person].[Address];

-- TOP 10: Limits results to first 10 rows
SELECT TOP 10 * FROM [Person].[Address];


-- ====================================================================
-- SECTION 8: SWITCHING DATABASES
-- ====================================================================

USE [AdventureWorks2019];  -- Switch to different database version
GO  -- GO is a batch separator - executes all previous commands as a unit

SELECT * FROM Person.Address;
SELECT AddressID, City, ModifiedDate FROM Person.Address;
SELECT City, AddressID, ModifiedDate FROM Person.Address;  -- Columns in any order
SELECT TOP 10 * FROM Person.Address;


-- ====================================================================
-- SECTION 9: WHERE CLAUSE FILTERING (The "row filter")
-- ====================================================================

-- Equality operator (=)
SELECT * FROM Person.Address WHERE PostalCode = '98011';

-- Not equal operators: != and <> (both work the same)
SELECT * FROM Person.Address WHERE PostalCode != '98011';
SELECT * FROM Person.Address WHERE PostalCode <> '98011';

-- COUNT(*) with WHERE: Counts only matching rows
SELECT COUNT(*) FROM Person.Address WHERE PostalCode <> '98011';

-- Date comparisons (>= and <=)
-- Dates must be in quotes and YYYY-MM-DD format recommended
SELECT * FROM Person.Address WHERE ModifiedDate >= '2013-11-08 00:00:00';
SELECT * FROM Person.Address WHERE ModifiedDate <= '2013-11-08 00:00:00';

-- LIKE pattern matching:
-- % = any number of characters (including zero)
-- _ = exactly one character
SELECT * FROM Person.Person WHERE FirstName LIKE 'Mat%';  -- Starts with "Mat"
SELECT * FROM Person.Person WHERE FirstName LIKE '%ew';   -- Ends with "ew"
SELECT * FROM Person.Person WHERE FirstName LIKE '%EW';   -- Case-insensitive by default


-- ====================================================================
-- SECTION 10: AGGREGATE FUNCTIONS (Rolling up multiple rows into one value)
-- ====================================================================

-- MAX(): Returns highest value in column
SELECT MAX(Rate) FROM HumanResources.EmployeePayHistory;
SELECT MAX(Rate) AS MaxPayrate FROM HumanResources.EmployeePayHistory;  -- With alias

-- MIN(): Returns lowest value
SELECT MIN(Rate) AS [Min Pay rate] FROM HumanResources.EmployeePayHistory;
-- Square brackets allow spaces in alias names


-- ====================================================================
-- SECTION 11: AND/OR CONDITIONS (Combining multiple filters)
-- ====================================================================

-- AND: ALL conditions must be true
SELECT * FROM Production.ProductCostHistory
WHERE StartDate = '2013-05-30 00:00:00' AND StandardCost >= 200;

-- OR: AT LEAST ONE condition must be true
-- Parentheses control order of operations (AND evaluates before OR)
SELECT * FROM Production.ProductCostHistory
WHERE (StartDate = '2013-05-30 00:00:00' AND StandardCost >= 200)
   OR ProductID > 800;

-- Both AND and OR together
SELECT * FROM Production.ProductCostHistory
WHERE (StartDate = '2013-05-30 00:00:00' AND StandardCost >= 200)
  AND ProductID > 800;

-- IN operator: Shorthand for multiple OR conditions
-- Equivalent to: ProductID = 802 OR ProductID = 803 OR ProductID = 820...
SELECT * FROM Production.ProductCostHistory
WHERE ProductID IN (802, 803, 820, 900);

-- IS NULL: Checks for missing/unknown values
-- Note: You cannot use = NULL, must use IS NULL
SELECT * FROM Production.ProductCostHistory WHERE EndDate IS NULL;

-- IS NOT NULL: Checks for existing values
SELECT * FROM Production.ProductCostHistory WHERE EndDate IS NOT NULL;


-- ====================================================================
-- SECTION 12: ORDER BY (Sorting results)
-- ====================================================================

-- ASC: Ascending (A-Z, 0-9) - this is the default
SELECT * FROM HumanResources.EmployeePayHistory ORDER BY Rate;
SELECT * FROM HumanResources.EmployeePayHistory ORDER BY Rate ASC;  -- Explicit

-- DESC: Descending (Z-A, 9-0)
SELECT * FROM HumanResources.EmployeePayHistory ORDER BY Rate DESC;

-- Combining WHERE with ORDER BY
SELECT * FROM HumanResources.EmployeePayHistory
WHERE ModifiedDate >= '2010-06-30 00:00:00'
ORDER BY ModifiedDate DESC;  -- Newest first

-- YEAR() function: Extracts year from datetime
SELECT * FROM HumanResources.EmployeePayHistory
WHERE YEAR(ModifiedDate) >= '2014'
ORDER BY ModifiedDate DESC;

-- MONTH() function: Extracts month number (1-12)
SELECT * FROM HumanResources.EmployeePayHistory
WHERE MONTH(ModifiedDate) = '06'  -- June
ORDER BY ModifiedDate DESC;


-- ====================================================================
-- SECTION 13: GROUP BY (Grouping rows for aggregation)
-- ====================================================================

-- Without GROUP BY, COUNT(*) counts ALL rows
SELECT COUNT(*), PostalCode FROM Person.Address GROUP BY PostalCode;
-- Each unique PostalCode gets its own count

-- Naming the count column with AS
SELECT COUNT(*) AS NoOfAddresses, PostalCode
FROM Person.Address
GROUP BY PostalCode
ORDER BY PostalCode;

-- Can group by multiple columns
SELECT COUNT(*), City, PostalCode
FROM Person.Address
GROUP BY City, PostalCode;

-- HAVING: Filters groups (like WHERE filters rows)
-- Difference: WHERE filters before grouping, HAVING filters after grouping
SELECT COUNT(*) AS CountOfProduct, Color, Size
FROM Production.Product
GROUP BY Color, Size
HAVING Size >= '44';  -- Only show groups where Size is 44 or larger


-- ====================================================================
-- SECTION 14: TABLE CREATION AND DELETION (Data manipulation)
-- ====================================================================

-- Drop table if exists (clean slate)
DROP TABLE IF EXISTS salesstaff;

-- Create new table with NOT NULL constraints (required values)
CREATE TABLE salesstaff
(
    staffid INT NOT NULL PRIMARY KEY,
    firstname NVARCHAR(50) NOT NULL,
    lastname NVARCHAR(50) NOT NULL,
    countryregion NVARCHAR(50) NOT NULL
);

-- INSERT INTO ... SELECT: Copy data from existing table/view
INSERT INTO salesstaff
SELECT [BusinessEntityID], [FirstName], [LastName], [CountryRegionName] 
FROM [Sales].[vSalesPerson];

-- DELETE without WHERE: Removes ALL rows (but keeps table structure)
DELETE salesstaff;  -- Or DELETE FROM salesstaff (same thing)

-- DELETE with WHERE: Removes specific rows
DELETE FROM salesstaff WHERE countryregion = 'united states';

-- TRANSACTION: Allows rollback (undo) of changes
-- BEGIN TRAN: Start transaction
-- ROLLBACK: Undo all changes since BEGIN TRAN
BEGIN TRAN
DELETE FROM salesstaff WHERE countryregion = 'united states';
ROLLBACK TRAN;  -- Changes are undone

-- COMMIT: Makes changes permanent
BEGIN TRAN
DELETE FROM salesstaff WHERE countryregion = 'united states';
COMMIT;  -- Changes are saved permanently

-- Subquery in DELETE: Delete based on another table's data
DELETE FROM salesstaff 
WHERE staffid IN (
    SELECT [BusinessEntityID] 
    FROM [Sales].[vSalesPerson] 
    WHERE SalesLastYear = 0
);

-- DELETE with JOIN: Alternative syntax using INNER JOIN
DELETE salesstaff 
FROM [Sales].[vSalesPerson] sp
INNER JOIN salesstaff ss ON sp.[BusinessEntityID] = ss.staffid
WHERE sp.saleslastyear = 0;


-- ====================================================================
-- SECTION 15: JOINS DEMONSTRATION (Combining tables)
-- ====================================================================

-- Types of JOINs explained:
-- INNER JOIN: Only matching rows from both tables
-- LEFT JOIN: All rows from left table, matching rows from right (NULL if no match)
-- RIGHT JOIN: All rows from right table, matching rows from left (NULL if no match)
-- FULL JOIN: All rows from both tables (NULLs where no match)

USE OurFirstDatabase
GO

SELECT * FROM DBO.STUDENT;
SELECT * FROM DBO.COURSE;

-- INNER JOIN: Only students who have enrolled in courses
SELECT * FROM STUDENT s
INNER JOIN COURSE c ON s.ROLLNO = c.ROLLNO;

-- LEFT JOIN: All students, even those without courses
SELECT S.ROLLNO, S.STUDENTNAME, C.COURSEID 
FROM STUDENT S
LEFT JOIN COURSE C ON S.ROLLNO = C.ROLLNO;

-- RIGHT JOIN: All courses, even those without students
SELECT S.ROLLNO, S.STUDENTNAME, C.COURSEID 
FROM STUDENT S
RIGHT JOIN COURSE C ON S.ROLLNO = C.ROLLNO;

-- FULL JOIN: Everything from both tables
SELECT S.ROLLNO, S.STUDENTNAME, C.COURSEID 
FROM STUDENT S
FULL JOIN COURSE C ON S.ROLLNO = C.ROLLNO;


-- ====================================================================
-- SECTION 16: SUBQUERIES (Query inside another query)
-- ====================================================================

-- Subquery with IN: Find employees with rate > 60
SELECT * FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory]
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID 
    FROM [HumanResources].[EmployeePayHistory] 
    WHERE Rate > 60
);

-- Subquery with = (must return exactly ONE value)
SELECT * FROM [AdventureWorks2022].[HumanResources].[EmployeePayHistory]
WHERE BusinessEntityID = (
    SELECT BusinessEntityID 
    FROM [HumanResources].[EmployeePayHistory] 
    WHERE Rate = 39.06
);

-- Subquery with IN: Products with inventory quantity >= 300
SELECT * FROM [Production].[Product]
WHERE ProductID IN (
    SELECT ProductID 
    FROM [Production].[ProductInventory] 
    WHERE Quantity >= 300
);


-- ====================================================================
-- SECTION 17: MULTIPLE INSERTS AND DATA COPYING
-- ====================================================================

-- Single row insert
INSERT INTO salesstaff (staffid, fName, lName) 
VALUES (200, 'Jabulane', 'Poulo');

-- Multiple row insert (comma-separated)
INSERT INTO salesstaff (staffid, fName, lName) 
VALUES 
    (300, 'Siya', 'Poulo'),
    (325, 'John', 'Wick'),
    (314, 'Tony', 'Stark'),
    (315, 'John', 'Snow');

-- IDENTITY column: Auto-increments automatically
CREATE TABLE salesstaffnew
(   
    ID INT NOT NULL IDENTITY PRIMARY KEY,  -- Auto-numbers: 1,2,3...
    staffid INT NOT NULL,
    fName NVARCHAR(30),
    lName NVARCHAR(30),
);

-- Inserting into table with IDENTITY - don't specify ID column
INSERT INTO salesstaffnew (staffid, fName, lName) 
VALUES 
    (300, 'Siya', 'Poulo'),
    (325, 'John', 'Wick'),
    (314, 'Tony', 'Stark'),
    (315, 'John', 'Snow');

-- INSERT with SELECT: Copy filtered data from another table
CREATE TABLE NameOnlyTable
(   
    fName NVARCHAR(30),
    lName NVARCHAR(30),
);

INSERT INTO NameOnlyTable(fName, lName)
SELECT fName, lName 
FROM salesstaffNew 
WHERE id >= 3;  -- Only copies rows 3 and above

-- SELECT INTO: Creates and populates a backup table in one step
SELECT * INTO salessaffNew_bkp 
FROM salesstaffnew;
-- This creates a new table with same structure AND data

-- TRUNCATE vs DELETE:
-- TRUNCATE: Removes ALL rows faster, resets identity counter, cannot use WHERE
-- DELETE: Can use WHERE, slower, does not reset identity
TRUNCATE TABLE salesstaff;  -- Faster, but cannot rollback in some scenarios


-- ====================================================================
-- SECTION 18: IDENTITY COLUMNS (Auto-numbering)
-- ====================================================================

-- IDENTITY(start, increment): Creates auto-numbering column
CREATE TABLE employeenew (
    id INT IDENTITY(1,1) NOT NULL,  -- Starts at 1, increases by 1
    employeename NVARCHAR(50) NOT NULL
);

INSERT INTO employeenew (employeename)
VALUES ('Money'), ('Power'), ('Respect'), ('Banana');
-- IDs will be 1,2,3,4 automatically

DELETE FROM employeenew;  -- Removes rows but next ID continues from 5
TRUNCATE TABLE employeenew;  -- Removes rows AND resets identity to 1


-- ====================================================================
-- SECTION 19: STORED PROCEDURES (Reusable SQL code blocks)
-- ====================================================================

-- Stored procedure: Precompiled SQL that can accept parameters
-- Benefits: Security, performance, code reuse, reduced network traffic

-- Basic procedure with no parameters
CREATE PROCEDURE [dbo].[SelectAllPersonAddress]
AS
BEGIN
    SELECT * FROM Person.Address;
END;
GO

-- Execute procedure
EXECUTE [dbo].[SelectAllPersonAddress];
-- Or simply: EXEC SelectAllPersonAddress

-- Drop procedure if exists
DROP PROCEDURE IF EXISTS [dbo].[SelectAllPersonAddress];

-- Procedure with input parameter
CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] 
    @City NVARCHAR(30)  -- Parameter declaration
AS
BEGIN
    SET NOCOUNT ON  -- Prevents "X rows affected" messages
    SELECT * FROM Person.Address WHERE City = @city;
END;
GO

-- Execute with named parameter (recommended)
EXEC SelectAllPersonAddressWithParams @city = 'New York';

-- Execute with positional parameter
EXEC SelectAllPersonAddressWithParams 'Miami';

-- Procedure with DEFAULT parameter value
CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] 
    @City NVARCHAR(30) = 'New York'  -- Default if not specified
AS
BEGIN
    SET NOCOUNT ON
    SELECT * FROM Person.Address WHERE City = @city;
END;
GO

-- Execute using default value
EXEC SelectAllPersonAddressWithParams;  -- Uses 'New York'

-- Procedure with WITH ENCRYPTION (hides definition from users)
CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParamswithEncryption] 
    @City NVARCHAR(30) = 'New York',
    @stateProvinceid INT
WITH ENCRYPTION  -- Users can execute but can't view the code
AS
BEGIN
    SET NOCOUNT ON
    SELECT * FROM Person.Address WHERE City = @city;
END;
GO


-- ====================================================================
-- SECTION 20: BUILT-IN FUNCTIONS (SQL Server system functions)
-- ====================================================================

-- COUNT: Number of rows
SELECT COUNT(Rate) FROM [HumanResources].[EmployeePayHistory];

-- UPPER: Converts to uppercase
PRINT UPPER('dotnet');  -- Output: DOTNET

-- CONVERT: Changes data type
PRINT CONVERT(INT, 15.56);  -- Output: 15 (truncates decimal)

-- GETDATE: Current date and time
PRINT GETDATE();  -- Output: 2026-05-25 14:30:45.123

-- DAY: Extracts day number (1-31) from date
PRINT DAY(GETDATE());  -- Output: current day number


-- ====================================================================
-- SECTION 21: USER-DEFINED FUNCTIONS (Custom functions)
-- ====================================================================

-- SCALAR FUNCTION: Returns a single value
-- Useful for calculations, formatting, or lookups
CREATE FUNCTION fnGetEmpFullName(@FirstName VARCHAR(50), @LastName VARCHAR(50))
RETURNS VARCHAR(101)
AS
BEGIN
    RETURN (SELECT @FirstName + ' ' + @LastName);
END;
GO

-- Using the scalar function in a query
SELECT 
    [dbo].fnGetEmpFullName(Firstname, Lastname) AS Fullname,
    Salary 
FROM FunctionEmployee;

-- Same result without function (inline concatenation)
SELECT 
    Firstname + ' ' + Lastname AS Fullname,
    Salary 
FROM FunctionEmployee;

-- TABLE-VALUED FUNCTION: Returns a table result set
-- Can be used like a view but with parameters
CREATE FUNCTION fnGetEmployee()
RETURNS TABLE
AS
RETURN (SELECT * FROM FunctionEmployee);
GO

-- Using table-valued function (like SELECT from a table)
SELECT * FROM fnGetEmployee();


-- ====================================================================
-- SECTION 22: BACKUP AND RESTORE (Disaster recovery concepts)
-- ====================================================================

-- Backup types explained:
-- FULL backup: Complete copy of entire database
-- DIFFERENTIAL backup: Only changes since last FULL backup
-- TRANSACTION LOG backup: Only log entries since last backup

-- Create test table for backup demonstration
CREATE TABLE SQLBackupRestoreTest (
    ID INT NOT NULL PRIMARY KEY,
    loginname VARCHAR(100) NOT NULL,
    logindate DATETIME NOT NULL DEFAULT GETDATE()
);

-- Insert sample data
INSERT INTO SQLBackupRestoreTest (ID, loginname) VALUES (1, 'test1');
INSERT INTO SQLBackupRestoreTest (ID, loginname) VALUES (2, 'test2');
-- ... (additional inserts as shown in original)

-- RESTORE DATABASE: Recovering from backup
-- NORECOVERY: Leaves database in restoring state (can apply more backups)
-- RECOVERY: Brings database online after restore
USE [master];

RESTORE DATABASE [AdventureWorks2016] 
FROM DISK = N'C:\SQL_BACKUPS\AdventureWorks2016_full.BAK' 
WITH FILE = 1,      -- Which backup set in the file
NORECOVERY,         -- Allows additional restores
NOUNLOAD, 
STATS = 5;          -- Show progress every 5%

-- Restore differential backup
RESTORE DATABASE [AdventureWorks2016] 
FROM DISK = N'C:\SQL_BACKUPS\AdventureWorks2016_diff_1.diff' 
WITH FILE = 1, NORECOVERY, NOUNLOAD, STATS = 5;

-- Restore transaction log
RESTORE LOG [AdventureWorks2016] 
FROM DISK = N'C:\SQL_BACKUPS\AdventureWorks2016_tran_3.trn' 
WITH FILE = 1, NORECOVERY, NOUNLOAD, STATS = 10;

-- Bring database online (final step)
RESTORE DATABASE [AdventureWorks2016_RestoreTest] WITH RECOVERY;

-- Point-in-time recovery (STOPAT parameter)
-- Restores to specific moment before a problem occurred
RESTORE LOG [AdventureWorks2016_RestoreTest] 
FROM DISK = N'C:\SQL_BACKUPS\AdventureWorks2016_tran_final.trn' 
WITH FILE = 1, NOUNLOAD, STATS = 10, 
STOPAT = N'2021-07-26T08:54:23';  -- Restore up to this timestamp


-- ====================================================================
-- SUMMARY: BEST PRACTICES TIPS
-- ====================================================================

/*
1. Always use explicit column lists instead of SELECT *
2. Use WHERE clauses to filter before joining when possible
3. Index columns used in WHERE, JOIN, ORDER BY
4. Use transactions for multi-step updates
5. Always backup before DROP or major UPDATE/DELETE
6. Test DELETE/UPDATE with SELECT first
7. Use parameterized queries/stored procedures to prevent SQL injection
8. Prefer JOINs over subqueries for better performance when possible
9. Use appropriate data types (don't use VARCHAR for dates)
10. Document complex logic with comments
*/