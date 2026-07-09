-- =============================================
-- Database: TimesheetsDB
-- Description: Complete database creation script with job execution
-- =============================================
-- ============================================================
-- SSIS FOLDER STRUCTURE CREATION SCRIPT
-- Creates the entire folder/project/package structure if missing
-- ============================================================

PRINT '========================================';
PRINT 'CREATING SSIS FOLDER STRUCTURE';
PRINT '========================================';
PRINT '';

DECLARE @folder_name NVARCHAR(128) = 'TimesheetDevTestMigration';
DECLARE @project_name NVARCHAR(128) = 'TimesheetMigration1';
DECLARE @package_name NVARCHAR(128) = 'TimesheetMigration.dtsx';

-- ============================================================
-- 1. CREATE SSISDB CATALOG (if missing)
-- ============================================================
PRINT '1. Checking SSISDB Catalog...';

IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'SSISDB')
BEGIN
    PRINT '   ⚠️  SSISDB does not exist. Creating...';
    
    BEGIN TRY
        EXEC [SSISDB].[catalog].[create_catalog] @password = 'YourStrongPassword123!';
        PRINT '   ✅ SSISDB catalog created successfully!';
    END TRY
    BEGIN CATCH
        PRINT '   ❌ Failed to create SSISDB: ' + ERROR_MESSAGE();
        PRINT '   ℹ️  You need sysadmin permissions to create the catalog.';
        PRINT '   ℹ️  Run: EXEC [SSISDB].[catalog].[create_catalog] @password = ''YourPassword'';';
    END CATCH
END
ELSE
BEGIN
    PRINT '   ✅ SSISDB catalog already exists.';
END

PRINT '';

-- ============================================================
-- 2. CREATE FOLDER
-- ============================================================
PRINT '2. Checking folder: ' + @folder_name;

IF EXISTS (SELECT 1 FROM SSISDB.[catalog].[folders] WHERE name = @folder_name)
BEGIN
    PRINT '   ✅ Folder "' + @folder_name + '" already exists.';
END
ELSE
BEGIN
    PRINT '   ⚠️  Folder "' + @folder_name + '" not found. Creating...';
    
    BEGIN TRY
        EXEC SSISDB.[catalog].[create_folder] 
            @folder_name = @folder_name, 
            @folder_id = 0;
        PRINT '   ✅ Folder "' + @folder_name + '" created successfully!';
    END TRY
    BEGIN CATCH
        PRINT '   ❌ Failed to create folder: ' + ERROR_MESSAGE();
    END CATCH
END

PRINT '';

-- ============================================================
-- 3. CHECK/CREATE PROJECT (using minimal deployment)
-- ============================================================
PRINT '3. Checking project: ' + @project_name;

DECLARE @folder_id BIGINT;
SELECT @folder_id = folder_id 
FROM SSISDB.[catalog].[folders] 
WHERE name = @folder_name;

IF @folder_id IS NOT NULL
BEGIN
    DECLARE @project_id BIGINT;
    SELECT @project_id = project_id 
    FROM SSISDB.[catalog].[projects] 
    WHERE folder_id = @folder_id AND name = @project_name;
    
    IF @project_id IS NOT NULL
    BEGIN
        PRINT '   ✅ Project "' + @project_name + '" already exists.';
        
        -- Check if package exists
        IF EXISTS (
            SELECT 1 
            FROM SSISDB.[catalog].[packages] pk
            INNER JOIN SSISDB.[catalog].[projects] p ON pk.project_id = p.project_id
            WHERE p.project_id = @project_id AND pk.name = @package_name
        )
        BEGIN
            PRINT '   ✅ Package "' + @package_name + '" already exists.';
        END
        ELSE
        BEGIN
            PRINT '   ⚠️  Package "' + @package_name + '" not found in project.';
        END
    END
    ELSE
    BEGIN
        PRINT '   ⚠️  Project "' + @project_name + '" not found in folder.';
        PRINT '   ℹ️  Project must be deployed using a valid .ispac file.';
        PRINT '   ℹ️  Run the deployment step to create the project.';
    END
END

PRINT '';

-- ============================================================
-- 4. SHOW CURRENT STRUCTURE
-- ============================================================
PRINT '4. Current SSIS Structure:';

IF EXISTS (SELECT 1 FROM SSISDB.[catalog].[folders] WHERE name = @folder_name)
BEGIN
    PRINT '    Folder: ' + @folder_name;
    
    -- Show all projects in the folder
    DECLARE @project_cursor CURSOR;
    DECLARE @proj_name NVARCHAR(128);
    
    SET @project_cursor = CURSOR FOR
        SELECT name 
        FROM SSISDB.[catalog].[projects] 
        WHERE folder_id = @folder_id;
    
    OPEN @project_cursor;
    FETCH NEXT FROM @project_cursor INTO @proj_name;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT '       Project: ' + @proj_name;
        
        -- Show packages in the project
        DECLARE @packages NVARCHAR(MAX) = '';
        SELECT @packages = STRING_AGG(name, ', ')
        FROM SSISDB.[catalog].[packages] pk
        INNER JOIN SSISDB.[catalog].[projects] p ON pk.project_id = p.project_id
        WHERE p.name = @proj_name AND p.folder_id = @folder_id;
        
        IF @packages IS NOT NULL AND @packages != ''
            PRINT '          Packages: ' + @packages;
        ELSE
            PRINT '          No packages found';
        
        FETCH NEXT FROM @project_cursor INTO @proj_name;
    END
    
    CLOSE @project_cursor;
    DEALLOCATE @project_cursor;
END
ELSE
BEGIN
    PRINT '    Folder does not exist. Run the workflow to create it.';
END

PRINT '';
PRINT '========================================';
PRINT 'STRUCTURE CHECK COMPLETE';
PRINT '========================================';

-- ============================================================
-- 5. GUIDANCE FOR FIXING MISSING STRUCTURE
-- ============================================================
PRINT '';
PRINT 'If structure is missing, here''s how to fix:';
PRINT '';

-- Check if running with SQL Authentication
IF SYSTEM_USER NOT LIKE '%\%'
BEGIN
    PRINT ' ISSUE: Using SQL Authentication';
    PRINT '   Solution: Use Windows Authentication for SSIS operations';
    PRINT '';
END

-- Check if SSISDB exists but no folder
IF NOT EXISTS (SELECT 1 FROM SSISDB.[catalog].[folders] WHERE name = @folder_name)
BEGIN
    PRINT '  Folder missing - Created automatically by this script';
END

-- Check if project exists
IF NOT EXISTS (
    SELECT 1 
    FROM SSISDB.[catalog].[projects] p
    INNER JOIN SSISDB.[catalog].[folders] f ON p.folder_id = f.folder_id
    WHERE f.name = @folder_name AND p.name = @project_name
)
BEGIN
    PRINT '  Project missing - Need to deploy .ispac file';
    PRINT '   To deploy, run the deployment script in the workflow';
    PRINT '';
END

PRINT '========================================';
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