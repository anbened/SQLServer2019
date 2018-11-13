


SELECT 'a' COLLATE Latin1_General_100_CI_AS_SC_UTF8;


SELECT col.[name],
       COLLATIONPROPERTY(col.[name], 'CodePage') AS [CodePage],
       COLLATIONPROPERTY(col.[name], 'Version') AS [Version]
FROM   sys.fn_helpcollations() col
WHERE  col.[name] LIKE N'%[_]UTF8'
ORDER BY col.[name];
-- 1552 rows, all with CodePage = 65001

/*
5507 total Collations in SQL Server 2019, which is 1552 more than the 3955 that exist in SQL Server 2017
*/

SELECT 
	NCHAR(27581), -- 殽
	CONVERT(VARCHAR(3), NCHAR(27581) COLLATE Latin1_General_100_CI_AS_SC), -- ?
	CONVERT(VARCHAR(3), NCHAR(27581) COLLATE Latin1_General_100_CI_AS_SC_UTF8); -- 殽
GO

