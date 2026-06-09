-- Create database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Cloud-tunnel-JP')
BEGIN
    EXECUTE('CREATE DATABASE [Cloud-tunnel-JP]');
END
GO

USE [Cloud-tunnel-JP];
GO

-- Create simple table
CREATE TABLE People (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);
GO

-- Insert random names
INSERT INTO People (FirstName, LastName) VALUES 
('Jabulane', 'Poulo'),
('Thabo', 'Nkosi'),
('Lerato', 'Mbeki'),
('Sipho', 'Dlamini'),
('Nomsa', 'Zulu');
GO

SELECT * FROM People;
GO
