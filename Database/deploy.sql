-- Create database Cloud-tunnel-JP
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Cloud-tunnel-JP')
BEGIN
    EXECUTE('CREATE DATABASE [Cloud-tunnel-JP]');
    PRINT 'Database [Cloud-tunnel-JP] created successfully';
END
GO

USE [Cloud-tunnel-JP];
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'People')
BEGIN
    CREATE TABLE People (
        PersonID INT IDENTITY(1,1) PRIMARY KEY,
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'People table created successfully';
END
GO
INSERT INTO People (FirstName, LastName) VALUES 
('Jabulane', 'Poulo'),
('Thabo', 'Nkosi'),
('Lerato', 'Mbeki'),
('Sipho', 'Dlamini'),
('Nomsa', 'Zulu'),
('Alice', 'Johnson'),
('Bob', 'Smith'),
('Carol', 'Davis'),
('David', 'Wilson'),
('Eve', 'Brown'),
('Frank', 'Miller'),
('Grace', 'Taylor'),
('Hannah', 'Anderson'),
('Ian', 'Thomas'),
('Jack', 'Moore'),
('Karen', 'Jackson'),
('Leo', 'White'),
('Mia', 'Harris'),
('Nina', 'Martin'),
('Oscar', 'Garcia'),
('Paul', 'Clark'),
('Quincy', 'Rodriguez'),
('Rachel', 'Lewis'),
('Steve', 'Lee'),
('Tina', 'Walker'),
('Uma', 'Hall'),


('Victor', 'Allen'),
('Wendy', 'Young'),
('Xavier', 'King'),
('Yvonne', 'Wright'),
('Zach', 'Scott'),
('Ava', 'Green'),
('Ben', 'Adams'),
('Cathy', 'Baker'),
('Dan', 'Gonzalez'),
('Ella', 'Nelson'),
('Fred', 'Carter'),
('Gina', 'Mitchell'),
('Harry', 'Perez'),
('Ivy', 'Roberts'),
('Jake', 'Turner');




GO
SELECT PersonID, FirstName, LastName, CreatedDate FROM People;
GO

PRINT 'Deployment completed successfully';
