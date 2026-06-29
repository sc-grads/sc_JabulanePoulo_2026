-- =============================================
-- CREATE TIMESHEET DATABASE
-- =============================================

USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TimesheetDB')
BEGIN
    PRINT ' Database already exists. Skipping creation.';
END
ELSE
BEGIN
    CREATE DATABASE TimesheetDB;
    PRINT ' Database TimesheetDB created';
END
GO

USE TimesheetDB;
GO

-- Create Schemas
CREATE SCHEMA timesheet;
CREATE SCHEMA audit;
GO

PRINT ' Database setup complete!';