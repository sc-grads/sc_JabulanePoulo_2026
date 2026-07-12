-- =============================================
-- Database: TimesheetsDB
-- Description: Complete database creation script with job execution
-- =============================================

-- Check if database exists and drop it
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'TimesheetsDB')
BEGIN
    ALTER DATABASE TimesheetsDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TimesheetsDB;
END
GO


-- Create the database
CREATE DATABASE TimesheetsDB;
GO

-- Use the database
USE TimesheetsDB;
GO



-- =============================================
-- Create Schemas
-- =============================================

-- Audit schema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'audit')
BEGIN
    EXEC('CREATE SCHEMA [audit]')
END
GO

-- Staging schema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'staging')
BEGIN
    EXEC('CREATE SCHEMA [staging]')
END
GO

-- Timesheet schema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'timesheet')
BEGIN
    EXEC('CREATE SCHEMA [timesheet]')
END
GO

-- =============================================
-- Table: audit.AuditLog
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [audit].[AuditLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[LogDateTime] [datetime] NULL,
	[RunNumber] [int] NULL,
	[LogSource] [nvarchar](500) NULL,
	[TaskName] [nvarchar](200) NULL,
	[LogStatus] [varchar](50) NULL,
	[RowsInserted] [int] NULL,
	[RowsUpdated] [int] NULL,
	[RowsDeleted] [int] NULL,
	[ExecutedBy] [nvarchar](100) NULL,
	[TargetTable] [nvarchar](100) NULL,
	[ExecutionDurationMs] [int] NULL,
	[Message] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [audit].[AuditLog] ADD  DEFAULT (getdate()) FOR [LogDateTime]
GO
ALTER TABLE [audit].[AuditLog] ADD  DEFAULT ((0)) FOR [RowsInserted]
GO
ALTER TABLE [audit].[AuditLog] ADD  DEFAULT ((0)) FOR [RowsUpdated]
GO
ALTER TABLE [audit].[AuditLog] ADD  DEFAULT ((0)) FOR [RowsDeleted]
GO




-- =============================================
-- Table: staging.Timesheet
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [staging].[Timesheet](
	[StagingID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[WorkDate] [date] NULL,
	[ClientName] [varchar](255) NULL,
	[ProjectName] [varchar](255) NULL,
	[WorkDescription] [varchar](500) NULL,
	[BillableStatus] [varchar](50) NULL,
	[Comments] [varchar](max) NULL,
	[HoursWorked] [decimal](5, 2) NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[SourceFile] [varchar](255) NULL,
	[Processed] [bit] NULL,
	[ProcessedAt] [datetime2](7) NULL,
	[DayOfWeek] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[StagingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [staging].[Timesheet] ADD  DEFAULT ((0)) FOR [Processed]
GO

-- =============================================
-- Table: timesheet.Client
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [timesheet].[Client](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ClientName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- =============================================
-- Table: timesheet.Employee
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [timesheet].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
-- =============================================
-- Table: timesheet.EMployeeLeave
-- =============================================
CREATE TABLE [timesheet].[EmployeeLeave](
	[LeaveID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[LeaveType] [varchar](100) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[NumberOfDays] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[LeaveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



ALTER TABLE [timesheet].[EmployeeLeave]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [timesheet].[Employee] ([EmployeeID])
GO


-- =============================================
-- Table: timesheet.Timesheet
-- =============================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [timesheet].[Timesheet](
	[TimesheetID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[WorkDate] [date] NOT NULL,
	[DayOfWeek] [varchar](20) NULL,
	[WorkDescription] [varchar](500) NULL,
	[Comments] [varchar](max) NULL,
	[HoursWorked] [decimal](5, 2) NOT NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[ClientID] [int] NULL,
	[BillableStatus] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[TimesheetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


ALTER TABLE [timesheet].[Timesheet] WITH CHECK ADD CONSTRAINT [FK_Timesheet_Client] FOREIGN KEY([ClientID])
REFERENCES [timesheet].[Client] ([ClientID])
GO


ALTER TABLE [timesheet].[Timesheet] CHECK CONSTRAINT [FK_Timesheet_Client]
GO

ALTER TABLE [timesheet].[Timesheet] WITH CHECK ADD CONSTRAINT [FK_Timesheet_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [timesheet].[Employee] ([EmployeeID])
GO


ALTER TABLE [timesheet].[Timesheet] CHECK CONSTRAINT [FK_Timesheet_Employee]
GO


-- =============================================
-- Populate Data
-- =============================================
-- Insert Employee data
INSERT INTO [timesheet].[Employee] (FirstName, LastName) 
VALUES 
    ('Buhle', 'Mkubha'),
    ('Charmane', 'Mchunu'),
    ('Jabulane', 'Poulo'),
    ('Kayden', 'Padayachee'),
    ('Lwazisile', 'Mhlambi'),
    ('Rushil', 'Jivan'),
    ('Shriya', 'Hariparsad'),
    ('Teolan', 'Govender');

-- Insert Client data
INSERT INTO [timesheet].[Client] (ClientName) 
VALUES 
    ('Internal Sambe'),
    ('Discovery');


-- =============================================
-- Verification Queries
-- =============================================

-- Verify the data was inserted
SELECT 'Employee Count' as [Check], COUNT(*) as [Count] FROM [timesheet].[Employee]
UNION ALL
SELECT 'Client Count', COUNT(*) FROM [timesheet].[Client];

-- Show the inserted data
SELECT 'Employees' as [Table], EmployeeID, FirstName, LastName FROM [timesheet].[Employee]
UNION ALL
SELECT 'Clients', ClientID, ClientName, '' FROM [timesheet].[Client];
GO