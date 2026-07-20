USE [TimesheetsDB]
GO

-- =============================================
-- SCRIPT: Simulated ETL Audit Logging
-- PURPOSE: Demonstrates how to populate [audit].[AuditLog]
--          in a realistic, scripted manner
-- =============================================

DECLARE @RunNumber INT = CAST(CAST(GETDATE() AS FLOAT) * 1000 AS INT) -- Generates a unique run number based on time
DECLARE @StepCounter INT = 1
DECLARE @TotalSteps INT = 10
DECLARE @LogSource NVARCHAR(500) = 'Daily ETL Job - ' + FORMAT(GETDATE(), 'yyyy-MM-dd')
DECLARE @TaskName NVARCHAR(200)
DECLARE @StartTime DATETIME
DECLARE @EndTime DATETIME
DECLARE @DurationMs INT
DECLARE @Status VARCHAR(50)
DECLARE @Message NVARCHAR(MAX)
DECLARE @RowsInserted INT
DECLARE @RowsUpdated INT
DECLARE @RowsDeleted INT
DECLARE @TargetTable NVARCHAR(100)

-- Loop through simulated ETL steps
WHILE @StepCounter <= @TotalSteps
BEGIN
    -- 1. Setup variables for this specific step
    SET @TaskName = 'Process Step #' + CAST(@StepCounter AS VARCHAR(3)) + ' - ' + 
                    CASE @StepCounter 
                        WHEN 1 THEN 'Extract Sales Data'
                        WHEN 2 THEN 'Extract Customer Data'
                        WHEN 3 THEN 'Transform Sales'
                        WHEN 4 THEN 'Transform Inventory'
                        WHEN 5 THEN 'Load FactSales'
                        WHEN 6 THEN 'Load DimCustomer'
                        WHEN 7 THEN 'Load DimDate'
                        WHEN 8 THEN 'Apply Business Rules'
                        WHEN 9 THEN 'Run Aggregations'
                        WHEN 10 THEN 'Clean Up Staging'
                    END
    
    SET @TargetTable = CASE 
                        WHEN @StepCounter IN (1,2) THEN 'staging.' + SUBSTRING(@TaskName, 19, 20)
                        WHEN @StepCounter IN (5,6,7) THEN 'dbo.' + SUBSTRING(@TaskName, 18, 20)
                        ELSE NULL
                      END

    -- 2. LOG THE START EVENT
    INSERT INTO [audit].[AuditLog] (
        RunNumber, LogSource, TaskName, LogStatus, 
        TargetTable, Message, ExecutedBy
    )
    VALUES (
        @RunNumber, @LogSource, @TaskName, 'Started',
        @TargetTable, 
        'Beginning execution of step...', 
        SYSTEM_USER
    );

    -- 3. Simulate processing (sleep for random seconds to make it look real)
    SET @StartTime = GETDATE();
    
    -- FIX: Pad the random number with a leading zero to ensure proper 'hh:mi:ss' format
    DECLARE @DelaySeconds INT = CAST(RAND() * 5 AS INT);
    DECLARE @DelayTime VARCHAR(8) = '00:00:' + RIGHT('0' + CAST(@DelaySeconds AS VARCHAR(2)), 2);
    
    WAITFOR DELAY @DelayTime; 

    -- 4. Simulate random failure (10% chance of failure)
    IF @StepCounter = 5 AND RAND() > 0.9 
    BEGIN
        SET @Status = 'Failed';
        SET @Message = 'ERROR: Connection timeout to destination server.';
        SET @RowsInserted = 0;
        SET @RowsUpdated = 0;
        SET @RowsDeleted = 0;
    END
    ELSE
    BEGIN
        SET @Status = 'Succeeded';
        SET @Message = 'Step completed without errors.';
        -- Simulate some row counts
        SET @RowsInserted = CAST(RAND() * 5000 AS INT) + 100;
        SET @RowsUpdated = CAST(RAND() * 1000 AS INT) + 50;
        SET @RowsDeleted = CAST(RAND() * 100 AS INT) + 5;
    END

    -- 5. Calculate Duration
    SET @EndTime = GETDATE();
    SET @DurationMs = DATEDIFF(MILLISECOND, @StartTime, @EndTime);

    -- 6. LOG THE COMPLETE EVENT
    INSERT INTO [audit].[AuditLog] (
        RunNumber, LogSource, TaskName, LogStatus, 
        RowsInserted, RowsUpdated, RowsDeleted, 
        TargetTable, ExecutionDurationMs, Message, 
        ExecutedBy
    )
    VALUES (
        @RunNumber, @LogSource, @TaskName, @Status,
        @RowsInserted, @RowsUpdated, @RowsDeleted,
        @TargetTable, @DurationMs, @Message,
        SYSTEM_USER
    );

    -- Increment counter
    SET @StepCounter = @StepCounter + 1;
END

-- =============================================
-- FINAL STEP: View the results to prove it worked
-- =============================================
SELECT 
    LogID,
    RunNumber,
    LogDateTime,
    LogSource,
    TaskName,
    LogStatus,
    TargetTable,
    RowsInserted,
    RowsUpdated,
    ExecutionDurationMs,
    Message
FROM [audit].[AuditLog]
WHERE RunNumber = @RunNumber
ORDER BY TaskName, LogDateTime;