USE TimesheetDB;
GO

-- TimeEntry Indexes
CREATE INDEX IX_TimeEntry_EmployeeID ON timesheet.TimeEntry(EmployeeID);
CREATE INDEX IX_TimeEntry_ProjectID ON timesheet.TimeEntry(ProjectID);
CREATE INDEX IX_TimeEntry_EntryDate ON timesheet.TimeEntry(EntryDate);
CREATE INDEX IX_TimeEntry_BatchID ON timesheet.TimeEntry(BatchID);
CREATE INDEX IX_TimeEntry_IsBillable ON timesheet.TimeEntry(IsBillable);
CREATE INDEX IX_TimeEntry_Month ON timesheet.TimeEntry(Month);

-- Audit Log Indexes
CREATE INDEX IX_ETLLog_BatchID ON audit.ETLLog(BatchID);
CREATE INDEX IX_ETLLog_StartedAt ON audit.ETLLog(StartedAt);
CREATE INDEX IX_ETLLog_StatusCode ON audit.ETLLog(StatusCode);
CREATE INDEX IX_ETLLog_EmployeeCode ON audit.ETLLog(EmployeeCode);
CREATE INDEX IX_ETLLog_Month ON audit.ETLLog(Month);

PRINT ' Indexes created!';