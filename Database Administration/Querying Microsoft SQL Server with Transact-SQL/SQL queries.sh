--Creating a table using T-SQL
------------------------------------------

create table tblSecond
(myNunbers int)

--Inserting data into the table

insert into tblSecond values (767)
insert into tblSecond values (677),(454),(345)

--retrieving data from the table

select myNunbers from tblSecond

select * from tblFirst

--deleting data from the table

Delete  from tblFirst 
truncate table tblFirst
Drop table tblFirst
drop table tblSecond

--Creating temporary varibles
-----------------------------------------
declare @myvar as int = 2

set @myvar = 3

select @myvar as myvarible


declare @myvar as int = 2

set @myvar = @myvar + 1

select @myvar as myvarible


declare @myvar as int = 2

set @myvar = @myvar * 4 +1

select @myvar as myvarible

--Integers numbers
-----------------------------------------

declare @myvar as tinyint = 2

set @myvar = @myvar - 3

select @myvar as myvarible

Msg 220, Level 16, State 2, Line 12
Arithmetic overflow error for data type tinyint, value = -1.

--Mathematical functions
-----------------------------------------

declare @myvar as numeric(7,2) = 3

select power(@myvar,3)
select square(@myvar)
select power (@myvar, 0.5)
select sqrt (@myvar)
go

declare @myvar as numeric(7,2) = 12.345

select floor(@myvar) as myfloor
select ceiling(@myvar) as myCeiling
select round(@myvar,0) as myRound

select PI() as myPI
select EXP(1) as e

declare @myvar as numeric(7,2) = 456

select ABS(@myvar) as myABS, SIGN(@myvar) as mySign
go

select RAND(4565)

--Converting between numbers types
-----------------------------------------------
--Implicit

declare @myvar as Decimal(5,2) = 3

select @myvar

--explicit

select convert(decimal(4,2),3)/2
select cast(3 as decimal(5,2))/2

select convert(decimal(6,2),1000)

select convert(int,12.345)+convert(int,12.7)
select convert (int,12.345 + 12.7)

--Practice Activity Number 4 - Solution 
-----------------------------------------------

select system_type_id,column_id, round(system_type_id * 1.0000 / column_id,1 ) as Calculation from sys.all_columns

select system_type_id,column_id, try_convert (tinyint,system_type_id * 2) as Calculation from sys.all_columns


--Strings

declare @chrMyCharacters as char(10)

set @chrMyCharacters = 'Hello€'

select @chrMycharacters as myString, len(@chrMycharacters) as MyLength, DATALENGTH(@chrMyCharacters) as myDataLength

declare @chrMyCharacters as varchar(10)

set @chrMyCharacters = N'Hello€'

select @chrMycharacters as myString, len(@chrMycharacters) as MyLength, DATALENGTH(@chrMyCharacters) as myDataLength


declare @chrMyCharacters as nvarchar(10)

set @chrMyCharacters = N'Hello€'

select @chrMycharacters as myString, len(@chrMycharacters) as MyLength, DATALENGTH(@chrMyCharacters) as myDataLength

--NULL -an introduction

declare @myvar as int

select @myvar as myCol

declare @myString as nvarchar(20)

select datalength(@myString) as myString

declare @mydecimal decimal(5,2)
select try_convert(decimal(5,2),1000)
select try_cast(1000 as decimal(5,2))

--Joining two strings together


declare @firstname as nvarchar(20)
declare @middlename as nvarchar(20)
declare @lastname as nvarchar(20)

set @firstname = 'John'
set @middlename = 'Walker'
set @lastname = 'Smith'

select @firstname + '  '+ @middlename +'  '+ @lastname as Fullname

declare @firstname as nvarchar(20)
declare @middlename as nvarchar(20)
declare @lastname as nvarchar(20)

set @firstname = 'John'
set @middlename = 'Walker'
set @lastname = 'Smith'

select @firstname + ' ' + ISNULL(@middlename, '') + '  ' + @lastname as Fullname

declare @firstname as nvarchar(20)
declare @middlename as nvarchar(20)
declare @lastname as nvarchar(20)

set @firstname = 'John'
set @lastname = 'Smith'

select @firstname + CASE WHEN @middlename IS NULL THEN ' ' ELSE ' ' + @middlename END + '  ' + @lastname as Fullname

select @firstname + ' ' + coalesce(' '+ @middlename,' ') + ' ' + @lastname as fullname

select concat (@firstname, ' ' + @middlename, ' ', @lastname) as Fullname

--Joining a string to a number


select 'My Number is: ' + convert(varchar(20), 4567)
select 'My Number is: ' + cast(4567 as varchar(20)) 

select 'MY salary is: $' + convert(varchar(20),2345.6) --work, but not well
select 'My salary is: ' + format(2345.6,'C','en-GB')
select 'My salary is: ' + format(2345.6,'C','fr-FR')


Practice Activity Number 5 - The Solution

select [name] + 'A'
from sys.all_columns

select [name] + N'Ⱥ'
from sys.all_columns

select substring([name],2,len([name])-1) as [name]
from sys.all_columns

select substring([name],1,len([name])-1) as [name]
from sys.all_columns


--Setting dates and date extraction

declare @mydate as datetime = '2015-06-24 12:34:56.124'
select @mydate as MyDate

declare @mydate2 as datetime(3) = '20150624 12:34:56.124'
select @mydate as MyDate

select datefromparts(2015,06,24) as ThisDate
select datetime2fromparts(2015,06,24,12,34,56,124,3) as ThatDate
select year(@mydate) as myYear, month(@mydate) as myMonth, day(@mydate) as myDay

--Today's date, and more date functions

select current_timestamp as RightNow
select getdate() as RightNow
select sysdatetime()  as RightNow
select dateadd(Year,1,'2015-01-02 03:04:05') as myYear
select datepart(hour,'2015-01-02 03:04:05') as myHour
select datename(weekday, getdate()) as myHour
select datediff(second,'2015-01-02 03:04:05', getdate()) as SecondsElapsed

--Join query
select * from tblEmployee
join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber

select tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName, Amount
from tblEmployee
join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber

select tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName,sum(Amount) as SumOfAmount
from tblEmployee
join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName
order by tblEmployee.EmployeeNumber

--Different types of joins
select tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName,sum(Amount) as SumOfAmount
from tblEmployee
left join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName
order by tblEmployee.EmployeeNumber

select tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName,sum(Amount) as SumOfAmount
from tblEmployee
right join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName
order by tblEmployee.EmployeeNumber

select tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName,sum(Amount) as SumOfAmount
from tblEmployee
inner join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName
order by tblEmployee.EmployeeNumber

select tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName,sum(Amount) as SumOfAmount
from tblEmployee
full outer join tblTransaction
on tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
group by tblEmployee.EmployeeNumber, EmployeeFirstName, EmployeeLastName
order by tblEmployee.EmployeeNumber

--creating a third table

select distinct Department, '' as DepartmentHead into
 tblDepartment
from tblEmployee


--Joining three tables
select * from tblDepartment
join tblEmployee
on tblDepartment.Department = tblEmployee.Department
join tblTransaction
on tblEmployee.employeeNumber = tblTransaction.EmployeeNumber

select tblDepartment.Department,DepartmentHead, sum(Amount) as SumOfAmount
from tblDepartment
left join tblEmployee
on tblDepartment.Department = tblEmployee.Department
left join tblTransaction
on tblEmployee.employeeNumber = tblTransaction.EmployeeNumber
group by tblDepartment.Department, DepartmentHead

select tblDepartment.Department,DepartmentHead, sum(Amount) as SumOfAmount
from tblDepartment
left join tblEmployee
on tblDepartment.Department = tblEmployee.Department
left join tblTransaction
on tblEmployee.employeeNumber = tblTransaction.EmployeeNumber
group by tblDepartment.Department, DepartmentHead
order by DepartmentHead

--Unique constraints

alter table tblEmployee
add constraint UQ_EmployeeNumber UNIQUE(EmployeeGonvernmentID)

--Default constraints

alter table tblTransaction
add constraint defDateOfEntry Default getdate() for DateOfEntry;


--Check constraints

alter table tblTransaction
add constraint chkAmount check (Ammount >-1000 and Amount < 1000)

--Primary keys

alter table tblEmployee
add constraint PK_tblEmployee Primary key (EmployeeNumber)


--Foreign key  in practice
BEGIN TRAN
ALTER TABLE tblTransaction ALTER COLUMN EmployeeNumber INT NULL 
ALTER TABLE tblTransaction ADD CONSTRAINT DF_tblTransaction DEFAULT 124 FOR EmployeeNumber
ALTER TABLE tblTransaction WITH NOCHECK
ADD CONSTRAINT FK_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber)
REFERENCES tblEmployee(EmployeeNumber)
ON UPDATE CASCADE
ON DELETE set default
--UPDATE tblEmployee SET EmployeeNumber = 9123 Where EmployeeNumber = 123
DELETE tblEmployee Where EmployeeNumber = 123

SELECT E.EmployeeNumber, T.*
FROM tblEmployee as E
RIGHT JOIN tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.Amount IN (-179.47, 786.22, -967.36, 957.03)

ROLLBACK TRAN

--Creating views

create view ViewByDepartment as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
--order by D.Department, T.EmployeeNumber
go
create view ViewSummary as 
select D.Department, T.EmployeeNumber as EmpNum, sum(T.Amount) as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
group by D.Department, T.EmployeeNumber
--order by D.Department, T.EmployeeNumber
go
select * from ViewByDepartment
select * from ViewSummary

--Altering and droping views

--if exists(select * from sys.views where name = 'ViewByDepartment')
if exists(select * from INFORMATION_SCHEMA.VIEWS
where [TABLE_NAME] = 'ViewByDepartment' and [TABLE_SCHEMA] = 'dbo')
   drop view dbo.ViewByDepartment
go

CREATE view [dbo].[ViewByDepartment] as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
--order by D.Department, T.EmployeeNumber

GO

--Adding new rows to views
begin tran

insert into ViewByDepartment(EmployeeNumber,DateOfTransaction,TotalAmount)
values (132,'2015-07-07', 999.99)

select * from ViewByDepartment order by Department, EmployeeNumber

rollback tran

begin tran
select * from ViewByDepartment order by EmployeeNumber, DateOfTransaction
--Select * from tblTransaction where EmployeeNumber in (132,142)

update ViewByDepartment
set EmployeeNumber = 142
where EmployeeNumber = 132

select * from ViewByDepartment order by EmployeeNumber, DateOfTransaction
--Select * from tblTransaction where EmployeeNumber in (132,142)
rollback tran

USE [70-461]
GO

--if exists(select * from sys.views where name = 'ViewByDepartment')
if exists(select * from INFORMATION_SCHEMA.VIEWS
where [TABLE_NAME] = 'ViewByDepartment' and [TABLE_SCHEMA] = 'dbo')
   drop view dbo.ViewByDepartment
go

CREATE view [dbo].[ViewByDepartment] as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
WITH CHECK OPTION
--order by D.Department, T.EmployeeNumber
GO



--Deleting rows in views
SELECT * FROM ViewByDepartment
delete from ViewByDepartment
where TotalAmount = 999.99 and EmployeeNumber = 132
GO
CREATE VIEW ViewSimple
as
SELECT * FROM tblTransaction
GO
BEGIN TRAN
delete from ViewSimple
where EmployeeNumber = 132
select * from ViewSimple
ROLLBACK TRAN

--Creating an indexed view

from dbo.tblDepartment as D
inner join dbo.tblEmployee as E
on D.Department = E.Department
inner join dbo.tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
GO

CREATE UNIQUE CLUSTERED INDEX inx_ViewByDepartment on dbo.ViewByDepartment(EmployeeNumber, Department)

begin tran
drop table tblEmployee
rollback tran

--Creating an AFTER trigger

ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
	--insert into tblTransaction2
	select *, 'Inserted' from Inserted
	--insert into tblTransaction2
	select *, 'Deleted' from Deleted
END
GO

BEGIN TRAN
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
VALUES (123,'2015-07-10', 123)
--delete tblTransaction 
--where EmployeeNumber = 123 and DateOfTransaction = '2015-07-10'
ROLLBACK TRAN
GO
DISABLE TRIGGER TR_tblTransaction ON tblTransaction;
GO
ENABLE TRIGGER TR_tblTransaction ON tblTransaction;
GO
DROP TRIGGER TR_tblTransaction;
GO

--Nested triggers
ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
    if @@NESTLEVEL = 1
	begin
		select *,'TABLEINSERT' from Inserted
		select *, 'TABLEDELETE' from Deleted
	end
END
GO

BEGIN TRAN
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
VALUES (123,'2015-07-10', 123)
ROLLBACK TRAN

begin tran
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
delete from ViewByDepartment
where TotalAmount = -2.77 and EmployeeNumber = 132
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran

EXEC sp_configure 'nested triggers';

EXEC sp_configure 'nested triggers',0;
RECONFIGURE
GO

--update functions

Update functions
ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT > 0
	BEGIN
		select * from Inserted
		select * from Deleted
	END
END
GO

insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
VALUES (123,'2015-07-11', 123)

SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132

begin tran
delete from ViewByDepartment
where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran

ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
	--SELECT COLUMNS_UPDATED()
	IF UPDATE(Amount) -- if (COLUMNS_UPDATED() & POWER(2,1-1)) > 0
	BEGIN
		select * from Inserted
		select * from Deleted
	END
END
go

begin tran
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
update ViewByDepartment
set TotalAmount = +2.77
where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran

--UNION and UNION all
select * from inserted
union 
select * from deleted

select convert(char(5),'hi') as Greeting
union all
select convert(char(11),'hello there') as GreetingNow
union all
select convert(char(11),'bonjour')
union all
select convert(char(11),'hi')


select convert(tinyint, 45) as Mycolumn
union
select convert(bigint, 456)

select 4
union
select 'hi there'


--Except and Intersect
select *, Row_Number() over(order by (select null)) % 3 as ShouldIDelete
--into tblTransactionNew
from tblTransaction

delete from tblTransactionNew
where ShouldIDelete = 1

update tblTransactionNew
set DateOfTransaction = dateadd(day,1,DateOfTransaction)
Where ShouldIDelete = 2

alter table tblTransactionNew
drop column ShouldIDelete

select * from tblTransaction -- 2486 rows
intersect--except--union--union all
select * from tblTransactionNew -- 1657 rows, 829 changed rows, 828 unchanged
order by EmployeeNumber



--CASE
declare @myOption as varchar(10) = 'Option C'

select case when @myOption = 'Option A' then 'First option'
            when @myOption = 'Option B' then 'Second option'
			--else 'No Option' 
			END as MyOptions
go
declare @myOption as varchar(10) = 'Option A'

select case @myOption when 'Option A' then 'First option'
                   when 'Option B' then 'Second option' 
				   else 'No Option' END as MyOptions
go


	  case when left(EmployeeGovernmentID,1)='A' then 'Letter A'
	       when EmployeeNumber<200 then 'Less than 200'
		   else 'Neither letter' END + '.' as myCol
  FROM tblEmployee
