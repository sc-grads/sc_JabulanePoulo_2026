-- =============================================
-- Create RunTimesheetDevTestMigrationPK Job
-- =============================================

USE msdb;
GO

-- Delete existing job if it exists (to avoid conflicts)
IF EXISTS (SELECT 1 FROM sysjobs WHERE name = 'RunTimesheetDevTestMigrationPK')
BEGIN
    EXEC msdb.dbo.sp_delete_job @job_name = N'RunTimesheetDevTestMigrationPK';
    PRINT 'Existing job deleted: RunTimesheetDevTestMigrationPK';
END
GO

-- Create the job
DECLARE @jobId BINARY(16);

EXEC msdb.dbo.sp_add_job 
    @job_name = N'RunTimesheetDevTestMigrationPK',
    @enabled = 1,
    @notify_level_eventlog = 0,
    @notify_level_email = 0,
    @notify_level_netsend = 0,
    @notify_level_page = 0,
    @delete_level = 0,
    @description = N'Timesheet Migration SSIS Package - DevTest',
    @category_name = N'[Uncategorized (Local)]',
    @owner_login_name = N'sa',
    @job_id = @jobId OUTPUT;

-- Add job step with CORRECT package path
EXEC msdb.dbo.sp_add_jobstep 
    @job_name = N'RunTimesheetDevTestMigrationPK',
    @step_name = N'Run SSIS Package',
    @step_id = 1,
    @cmdexec_success_code = 0,
    @on_success_action = 1,
    @on_success_step_id = 0,
    @on_fail_action = 2,
    @on_fail_step_id = 0,
    @retry_attempts = 0,
    @retry_interval = 0,
    @os_run_priority = 0,
    @subsystem = N'SSIS',
    -- UPDATED: Uses the correct path from your environment
    @command = N'/ISSERVER "\"\SSISDB\TimesheetDevTestMigration\TimesheetMigration1\TimesheetMigration.dtsx\"" /SERVER "\"\"localhost\"\"" /Par "\"\"$ServerOption::LOGGING_LEVEL(Int16)\"\"\";1 /Par "\"\"$ServerOption::SYNCHRONIZED(Boolean)\"\"\";True /CALLERINFO SQLAGENT /REPORTING E',
    @database_name = N'master',
    @flags = 0;

EXEC msdb.dbo.sp_add_jobserver 
    @job_name = N'RunTimesheetDevTestMigrationPK',
    @server_name = N'(local)';

PRINT '✅ Job created successfully: RunTimesheetDevTestMigrationPK';
PRINT '📦 Package path: \SSISDB\TimesheetDevTestMigration\TimesheetMigration1\TimesheetMigration.dtsx';
GO