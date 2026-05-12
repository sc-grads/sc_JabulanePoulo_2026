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