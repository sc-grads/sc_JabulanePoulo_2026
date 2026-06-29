USE TimesheetDB;
GO

-- =============================================
-- 1. EMPLOYEE TABLE
-- =============================================
CREATE TABLE timesheet.Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeCode VARCHAR(50) UNIQUE NOT NULL,
    FullName NVARCHAR(200) NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE()
);
PRINT ' Created timesheet.Employee';

-- =============================================
-- 2. CLIENT TABLE
-- =============================================
CREATE TABLE timesheet.Client (
    ClientID INT PRIMARY KEY IDENTITY(1,1),
    ClientName NVARCHAR(200) UNIQUE NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE()
);
PRINT ' Created timesheet.Client';

-- =============================================
-- 3. PROJECT TABLE
-- =============================================
CREATE TABLE timesheet.Project (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName NVARCHAR(200) NOT NULL,
    ClientID INT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Project_Client FOREIGN KEY (ClientID) 
        REFERENCES timesheet.Client(ClientID)
);
PRINT ' Created timesheet.Project';

-- =============================================
-- 4. TIME ENTRY TABLE
-- =============================================
CREATE TABLE timesheet.TimeEntry (
    TimeEntryID BIGINT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,
    EntryDate DATE NOT NULL,
    DayOfWeek VARCHAR(20) NULL,
    HoursWorked DECIMAL(5,2) NOT NULL,
    IsBillable BIT DEFAULT 0,
    Comments NVARCHAR(500) NULL,
    StartTime TIME NULL,
    EndTime TIME NULL,
    Month VARCHAR(20) NULL,
    SourceFile VARCHAR(255) NULL,
    SourcePath VARCHAR(500) NULL,
    BatchID UNIQUEIDENTIFIER NULL,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    
    CONSTRAINT FK_TimeEntry_Employee 
        FOREIGN KEY (EmployeeID) REFERENCES timesheet.Employee(EmployeeID),
    CONSTRAINT FK_TimeEntry_Project 
        FOREIGN KEY (ProjectID) REFERENCES timesheet.Project(ProjectID),
    CONSTRAINT CHK_HoursWorked CHECK (HoursWorked >= 0 AND HoursWorked <= 24)
);
PRINT ' Created timesheet.TimeEntry';

-- =============================================
-- 5. AUDIT LOG TABLE
-- =============================================
CREATE TABLE audit.ETLLog (
    LogID BIGINT PRIMARY KEY IDENTITY(1,1),
    BatchID UNIQUEIDENTIFIER NOT NULL,
    EmployeeCode VARCHAR(50) NULL,
    EmployeeName VARCHAR(100) NULL,
    Month VARCHAR(20) NULL,
    SourceFile VARCHAR(255) NULL,
    SourcePath VARCHAR(500) NULL,
    RowsProcessed INT DEFAULT 0,
    RowsInserted INT DEFAULT 0,
    RowsRejected INT DEFAULT 0,
    StatusCode INT NOT NULL,  -- 0=Success, 1=Warning, 2=Error
    StatusMessage NVARCHAR(500) NULL,
    ErrorMessage NVARCHAR(MAX) NULL,
    StartedAt DATETIME2 DEFAULT GETUTCDATE(),
    CompletedAt DATETIME2 NULL,
    DurationSeconds AS DATEDIFF(SECOND, StartedAt, CompletedAt)
);
PRINT ' Created audit.ETLLog';

PRINT ' All tables created!';