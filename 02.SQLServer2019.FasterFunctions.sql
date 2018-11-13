
/*
--> Include Actual Execution Plan <--

--> Compatibility SQL Server 2017 <--
USE [master]
GO
ALTER DATABASE [StackOverflow2010] SET COMPATIBILITY_LEVEL = 140
GO
USE [StackOverflow2010]
GO


--> Compatibility SQL Server 2019 <--
USE [master]
GO
ALTER DATABASE [StackOverflow2010] SET COMPATIBILITY_LEVEL = 150
GO
USE [StackOverflow2010]
GO
*/

CREATE OR ALTER FUNCTION dbo.ScalarFunction ( @uid INT )
RETURNS BIGINT
    WITH RETURNS NULL ON NULL INPUT, SCHEMABINDING
AS
    BEGIN
        DECLARE @BCount BIGINT;
        SELECT  @BCount = COUNT_BIG(*)
        FROM    dbo.Badges AS b
        WHERE   b.UserId = @uid
        GROUP BY b.UserId;
        RETURN @BCount;
    END;
GO


SELECT TOP 1000 
u.DisplayName, 
dbo.ScalarFunction(u.Id)
FROM dbo.Users AS u
GO


