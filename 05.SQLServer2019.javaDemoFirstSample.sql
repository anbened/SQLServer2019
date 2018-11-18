

EXEC sp_configure 'external scripts enabled', 1
RECONFIGURE WITH OVERRIDE
-- No restart is required after this step as of SQl Server 2019


USE dbTest
go

DROP TABLE IF exists reviews;
GO

CREATE TABLE reviews
(
    id int NOT NULL,
    myText nvarchar(30) NOT NULL
)
GO

INSERT INTO reviews(id, myText) VALUES (1, 'AAA BBB CCC DDD EEE FFF')
INSERT INTO reviews(id, myText) VALUES (2, 'GGG HHH III JJJ KKK LLL')
INSERT INTO reviews(id, myText) VALUES (3, 'MMM NNN OOO PPP QQQ RRR')
GO

/*
copy CLASS file to /home/myclasspath/pkg
*/

/*
# Ubuntu install commands
sudo apt-get install mssql-server-extensibility-java
*/



DECLARE @myClassPath nvarchar(50)
DECLARE @n int 
--This is where you store your classes or jars.
--Update this to your own classpath
SET @myClassPath = N'/home/myclasspath/pkg/'
--This is the size of the ngram
SET @n = 3
EXEC sp_execute_external_script
	  @language = N'Java'
	, @script = N'pkg.Ngram.getNGrams'
	, @input_data_1 = N'SELECT id, myText FROM reviews'
	, @parallel = 0
	, @params = N'@CLASSPATH nvarchar(30), @param1 INT'
	, @CLASSPATH = @myClassPath
	, @param1 = @n
with result sets ((ID int, ngram varchar(20)))
GO
