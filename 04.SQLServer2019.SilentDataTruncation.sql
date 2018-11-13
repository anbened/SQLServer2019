
/*
USE Master
GO

CREATE DATABASE dbTest
GO

USE dbTest
GO
*/

DBCC TRACEON(460)
GO

CREATE TABLE insertTest
(
	col varchar(5)
)
GO

INSERT insertTest (col) 
VALUES 
	('ciao'),
	('test'),
	('altro ciao')
GO

DROP TABLE insertTest
GO

