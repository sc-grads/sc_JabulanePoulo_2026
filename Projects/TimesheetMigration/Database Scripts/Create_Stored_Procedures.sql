USE TimesheetDB;
GO

-- =============================================
-- UPSERT EMPLOYEE
-- =============================================
CREATE OR ALTER PROCEDURE timesheet.UpsertEmployee
    @EmployeeCode VARCHAR(50),
    @FullName NVARCHAR(200),
    @EmployeeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT @EmployeeID = EmployeeID 
    FROM timesheet.Employee 
    WHERE EmployeeCode = @EmployeeCode
    
    IF @EmployeeID IS NULL
    BEGIN
        INSERT INTO timesheet.Employee (EmployeeCode, FullName, CreatedAt)
        VALUES (@EmployeeCode, @FullName, GETUTCDATE())
        SET @EmployeeID = SCOPE_IDENTITY()
    END
END
GO

-- =============================================
-- UPSERT CLIENT
-- =============================================
CREATE OR ALTER PROCEDURE timesheet.UpsertClient
    @ClientName NVARCHAR(200),
    @ClientID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT @ClientID = ClientID 
    FROM timesheet.Client 
    WHERE ClientName = @ClientName
    
    IF @ClientID IS NULL
    BEGIN
        INSERT INTO timesheet.Client (ClientName, CreatedAt)
        VALUES (@ClientName, GETUTCDATE())
        SET @ClientID = SCOPE_IDENTITY()
    END
END
GO

-- =============================================
-- UPSERT PROJECT
-- =============================================
CREATE OR ALTER PROCEDURE timesheet.UpsertProject
    @ProjectName NVARCHAR(200),
    @ClientID INT = NULL,
    @ProjectID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT @ProjectID = ProjectID 
    FROM timesheet.Project 
    WHERE ProjectName = @ProjectName 
      AND (ClientID = @ClientID OR (@ClientID IS NULL AND ClientID IS NULL))
    
    IF @ProjectID IS NULL
    BEGIN
        INSERT INTO timesheet.Project (ProjectName, ClientID, CreatedAt)
        VALUES (@ProjectName, @ClientID, GETUTCDATE())
        SET @ProjectID = SCOPE_IDENTITY()
    END
END
GO

-- =============================================
-- GET BATCH SUMMARY
-- =============================================
CREATE OR ALTER PROCEDURE audit.GetBatchSummary
    @BatchID UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        l.BatchID,
        l.EmployeeName,
        l.Month,
        COUNT(DISTINCT l.SourceFile) AS TotalFiles,
        SUM(l.RowsProcessed) AS TotalRows,
        SUM(l.RowsInserted) AS TotalInserted,
        MAX(l.StatusCode) AS Status,
        MIN(l.StartedAt) AS StartTime,
        MAX(l.CompletedAt) AS EndTime
    FROM audit.ETLLog l
    WHERE l.BatchID = @BatchID
    GROUP BY l.BatchID, l.EmployeeName, l.Month;
END
GO

-- =============================================
-- GET EMPLOYEE SUMMARY
-- =============================================
CREATE OR ALTER PROCEDURE timesheet.GetEmployeeSummary
    @EmployeeCode VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        e.EmployeeCode,
        e.FullName,
        COUNT(te.TimeEntryID) AS TotalEntries,
        SUM(te.HoursWorked) AS TotalHours,
        SUM(CASE WHEN te.IsBillable = 1 THEN te.HoursWorked ELSE 0 END) AS BillableHours,
        SUM(CASE WHEN te.IsBillable = 0 THEN te.HoursWorked ELSE 0 END) AS NonBillableHours,
        MIN(te.EntryDate) AS FirstEntry,
        MAX(te.EntryDate) AS LastEntry
    FROM timesheet.Employee e
    LEFT JOIN timesheet.TimeEntry te ON e.EmployeeID = te.EmployeeID
    WHERE @EmployeeCode IS NULL OR e.EmployeeCode = @EmployeeCode
    GROUP BY e.EmployeeCode, e.FullName
    ORDER BY e.FullName;
END
GO

PRINT ' Stored procedures created!';