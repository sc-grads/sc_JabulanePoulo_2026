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


--Defining LINESTRINGs,  POLYGONs and CIRCULARSTRINGs
begin tran
create table tblGeom
(GXY geometry,
Description varchar(20),
IDtblGeom int CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(5,1))
insert into tblGeom
VALUES (geometry::STGeomFromText('LINESTRING (1 1, 5 5)', 0),'First line'),
       (geometry::STGeomFromText('LINESTRING (5 1, 1 4, 2 5, 5 1)', 0),'Second line'),
	   (geometry::STGeomFromText('MULTILINESTRING ((1 5, 2 6), (1 4, 2 5))', 0),'Third line'),
	   (geometry::STGeomFromText('POLYGON ((4 1, 6 3, 8 3, 6 1, 4 1))', 0), 'Polygon'),
	   (geometry::STGeomFromText('CIRCULARSTRING (1 0, 0 1, -1 0, 0 -1, 1 0)', 0), 'Circle')
SELECT * FROM tblGeom
rollback tran



--Geography
begin tran
create table tblGeog
(GXY geography,
Description varchar(30),
IDtblGeog int CONSTRAINT PK_tblGeog PRIMARY KEY IDENTITY(1,1))
insert into tblGeog
VALUES (geography::STGeomFromText('POINT (-73.993492 40.750525)', 4326),'Madison Square Gardens, NY'),
       (geography::STGeomFromText('POINT (-0.177452 51.500905)', 4326),'Royal Albert Hall, London'),
	   (geography::STGeomFromText('LINESTRING (-73.993492 40.750525, -0.177452 51.500905)', 4326),'Connection')

select * from tblGeog

DECLARE @g as geography
select @g = GXY from tblGeog where IDtblGeog = 1

select IDtblGeog, GXY.STGeometryType() as MyType
, GXY.STStartPoint().ToString() as StartingPoint
, GXY.STEndPoint().ToString() as EndingPoint
, GXY.STPointN(1).ToString() as FirstPoint
, GXY.STPointN(2).ToString() as SecondPoint
, GXY.STLength() as MyLength
, GXY.STIntersection(@g).ToString() as Intersection
, GXY.STNumPoints() as NumberPoints
, GXY.STDistance(@g) as DistanceFromFirstLine
from tblGeog

DECLARE @h as geography

select @g = GXY from tblGeog where IDtblGeog = 1
select @h = GXY from tblGeog where IDtblGeog = 2
select @g.STDistance(@h) as MyDistance

select GXY.STUnion(@g)
from tblGeog
where IDtblGeog = 2 

ROLLBACK TRAN

select * from sys.spatial_reference_systems

--Spatial aggregates
begin tran
create table tblGeom
(GXY geometry,
Description varchar(20),
IDtblGeom int CONSTRAINT PK_tblGeom PRIMARY KEY IDENTITY(5,1))
insert into tblGeom
VALUES (geometry::STGeomFromText('LINESTRING (1 1, 5 5)', 0),'First line'),
	   (geometry::STGeomFromText('LINESTRING (5 1, 1 4, 2 5, 5 1)', 0),'Second line'),
	   (geometry::STGeomFromText('MULTILINESTRING ((1 5, 2 6), (1 4, 2 5))', 0),'Third line'),
	   (geometry::STGeomFromText('POLYGON ((4 1, 6 3, 8 3, 6 1, 4 1))', 0), 'Polygon'),
	   (geometry::STGeomFromText('POLYGON ((5 2, 7 2, 7 4, 5 4, 5 2))', 0), 'Second Polygon'),
	   (geometry::STGeomFromText('CIRCULARSTRING (1 0, 0 1, -1 0, 0 -1, 1 0)', 0), 'Circle')
select * from tblGeom

SELECT *  FROM tblGeom
where GXY.Filter(geometry::Parse('POLYGON((2 1, 1 4, 4 4, 4 1, 2 1))')) = 1
UNION ALL
SELECT geometry::STGeomFromText('POLYGON((2 1, 1 4, 4 4, 4 1, 2 1))', 0), 'Filter', 0

declare @i as geometry
select @i = geometry::UnionAggregate(GXY) 
from tblGeom

Select @i as CombinedShapes

declare @j as geometry
select @j = geometry::CollectionAggregate(GXY) 
from tblGeom

select @j

Select @i as CombinedShapes
--union all
select geometry::EnvelopeAggregate(GXY) as Envelope from tblGeom
--union all
select geometry::ConvexHullAggregate(GXY) as Envelope from tblGeom

ROLLBACK TRAN

--Subquery – WHERE
select T.* 
from tblTransaction as T
inner join tblEmployee as E
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeLastName like 'y%'
order by T.EmployeeNumber

select * 
from tblTransaction as T
Where EmployeeNumber in
    (Select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber


--Subquery – WHERE and NOT
select * 
from tblTransaction as T
Where EmployeeNumber in
    (Select EmployeeNumber from tblEmployee where EmployeeLastName not like 'y%')
order by EmployeeNumber -- must be in tblEmployee AND tblTransaction, and not 126-129
                        -- INNER JOIN

select * 
from tblTransaction as T
Where EmployeeNumber not in
    (Select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber -- must be in tblTransaction, and not 126-129
                        -- LEFT JOIN


--Subquery – WHERE and ANY, SOME and ALL
select * 
from tblTransaction as T
Where EmployeeNumber = some -- or "some"
    (Select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber

select * 
from tblTransaction as T
Where EmployeeNumber <> any -- does not work properly
    (Select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber

select * 
from tblTransaction as T
Where EmployeeNumber <> all 
    (Select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber

select * 
from tblTransaction as T
Where EmployeeNumber <= all
    (Select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber

-- anything up to 126 AND
-- anything up to 127 AND
-- anything up to 128 AND
-- anything up to 129

-- ANY = anything up to 129
-- ALL = anything up to 126

-- any/some = OR
-- all = AND

-- 126 <> all(126,127,128,129)
-- 126<>126 AND 126<>127 AND 126<>128 AND 126<>129
-- FALSE    AND TRUE = FALSE

-- 126 <> any(126,127,128,129)
-- 126<>126 OR 126<>127 OR 126<>128 OR 126<>129
-- FALSE    OR TRUE = TRUE



--Subqueries in the FROM clause
select * 
from tblTransaction as T
left join (select * from tblEmployee
where EmployeeLastName like 'y%') as E
on E.EmployeeNumber = T.EmployeeNumber
order by T.EmployeeNumber

select * 
from tblTransaction as T
left join tblEmployee as E
on E.EmployeeNumber = T.EmployeeNumber
Where E.EmployeeLastName like 'y%'
order by T.EmployeeNumber

select * 
from tblTransaction as T
left join tblEmployee as E
on E.EmployeeNumber = T.EmployeeNumber
and E.EmployeeLastName like 'y%'
order by T.EmployeeNumber


--Subquery Select Clause
Select *, (select count(EmployeeNumber)
           from tblTransaction as T
		   where T.EmployeeNumber = E.EmployeeNumber) as NumTransactions,
		  (Select sum(Amount)
		   from tblTransaction as T
		   where T.EmployeeNumber = E.EmployeeNumber) as TotalAmount
from tblEmployee as E
Where E.EmployeeLastName like 'y%' --correlated subquery


--Remainder
select * 
from tblTransaction as T
Where exists 
    (Select EmployeeNumber from tblEmployee as E where EmployeeLastName like 'y%' and T.EmployeeNumber = E.EmployeeNumber)
order by EmployeeNumber

select * 
from tblTransaction as T
Where not exists 
    (Select EmployeeNumber from tblEmployee as E where EmployeeLastName like 'y%' and T.EmployeeNumber = E.EmployeeNumber)
order by EmployeeNumber



--With statement


with tblWithRanking as
(select D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName,
       rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
 from tblDepartment as D 
 join tblEmployee as E on D.Department = E.Department

select * from tblWithRanking 
where TheRank <= 5
order by Department, EmployeeNumber

with tblWithRanking as
(select D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName,
       rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
 from tblDepartment as D 
 join tblEmployee as E on D.Department = E.Department),
Transaction2014 as
(select * from tblTransaction where DateOfTransaction < '2015-01-01')

select * from tblWithRanking 
left join Transaction2014 on tblWithRanking.EmployeeNumber = Transaction2014.EmployeeNumber
where TheRank <= 5
order by Department, tblWithRanking.EmployeeNumber

SELECT TOP (100) ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Number
FROM sys.objects; -- This creates a list of numbers from 1 to 100

--Generating a list of numbers
select E.EmployeeNumber from tblEmployee as E 
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber IS NULL
order by E.EmployeeNumber

select max(EmployeeNumber) from tblTransaction;

with Numbers as (
select top(select max(EmployeeNumber) from tblTransaction) row_Number() over(order by (select null)) as RowNumber
from tblTransaction as U)

select U.RowNumber from Numbers as U
left join tblTransaction as T
on U.RowNumber = T.EmployeeNumber
where T.EmployeeNumber is null
order by U.RowNumber

select row_number() over(order by(select null)) from sys.objects O cross join sys.objects 


--Grouping numbers


--Pivot
with myTable as
(select year(DateOfTransaction) as TheYear, month(DateOfTransaction) as TheMonth, Amount from tblTransaction)

select * from myTable
PIVOT (sum(Amount) for TheMonth in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) as myPvt
ORDER BY TheYear 


--Replacing Nulls with Zeros in Pivot
with myTable as
(select year(DateOfTransaction) as TheYear, month(DateOfTransaction) as TheMonth, Amount from tblTransaction)

select TheYear, isnull([1],0) as [1], 
                isnull([2],0) as [2], 
				isnull([3],0) as [3],
				isnull([4],0) as [4],
				isnull([5],0) as [5],
				isnull([6],0) as [6],
				isnull([7],0) as [7],
				isnull([8],0) as [8],
				isnull([9],0) as [9],
				isnull([10],0) as [10],
				isnull([11],0) as [11],
				isnull([12],0) as [12] from myTable
PIVOT (sum(Amount) for TheMonth in ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) as myPvt
ORDER BY TheYear 

--UnPivot
SELECT *
  FROM [tblPivot]
UNPIVOT (Amount FOR Month IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS tblUnPivot
where Amount <> 0


--Self Joins
begin tran
alter table tblEmployee
add Manager int
go
update tblEmployee
set Manager = ((EmployeeNumber-123)/10)+123
where EmployeeNumber>123
select E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName,
       M.EmployeeNumber as ManagerNumber, M.EmployeeFirstName as ManagerFirstName, 
	   M.EmployeeLastName as ManagerLastName
from tblEmployee as E
left JOIN tblEmployee as M
on E.Manager = M.EmployeeNumber

rollback tran



--Recursive CTE
begin tran
alter table tblEmployee
add Manager int
go
update tblEmployee
set Manager = ((EmployeeNumber-123)/10)+123
where EmployeeNumber>123;
with myTable as
(select EmployeeNumber, EmployeeFirstName, EmployeeLastName, 0 as BossLevel --Anchor
from tblEmployee
where Manager is null
UNION ALL --UNION ALL!!
select E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName, myTable.BossLevel + 1 --Recursive
from tblEmployee as E
join myTable on E.Manager = myTable.EmployeeNumber
) --recursive CTE

select * from myTable

rollback tran


--Scalar fuction
CREATE FUNCTION AmountPlusOne(@Amount smallmoney)
RETURNS smallmoney
AS
BEGIN

    RETURN @Amount + 1

END
GO


select DateOfTransaction, EmployeeNumber, Amount, dbo.AmountPlusOne(Amount) as AmountAndOne
from tblTransaction

DECLARE @myValue smallmoney
EXEC @myValue = dbo.AmountPlusOne @Amount = 345.67
select @myValue


--A more complicated scalar function

if object_ID(N'NumberOfTransactions',N'FN') IS NOT NULL
	DROP FUNCTION NumberOfTransactions
GO
CREATE FUNCTION NumberOfTransactions(@EmployeeNumber int)
RETURNS int
AS
BEGIN
	DECLARE @NumberOfTransactions INT
	SELECT @NumberOfTransactions = COUNT(*) FROM tblTransaction
	WHERE EmployeeNumber = @EmployeeNumber
	RETURN @NumberOfTransactions
END


--Inline Table Function

CREATE FUNCTION TransactionList(@EmployeeNumber int)
RETURNS TABLE AS RETURN
(
    SELECT * FROM tblTransaction
	WHERE EmployeeNumber = @EmployeeNumber
)

SELECT * 
from dbo.TransactionList(123)

select *
from tblEmployee
where exists(select * from dbo.TransactionList(EmployeeNumber))

select distinct E.*
from tblEmployee as E
join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber

select *
from tblEmployee as E
where exists(Select EmployeeNumber from tblTransaction as T where E.EmployeeNumber = T.EmployeeNumber)


--Apply
SELECT * 
from dbo.TransList(123)
GO

select *, (select count(*) from dbo.TransList(E.EmployeeNumber)) as NumTransactions
from tblEmployee as E

select *
from tblEmployee as E
outer apply TransList(E.EmployeeNumber) as T

select *
from tblEmployee as E
cross apply TransList(E.EmployeeNumber) as T

--123 left join TransList(123)
--124 left join TransList(124)

--outer apply all of tblEmployee, UDF 0+ rows
--cross apply UDF 1+ rows

--outer apply = LEFT JOIN
--cross apply = INNER JOIN

select *
from tblEmployee as E
where  (select count(*) from dbo.TransList(E.EmployeeNumber)) >3



--Synonyms
create synonym EmployeeTable
for tblEmployee
go

select * from EmployeeTable

create synonym DateTable
for tblDate
go

select * from DateTable

create synonym RemoteTable
for OVERTHERE.70-461remote.dbo.tblRemote
go

select * from RemoteTable



--Dynamic Queries
select * from tblEmployee where EmployeeNumber = 129;
go
declare @command as varchar(255);
set @command = 'select * from tblEmployee where EmployeeNumber = 129;'
set @command = 'Select * from tblTransaction'
execute (@command);
go
declare @command as varchar(255), @param as varchar(50);
set @command = 'select * from tblEmployee where EmployeeNumber = '
set @param ='129'
execute (@command + @param); --sql injection potential
go
declare @command as nvarchar(255), @param as nvarchar(50);
set @command = N'select * from tblEmployee where EmployeeNumber = @ProductID'
set @param =N'129'
execute sys.sp_executesql @statement = @command, @params = N'@ProductID int', @ProductID = @param;


--Problems with IDENTITY
begin tran
insert into tblEmployee2
values ('New Name')
select * from tblEmployee2
rollback tran

truncate table tblEmployee2

--GUIDs
declare @newvalue as uniqueidentifier --GUID
SET @newvalue = NEWID()
SELECT @newvalue as TheNewID
GO
declare @randomnumbergenerator int = DATEPART(MILLISECOND,SYSDATETIME())+1000*(DATEPART(SECOND,SYSDATETIME())
                                     +60*(DATEPART(MINUTE,SYSDATETIME())+60*DATEPART(HOUR,SYSDATETIME())))
SELECT RAND(@randomnumbergenerator) as RandomNumber;

begin tran
Create table tblEmployee4
(UniqueID uniqueidentifier CONSTRAINT df_tblEmployee4_UniqueID DEFAULT NEWID(),
EmployeeNumber int CONSTRAINT uq_tblEmployee4_EmployeeNumber UNIQUE)

Insert into tblEmployee4(EmployeeNumber)
VALUES (1), (2), (3)
select * from tblEmployee4
rollback tran
go
declare @newvalue as uniqueidentifier
SET @newvalue = NEWSEQUENTIALID()
SELECT @newvalue as TheNewID
GO
begin tran
Create table tblEmployee4
(UniqueID uniqueidentifier CONSTRAINT df_tblEmployee4_UniqueID DEFAULT NEWSEQUENTIALID(),
EmployeeNumber int CONSTRAINT uq_tblEmployee4_EmployeeNumber UNIQUE)

Insert into tblEmployee4(EmployeeNumber)
VALUES (1), (2), (3)
select * from tblEmployee4
rollback tran


--Defining SEQUENCES
BEGIN TRAN
CREATE SEQUENCE newSeq AS BIGINT
START WITH 1
INCREMENT BY 1
MINVALUE 1
--MAXVALUE 999999
--CYCLE
CACHE 50
CREATE SEQUENCE secondSeq AS INT
SELECT * FROM sys.sequences
ROLLBACK TRAN

--Trancount

update [dbo].[tblEmployee] set EmployeeNumber = 123 where EmployeeNumber = 122


select * from [dbo].[tblEmployee]

select @@TRANCOUNT --0
begin tran
	select @@TRANCOUNT --1
	begin tran
		update [dbo].[tblEmployee] set EmployeeNumber = 122 where EmployeeNumber = 123
		select @@TRANCOUNT --2
	commit tran
	select @@TRANCOUNT --1
if @@TRANCOUNT > 0 --Yes
commit tran
select @@TRANCOUNT --0


select * from [dbo].[tblEmployee]

--isolation levels; 

begin transaction 

update [dbo].[tblEmployee] set EmployeeNumber = 122 where EmployeeNumber = 123

commit tran

update [dbo].[tblEmployee] set EmployeeNumber = 123 where EmployeeNumber = 122

insert into [dbo].[tblEmployee]([EmployeeNumber]
      ,[EmployeeFirstName]
      ,[EmployeeMiddleName]
      ,[EmployeeLastName]
      ,[EmployeeGovernmentID]
      ,[DateOfBirth]
      ,[Department])
values (122,'H','I','T','H','2010-01-01','H')

delete from [dbo].[tblEmployee]
where EmployeeNumber = 122
set transaction isolation level read committed

begin tran
select * from [dbo].[tblEmployee]
waitfor delay '00:00:20'
select * from [dbo].[tblEmployee]
commit tran


--Clustered Index
create clustered index idx_tblEmployee on [dbo].[tblEmployee]([EmployeeNumber])

drop index idx_tblEmployee on [dbo].[tblEmployee]

select * from [dbo].[tblEmployee2] where [EmployeeNumber] = 127
select * from [dbo].[tblEmployee2]

select *
into [dbo].[tblEmployee2]
from [dbo].[tblEmployee]
where EmployeeNumber <> 131

--seek = few number of rows based on the index
--scan = going through the entire table

alter table [dbo].[tblEmployee2]
add constraint pk_tblEmployee2 PRIMARY KEY(EmployeeNumber)

create table myTable (Field1 int primary key)


--Filtered indices


CREATE NONCLUSTERED INDEX idx_tblEmployee_Employee  
    ON dbo.tblEmployee(EmployeeNumber) where EmployeeNumber<139;
INCLUDE
CREATE NONCLUSTERED INDEX idx_tblEmployee_Employee  
    ON dbo.tblEmployee(EmployeeNumber) include (EmployeeFirstName);

DROP INDEX idx_tblEmployee_Employee ON dbo.tblEmployee
Include Client Statistics
select *
from [dbo].[tblEmployee] as E
Table Scan
select *
from [dbo].[tblEmployee] as E
where E.EmployeeNumber = 134 
Still a Table Scan


--INCLUDE
CREATE NONCLUSTERED INDEX idx_tblEmployee_Employee  
    ON dbo.tblEmployee(EmployeeNumber) include (EmployeeFirstName);

DROP INDEX idx_tblEmployee_Employee ON dbo.tblEmployee


--Include Client Statistics
select *
from [dbo].[tblEmployee] as E
--Table Scan
select *
from [dbo].[tblEmployee] as E
where E.EmployeeNumber = 134 
--Still a Table Scan

--Hash match:
select * 
from [dbo].[tblDepartment] as D
left join [dbo].[tblEmployee] as E
on D.Department = E.Department

select D.Department, D.DepartmentHead, E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName 
from [dbo].[tblDepartment] as D
left join [dbo].[tblEmployee] as E
on D.Department = E.Department

--Nested Loop


select D.Department, D.DepartmentHead, E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName 
from [dbo].[tblDepartment] as D
left join [dbo].[tblEmployee] as E
on D.Department = E.Department
where D.Department = 'HR'

select *
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber

select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber


--Merge Joins
CREATE UNIQUE CLUSTERED INDEX [idx_tblEmployee] ON [dbo].[tblEmployee]
([EmployeeNumber])

GO

CREATE UNIQUE CLUSTERED INDEX [idx_tblTransaction] ON [dbo].[tblTransaction]
([EmployeeNumber],[DateOfTransaction],[Amount])

GO
select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber

select *
into dbo.tblEmployeeNoIndex
from dbo.tblEmployee

select *
into dbo.tblTransactionNoIndex
from dbo.tblTransaction

select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber

select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployeeNoIndex] as E
left join [dbo].[tblTransactionNoIndex] as T
on E.EmployeeNumber = T.EmployeeNumber


--plan guides
select *
into dbo.tblTransactionBig
from [dbo].[tblTransaction]

insert into dbo.tblTransactionBig ([Amount], [DateOfTransaction], [EmployeeNumber])
select T1.Amount, T2.DateOfTransaction, 1 as EmployeeNumber
from [dbo].[tblTransaction] as T1
cross join (select * from [dbo].[tblTransaction] where EmployeeNumber<200) as T2

create nonclustered index idx_tbltblTransactionBig on dbo.tblTransactionBig(EmployeeNumber)

create proc procTransactionBig(@EmployeeNumber as int) WITH RECOMPILE
as
select *
from tblTransactionBig as T
left join tblEmployee as E
on T.EmployeeNumber = E.EmployeeNumber
where T.EmployeeNumber = @EmployeeNumber

exec procTransactionBig 1
exec procTransactionBig 132


--DMVs (Index Related Dynamic Management Views and Functions)
dm_db_index_usage_stats
select db_name(database_id) as [Database Name]
, object_name(ddius.object_id) as [Table Name]
, i.name as [Index Name]
, ddius.*
from sys.dm_db_index_usage_stats as ddius
join sys.indexes as i on ddius.object_id = i.object_id and ddius.index_id = i.index_id
where database_id = db_id()
sys.dm_db_missing_index_details
select T.*
into dbo.tblTransactionBigger
from [dbo].[tblTransaction] as T
cross join [dbo].[tblTransaction] as T2

select * from dbo.tblTransactionBigger
where [EmployeeNumber] = 127

select * from sys.dm_db_missing_index_details

select mig.*, statement as table_name, column_id, column_name, column_usage
from sys.dm_db_missing_index_details as mid
cross apply sys.dm_db_missing_index_columns(mid.index_handle)
inner join sys.dm_db_missing_index_groups as mig on mig.index_handle = mid.index_handle
where database_id = db_id()
order by column_id

drop table dbo.tblTransactionBigger
sys.dm_db_index_physical_stats
SELECT * FROM sys.dm_db_index_physical_stats  
    (DB_ID(N'70-461'), OBJECT_ID(N'dbo.tblEmployee'), NULL, NULL , 'DETAILED');  
     database_id       object_id                     index_id/partition_number/mode

--Evaluate the use of row-based operations vs. set-based operations
When to use cursors
declare @EmployeeID int
declare csr CURSOR FOR 
select EmployeeNumber
from [dbo].[tblEmployee]
where EmployeeNumber between 120 and 299

open csr
fetch next from csr into @EmployeeID
while @@FETCH_STATUS = 0
begin
	select * from [dbo].[tblTransaction] where EmployeeNumber = @EmployeeID
	fetch next from csr into @EmployeeID
end
close csr
deallocate csr
Alternatives
select T.*
from tblTransaction as T
right join tblEmployee as E
on T.EmployeeNumber = E.EmployeeNumber
where E.EmployeeNumber between 120 and 299 
and T.EmployeeNumber is not null
impact of scalar UDFs
--set statistics time on


CREATE FUNCTION fnc_TransactionTotal (@intEmployee as int)
returns money
as
begin
declare @TotalAmount as money
select @TotalAmount = sum(Amount) 
from [dbo].[tblTransaction]
where EmployeeNumber = @intEmployee
return @TotalAmount
end

set showplan_all on
go
set showplan_text on
go
select [EmployeeNumber], dbo.fnc_TransactionTotal([EmployeeNumber]) 
from [dbo].[tblEmployee]

select E.[EmployeeNumber], sum(Amount) as TotalAmount
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber
group by E.[EmployeeNumber]
set statistics time off
set showplan_all off

select EmployeeNumber, dbo.fnc_TransactionTotal(EmployeeNumber)
from dbo.tblEmployee

select E.EmployeeNumber, sum(T.Amount) as TotalAmount
from dbo.tblEmployee as E
left join dbo.tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
group by E.EmployeeNumber

select E.EmployeeNumber, (select sum(Amount) from tblTransaction as T 
                          where T.EmployeeNumber = E.EmployeeNumber) as TotalAmount
from dbo.tblEmployee as E


create function fnc_TransactionAll (@intEmployee as int)
returns @returntable table
(Amount smallmoney)
as
begin
	insert @returntable
	select amount
	from dbo.tblTransaction
	where EmployeeNumber = @intEmployee
	return
end

select * from dbo.fnc_TransactionAll (128)

select EmployeeNumber, sum(T.Amount) as TotalAmount
from dbo.tblEmployee as E
outer apply fnc_TransactionAll(EmployeeNumber) as T
group by EmployeeNumber

select E.EmployeeNumber, sum(T.Amount) as TotalAmount
from dbo.tblEmployee as E
left join dbo.tblTransaction as T on E.EmployeeNumber = T.EmployeeNumber
group by E.EmployeeNumber

<<<<<<< HEAD
=======
/ddd
>>>>>>> f568f53b92e030a955be36ac1a592226f292a102
