
USE dbTest
GO

CREATE TABLE myData
(
	idRow int,
	colvalue varchar(50)
)
GO

INSERT INTO myData VALUES 
	(1, 'Andrea'),
	(2, 'Fabio'),
	(3, 'Gianluca'),
	(4, 'Alessandro'),
	(5, 'Luca')
GO

SELECT * FROM dbTest
GO

/*
Tipically:

sys.dm_db_database_page_allocations: to help replace DBCC PAGE and DBCC IND 
Undocumented commands designed to inspect the pages of an index or a table
*/
SELECT 
	*
FROM sys.dm_db_database_page_allocations(
			db_id('dbTest'), 
			object_id('myData'), 0, null, 
			'DETAILED')
WHERE 
	page_type_desc = 'DATA_PAGE'
GO


/*
Now, with SQL 2019, we can use the new DMV: sys.dm_db_page_info

The function show information which is available in the page header,
with a lot of interesting details
*/
SELECT p_info.*
FROM sys.dm_db_database_page_allocations(
	db_id('dbTest'), object_id('myData'), 0, null, 'DETAILED') p_alloc
CROSS APPLY sys.dm_db_page_info(
	p_alloc.database_id, p_alloc.allocated_page_file_id, p_alloc.allocated_page_page_id, 'DETAILED') AS p_info
WHERE 
	p_alloc.page_type_desc = 'DATA_PAGE'
GO
