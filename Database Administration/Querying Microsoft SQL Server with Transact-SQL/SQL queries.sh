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