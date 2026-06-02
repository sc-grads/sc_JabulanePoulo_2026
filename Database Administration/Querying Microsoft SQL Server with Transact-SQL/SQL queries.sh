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


SELECT [EmployeeNumber]
      ,[EmployeeFirstName]
      ,[EmployeeMiddleName]
      ,[EmployeeLastName]
      ,[EmployeeGonvernmnetID]
      ,[DateOfBirth]
      ,[Department],
      case when left(EmployeeGonvernmnetID,1)= 'A' then 'Letter A'
           when left(EmployeeGonvernmnetID,1) = 'B' then 'Letter B'
           else 'Neither letter' END + '.' as myCol
  FROM [dbo].[tblEmployee]

--Isnull and Coalesce
select * from tblEmployee where EmployeeMiddleName is null

declare @myOption as varchar(10) = 'Option B'
select isnull(@myOption, 'No Option') as MyOptions
go

declare @myFirstOption as varchar(10) --= 'Option A'
declare @mySecondOption as varchar(10) --= 'Option B'

select coalesce(@myFirstOption, @mySecondOption, 'No option') as MyOptions
go

select isnull('ABC',1) as MyAnswer
select coalesce('ABC',1) as MyOtherAnswer
go

select isnull(null,null) as MyAnswer
select coalesce(null,null) as MyOtherAnswer
go

create table tblExample
(myOption nvarchar(10) null)
go
insert into tblExample (myOption)
values ('Option A')

select coalesce(myOption, 'No option') as MyOptions
into tblIsCoalesce
from tblExample 
select case when myOption is not null then myOption else 'No option' end as myOptions from tblExample
go
select isnull(myOption, 'No option') as MyOptions
into tblIsNull
from tblExample 
go

drop table tblExample
drop table tblIsCoalesce
drop table tblIsNull


--Let’s build our MERGE statement
BEGIN TRAN
MERGE INTO tblTransaction as T
USING tblTransactionNew as S
ON T.EmployeeNumber = S.EmployeeNumber AND T.DateOfTransaction = S.DateOfTransaction
WHEN MATCHED THEN
    UPDATE SET Amount = T.Amount + S.Amount
WHEN NOT MATCHED BY TARGET THEN
    INSERT ([Amount], [DateOfTransaction], [EmployeeNumber])
	VALUES (S.Amount, S.DateOfTransaction, S.EmployeeNumber);
ROLLBACK TRAN

-- tblTransaction (no) - tblTransactionNew (yes)
-- 1 tblTransaction - 1 tblTransactionNew
-- 1 tblTransaction - multiple rows TblTransactionNew

--Let’s expand our MERGE statement
SELECT DateOfTransaction, EmployeeNumber, COUNT(*) AS NumberOfRows
FROM tblTransactionNew 
GROUP BY DateOfTransaction, EmployeeNumber
HAVING COUNT(*)>1

BEGIN TRAN
go
DISABLE TRIGGER TR_tblTransaction ON dbo.tblTransaction
GO
MERGE INTO tblTransaction as T
USING (SELECT DateOfTransaction, EmployeeNumber, MIN(Amount) as Amount
      FROM tblTransactionNew
	  GROUP BY DateOfTransaction, EmployeeNumber) as S
ON T.EmployeeNumber = S.EmployeeNumber AND
	T.DateOfTransaction = S.DateOfTransaction
WHEN MATCHED THEN
    UPDATE SET Amount = T.Amount + S.Amount
WHEN NOT MATCHED THEN
	INSERT (Amount, DateOfTransaction, EmployeeNumber)
	VALUES (S.Amount, S.DateOfTransaction, S.EmployeeNumber)
	OUTPUT deleted.*, inserted.*;
ROLLBACK TRAN

--Merge with additional column
BEGIN TRAN
ALTER TABLE tblTransaction
ADD Comments varchar(50) NULL
GO -- DDL
MERGE TOP (5) PERCENT INTO tblTransaction as T --DML
USING (select EmployeeNumber, DateOfTransaction, sum(Amount) as Amount
from tblTransactionNew
group by EmployeeNumber, DateOfTransaction) as S
ON T.EmployeeNumber = S.EmployeeNumber AND T.DateOfTransaction = S.DateOfTransaction
WHEN MATCHED AND T.Amount + S.Amount >0 THEN
    UPDATE SET Amount = T.Amount + S.Amount, Comments = 'Updated Row'


WHEN MATCHED THEN
	DELETE
WHEN NOT MATCHED BY TARGET THEN
    INSERT ([Amount], [DateOfTransaction], [EmployeeNumber], Comments)
	VALUES (S.Amount, S.DateOfTransaction, S.EmployeeNumber, 'Inserted Row')
WHEN NOT MATCHED BY SOURCE THEN
	UPDATE SET Comments = 'Unchanged'
OUTPUT inserted.*, deleted.* , $action;
--Select * from tblTransaction ORDER BY EmployeeNumber, DateOfTransaction
ROLLBACK TRAN


Let’s create our first procedure
create proc NameEmployees as
begin
	select EmployeeNumber, EmployeeFirstName, EmployeeLastName
	from tblEmployee
end
go
NameEmployees
execute NameEmployees
exec NameEmployees
12. Ask for a specific employee
--if exists (select * from sys.procedures where name='NameEmployees')
if object_ID('NameEmployees','P') IS NOT NULL
drop proc NameEmployees
go
create proc NameEmployees(@EmployeeNumber int) as
begin
	if exists (Select * from tblEmployee where EmployeeNumber = @EmployeeNumber)
	begin
		select EmployeeNumber, EmployeeFirstName, EmployeeLastName
		from tblEmployee
		where EmployeeNumber = @EmployeeNumber
	end
end
go
NameEmployees 4
execute NameEmployees 223
exec NameEmployees 323
select EmployeeNumber from NameEmployees

DECLARE @EmployeeName int = 123
select @EmployeeName
13. Different outcomes
--if exists (select * from sys.procedures where name='NameEmployees')
if object_ID('NameEmployees','P') IS NOT NULL
drop proc NameEmployees
go
create proc NameEmployees(@EmployeeNumber int) as
begin
	if exists (Select * from tblEmployee where EmployeeNumber = @EmployeeNumber)
	begin
		if @EmployeeNumber < 300
		begin
			select EmployeeNumber, EmployeeFirstName, EmployeeLastName
			from tblEmployee
			where EmployeeNumber = @EmployeeNumber
		end
		else
		begin
			select EmployeeNumber, EmployeeFirstName, EmployeeLastName, Department
			from tblEmployee
			where EmployeeNumber = @EmployeeNumber			
			select * from tblTransaction where EmployeeNumber = @EmployeeNumber
		end
	end
end
go
NameEmployees 4
execute NameEmployees 223
exec NameEmployees 324
14. Ask for a range of employees
--if exists (select * from sys.procedures where name='NameEmployees')
if object_ID('NameEmployees','P') IS NOT NULL
drop proc NameEmployees
go
create proc NameEmployees(@EmployeeNumberFrom int, @EmployeeNumberTo int) as
begin
	if exists (Select * from tblEmployee where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo)
	begin
		select EmployeeNumber, EmployeeFirstName, EmployeeLastName
		from tblEmployee
		where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo
	end
end
go
NameEmployees 4, 5
execute NameEmployees 223, 227
exec NameEmployees @EmployeeNumberFrom = 323, @EmployeeNumberTo = 327
15. A different SELECT statement per employee
--if exists (select * from sys.procedures where name='NameEmployees')
if object_ID('NameEmployees','P') IS NOT NULL
drop proc NameEmployees
go
create proc NameEmployees(@EmployeeNumberFrom int, @EmployeeNumberTo int) as
begin
	if exists (Select * from tblEmployee where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo)
	begin
		declare @EmployeeNumber int = @EmployeeNumberFrom
		while @EmployeeNumber <= @EmployeeNumberTo
		BEGIN
			if exists (Select * from tblEmployee where EmployeeNumber = @EmployeeNumber)
			select EmployeeNumber, EmployeeFirstName, EmployeeLastName
			from tblEmployee
			where EmployeeNumber = @EmployeeNumber
			SET @EmployeeNumber = @EmployeeNumber + 1
		END
	end
end
go
NameEmployees 4, 5
execute NameEmployees 223, 227
exec NameEmployees @EmployeeNumberFrom = 323, @EmployeeNumberTo = 1327
16. Returning values
--if exists (select * from sys.procedures where name='NameEmployees')
if object_ID('NameEmployees','P') IS NOT NULL
drop proc NameEmployees
go
create proc NameEmployees(@EmployeeNumberFrom int, @EmployeeNumberTo int, @NumberOfRows int OUTPUT) as
begin
	if exists (Select * from tblEmployee where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo)
	begin
		select EmployeeNumber, EmployeeFirstName, EmployeeLastName
		from tblEmployee
		where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo
		SET @NumberOfRows = @@ROWCOUNT
		RETURN 0
	end
	ELSE
	BEGIN
	    SET @NumberOfRows = 0
		RETURN 1
	END
end
go
DECLARE @NumberRows int, @ReturnStatus int
EXEC @ReturnStatus = NameEmployees 4, 5, @NumberRows OUTPUT
select @NumberRows as MyRowCount, @ReturnStatus as Return_Status
GO
DECLARE @NumberRows int, @ReturnStatus int
execute @ReturnStatus = NameEmployees 4, 327, @NumberRows OUTPUT
select @NumberRows as MyRowCount, @ReturnStatus as Return_Status
GO
DECLARE @NumberRows int, @ReturnStatus int
exec @ReturnStatus = NameEmployees @EmployeeNumberFrom = 323, @EmployeeNumberTo = 327, @NumberOfRows = @NumberRows OUTPUT
select @NumberRows as MyRowCount, @ReturnStatus as Return_Status

19. Try … Catch
--if exists (select * from sys.procedures where name='AverageBalance')
if object_ID('AverageBalance','P') IS NOT NULL
drop proc AverageBalance
go
create proc AverageBalance(@EmployeeNumberFrom int, @EmployeeNumberTo int, @AverageBalance int OUTPUT) as
begin
	SET NOCOUNT ON
	declare @TotalAmount money
	declare @NumOfEmployee int
	begin try
		select @TotalAmount = sum(Amount) from tblTransaction
		where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo
		select @NumOfEmployee = count(distinct EmployeeNumber) from tblEmployee
		where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo
		set @AverageBalance = @TotalAmount / @NumOfEmployee
		RETURN 0
	end try
	begin catch
		set @AverageBalance = 0
		SELECT ERROR_MESSAGE() AS ErrorMessage, ERROR_LINE() as ErrorLine,
			   ERROR_NUMBER() as ErrorNumber, ERROR_PROCEDURE() as ErrorProcedure,
			   ERROR_SEVERITY() as ErrorSeverity,  -- 0-10 for information
			   -- 16 default SQL SERVER log / Windows Application log
			   
			   -- 20-25 
			   ERROR_STATE() as ErrorState
		RETURN 1
	end catch
end
go
DECLARE @AvgBalance int, @ReturnStatus int
EXEC @ReturnStatus = AverageBalance 4, 5, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status
GO
DECLARE @AvgBalance int, @ReturnStatus int
execute @ReturnStatus = AverageBalance 223, 227, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status
GO
DECLARE @AvgBalance int, @ReturnStatus int
exec @ReturnStatus = AverageBalance @EmployeeNumberFrom = 323, @EmployeeNumberTo = 327, @AverageBalance = @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status

SELECT TRY_CONVERT(int, 'two')
21. Print
--if exists (select * from sys.procedures where name='AverageBalance')
if object_ID('AverageBalance','P') IS NOT NULL
drop proc AverageBalance
go
create proc AverageBalance(@EmployeeNumberFrom int, @EmployeeNumberTo int, @AverageBalance int OUTPUT) as
begin
	SET NOCOUNT ON
	declare @TotalAmount decimal(5,2)
	declare @NumOfEmployee int
	begin try
		print 'The employee numbers are from ' + convert(varchar(10),@EmployeeNumberFrom) 
		      + ' to ' + convert(varchar(10),@EmployeeNumberTo)
		select @TotalAmount = sum(Amount) from tblTransaction
		where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo
		select @NumOfEmployee = count(distinct EmployeeNumber) from tblEmployee
		where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo
		set @AverageBalance = @TotalAmount / @NumOfEmployee
		RETURN 0
	end try
	begin catch
		set @AverageBalance = 0
		if ERROR_NUMBER() = 8134 -- @@ERROR
		begin
			set @AverageBalance = 0
			print 'There are no valid employees in this range.'
			Return 8134
		end
		else
		    declare @ErrorMessage as varchar(255)
			select @ErrorMessage = error_Message()
			raiserror (@ErrorMessage, 16, 1)
			--throw 56789, 'Too many flanges', 1
		-- PRINT ERROR_MESSAGE() AS ErrorMessage, ERROR_LINE() as ErrorLine, 			   ERROR_NUMBER() as ErrorNumber, ERROR_PROCEDURE() as ErrorProcedure, 			   ERROR_SEVERITY() as ErrorSeverity,  -- 0-10 for information
			   -- 16 default SQL SERVER log / Windows Application log
			   
			   -- 20-25 
		--	   ERROR_STATE() as ErrorState
		--RETURN 1
		select 'Hi There'
	end catch
end
go
DECLARE @AvgBalance int, @ReturnStatus int
EXEC @ReturnStatus = AverageBalance 4, 5, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status
GO
DECLARE @AvgBalance int, @ReturnStatus int
execute @ReturnStatus = AverageBalance 223, 227, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status, 'Error did not stop us' as myMessage
GO
DECLARE @AvgBalance int, @ReturnStatus int
exec @ReturnStatus = AverageBalance @EmployeeNumberFrom = 323, @EmployeeNumberTo = 327, @AverageBalance = @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status


--Over()

select A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance
,sum(A.NumberAttendance) over() as TotalAttendance,
convert(decimal(18,7),A.NumberAttendance) / sum(A.NumberAttendance) over() * 100.0000 as PercentageAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber

select sum(NumberAttendance) from tblAttendance

--Partition by and Order by

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
sum(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber) as SumAttendance,
convert(money,A.NumberAttendance) / 
sum(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber) * 100 as PercentageAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
sum(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber, year(A.AttendanceMonth)
 ORDER BY A.AttendanceMonth) as SumAttendance,
convert(money,A.NumberAttendance) / 
sum(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber) * 100 as PercentageAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
order by A.EmployeeNumber, A.AttendanceMonth


--Range
select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as RollingTotal
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
6. Current Row and Unbounded
select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as RollingTotal
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RollingTotal
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
SUM(A.NumberAttendance) over(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as RollingTotal
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber


--Range versus Rows
select A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance
,sum(A.NumberAttendance) 
over(partition by A.EmployeeNumber, year(A.AttendanceMonth) 
     order by A.AttendanceMonth 
	 rows between current row and unbounded following) as RowsTotal
,sum(A.NumberAttendance) 
over(partition by A.EmployeeNumber, year(A.AttendanceMonth) 
     order by A.AttendanceMonth 
	 range between current row and unbounded following) as RangeTotal
from tblEmployee as E join (select * from tblAttendance UNION ALL select * from tblAttendance) as A
on E.EmployeeNumber = A.EmployeeNumber
--where A.AttendanceMonth < '20150101'
order by A.EmployeeNumber, A.AttendanceMonth

--unbounded preceding and current row
--current row and unbounded following
--unbounded preceding and unbounded following - RANGE and ROWS


--Omitting Range/Row?

select A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance
,sum(A.NumberAttendance) over() as TotalAttendance
--,convert(decimal(18,7),A.NumberAttendance) / sum(A.NumberAttendance) over() * 100.0000 as PercentageAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber

select sum(NumberAttendance) from tblAttendance

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
sum(A.NumberAttendance) 
over(PARTITION BY E.EmployeeNumber, year(A.AttendanceMonth)
     ORDER BY A.AttendanceMonth) as SumAttendance
from tblEmployee as E join (select * from tblAttendance UNION ALL Select * from tblAttendance) as A
on E.EmployeeNumber = A.EmployeeNumber
order by A.EmployeeNumber, A.AttendanceMonth

--range between unbounded preceding and unbounded following - DEFAULT where there is no ORDER BY
--range between unbounded preceding and current row         - DEFAULT where there IS an ORDER BY


--ROW_NUMBER, RANK and DENSE_RANK

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
ROW_NUMBER() OVER(ORDER BY E.EmployeeNumber, A.AttendanceMonth) as TheRowNumber,
RANK() OVER(ORDER BY E.EmployeeNumber, A.AttendanceMonth) as TheRank,
DENSE_RANK() OVER(ORDER BY E.EmployeeNumber, A.AttendanceMonth) as TheDenseRank
from tblEmployee as E join 
(Select * from tblAttendance union all select * from tblAttendance) as A
on E.EmployeeNumber = A.EmployeeNumber

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
ROW_NUMBER() OVER(PARTITION BY E.EmployeeNumber
                  ORDER BY A.AttendanceMonth) as TheRowNumber,
RANK()       OVER(PARTITION BY E.EmployeeNumber
                  ORDER BY A.AttendanceMonth) as TheRank,
DENSE_RANK() OVER(PARTITION BY E.EmployeeNumber
                  ORDER BY A.AttendanceMonth) as TheDenseRank
from tblEmployee as E join 
(Select * from tblAttendance union all select * from tblAttendance) as A
on E.EmployeeNumber = A.EmployeeNumber

select *, row_number() over(order by (select null)) from tblAttendance


--NTILE

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
NTILE(10) OVER(PARTITION BY E.EmployeeNumber
          ORDER BY A.AttendanceMonth) as TheNTile,
convert(int,(ROW_NUMBER() OVER(PARTITION BY E.EmployeeNumber
                               ORDER BY A.AttendanceMonth)-1)
 / (count(*) OVER(PARTITION BY E.EmployeeNumber 
		          ORDER BY A.AttendanceMonth 
				  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)/10.0))+1 as MyNTile
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
where A.AttendanceMonth <'2015-05-01'


--FIRST_VALUE and LAST_VALUE

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
first_value(NumberAttendance)
over(partition by E.EmployeeNumber order by A.AttendanceMonth) as FirstMonth,
last_value(NumberAttendance)
over(partition by E.EmployeeNumber order by A.AttendanceMonth
rows between unbounded preceding and unbounded following) as LastMonth
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber


--LAG and LEAD

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
lag(NumberAttendance, 1)  over(partition by E.EmployeeNumber 
                            order by A.AttendanceMonth) as MyLag,
lead(NumberAttendance, 1) over(partition by E.EmployeeNumber 
                            order by A.AttendanceMonth) as MyLead,
NumberAttendance - lag(NumberAttendance, 1)  over(partition by E.EmployeeNumber 
                            order by A.AttendanceMonth) as MyDiff
--first_value(NumberAttendance)  over(partition by E.EmployeeNumber 
--                                    order by A.AttendanceMonth
--							        rows between 1 preceding and current row) as MyFirstValue,
--last_value(NumberAttendance) over(partition by E.EmployeeNumber 
--                                  order by A.AttendanceMonth
--								  rows between current row and 1 following) as MyLastValue
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber


--CUME_DIST and PERCENT_RANK

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
CUME_DIST()    over(partition by E.EmployeeNumber 
               order by A.AttendanceMonth) as MyCume_Dist,
PERCENT_RANK() over(partition by E.EmployeeNumber 
                order by A.AttendanceMonth) as MyPercent_Rank,
cast(row_number() over(partition by E.EmployeeNumber order by A.AttendanceMonth) as decimal(9,5))
/ count(*) over(partition by E.EmployeeNumber) as CalcCume_Dist,
cast(row_number() over(partition by E.EmployeeNumber order by A.AttendanceMonth) - 1 as decimal(9,5))
/ (count(*) over(partition by E.EmployeeNumber) - 1) as CalcPercent_Rank
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber


--PERCENTILE_CONT and PERCENTILE_DISC

select A.EmployeeNumber, A.AttendanceMonth, 
A.NumberAttendance, 
CUME_DIST()    over(partition by E.EmployeeNumber 
               order by A.NumberAttendance) as MyCume_Dist,
PERCENT_RANK() over(partition by E.EmployeeNumber 
                order by A.NumberAttendance) * 100 as MyPercent_Rank
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber

SELECT DISTINCT EmployeeNumber,
PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY NumberAttendance) OVER (PARTITION BY EmployeeNumber) as AverageCont,
PERCENTILE_DISC(0.4) WITHIN GROUP (ORDER BY NumberAttendance) OVER (PARTITION BY EmployeeNumber) as AverageDisc
from tblAttendance


--Adding Totals
select E.Department, E.EmployeeNumber, A.AttendanceMonth as AttendanceMonth, sum(A.NumberAttendance) as NumberAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
group by E.Department, E.EmployeeNumber, A.AttendanceMonth
--order by Department, EmployeeNumber, AttendanceMonth
UNION
select E.Department, E.EmployeeNumber, null as AttendanceMonth, sum(A.NumberAttendance) as TotalAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
group by E.Department, E.EmployeeNumber
union
select E.Department, null, null as AttendanceMonth, sum(A.NumberAttendance) as TotalAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
group by E.Department
union
select null, null, null as AttendanceMonth, sum(A.NumberAttendance) as TotalAttendance
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
order by Department, EmployeeNumber, AttendanceMonth



--ROLLUP, GROUPING and GROUPING_ID
select E.Department, E.EmployeeNumber, A.AttendanceMonth as AttendanceMonth, sum(A.NumberAttendance) as NumberAttendance,
GROUPING(E.EmployeeNumber) AS EmployeeNumberGroupedBy,
GROUPING_ID(E.Department, E.EmployeeNumber, A.AttendanceMonth) AS EmployeeNumberGroupedID
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
group by ROLLUP (E.Department, E.EmployeeNumber, A.AttendanceMonth)
order by Department, EmployeeNumber, AttendanceMonth


--GROUPING SETS
select E.Department, E.EmployeeNumber, A.AttendanceMonth as AttendanceMonth, sum(A.NumberAttendance) as NumberAttendance,
GROUPING(E.EmployeeNumber) AS EmployeeNumberGroupedBy,
GROUPING_ID(E.Department, E.EmployeeNumber, A.AttendanceMonth) AS EmployeeNumberGroupedID
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
group by GROUPING SETS ((E.Department, E.EmployeeNumber, A.AttendanceMonth), (E.Department), ())
order by coalesce(Department, 'zzzzzzz'), coalesce(E.EmployeeNumber, 99999), coalesce(AttendanceMonth,'2100-01-01')

select E.Department, E.EmployeeNumber, A.AttendanceMonth as AttendanceMonth, sum(A.NumberAttendance) as NumberAttendance,
GROUPING(E.EmployeeNumber) AS EmployeeNumberGroupedBy,
GROUPING_ID(E.Department, E.EmployeeNumber, A.AttendanceMonth) AS EmployeeNumberGroupedID
from tblEmployee as E join tblAttendance as A
on E.EmployeeNumber = A.EmployeeNumber
group by GROUPING SETS ((E.Department, E.EmployeeNumber, A.AttendanceMonth), (E.Department), ())
order by CASE WHEN Department       IS NULL THEN 1 ELSE 0 END, Department, 
         CASE WHEN E.EmployeeNumber IS NULL THEN 1 ELSE 0 END, E.EmployeeNumber, 
         CASE WHEN AttendanceMonth  IS NULL THEN 1 ELSE 0 END, AttendanceMonth


--Geometry Creating Point
BEGIN TRAN
CREATE TABLE tblGeom
(GXY geometry,
Description varchar(30),
IDtblGeom int CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(1,1))
INSERT INTO tblGeom
VALUES (geometry::STGeomFromText('POINT (3 4)', 0),'First point'),
       (geometry::STGeomFromText('POINT (3 5)', 0),'Second point'),
	   (geometry::Point(4, 6, 0),'Third Point'),
	   (geometry::STGeomFromText('MULTIPOINT ((1 2), (2 3), (3 4))', 0), 'Three Points')

Select * from tblGeom

ROLLBACK TRAN



--Queries Points
begin tran
create table tblGeom
(GXY geometry,
Description varchar(20),
IDtblGeom int CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(1,1))
insert into tblGeom
VALUES (geometry::STGeomFromText('POINT (3 4)', 0),'First point'),
       (geometry::STGeomFromText('POINT (3 5)', 0),'Second point'),
	   (geometry::Point(4, 6, 0),'Third Point'),
	   (geometry::STGeomFromText('MULTIPOINT ((1 2), (2 3), (3 4))', 0),'Three Points')

SELECT * from tblGeom

select IDtblGeom, GXY.STGeometryType() as MyType
, GXY.STStartPoint().ToString() as StartingPoint
, GXY.STEndPoint().ToString() as EndingPoint
, GXY.STPointN(1).ToString() as FirstPoint
, GXY.STPointN(2).ToString() as SecondPoint
, GXY.STPointN(1).STX as FirstPointX
, GXY.STPointN(1).STY as FirstPointY
, GXY.STNumPoints() as NumberPoints
from tblGeom

DECLARE @g as geometry
DECLARE @h as geometry

select @g = GXY from tblGeom where IDtblGeom = 1
select @h = GXY from tblGeom where IDtblGeom = 3
select @g.STDistance(@h) as MyDistance

ROLLBACK TRAN


