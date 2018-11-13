
USE dbTest
GO

CREATE TABLE people
(
	idRow int,
	name varchar(50),
	surname varchar(50),
	ssn varchar(15),
	emailAddress varchar(50),
	hashedPassword varchar(20)
)
GO

insert people values (1, 'aaa', 'bbb', '123-xxx-123', 'aaa@bbb.com', 'x0138fakag')
GO

/* view data*/
select * from people
go

/* 
	The Classify data features adds extended properties 
	to the columns to specify the label and the information type.  
*/


/* Data Classification, in SSMS: right click on db --> Tasks --> Data Discovery and Classification --> Classify Data */
/* recommendations --> click to view --> select checkbox */
/* accept selected recommendations --> save */



/* all the columns in a database where we defined the data classification */
SELECT
	Schema_name(objects.schema_id) AS schema_name, 
	objects.NAME AS table_name, 
	columns.NAME AS column_name, 
	ISNULL(EP.information_type_name,'') AS  information_type_name,
	ISNULL(EP.sensitivity_label_name,'') AS  sensitivity_label_name
FROM 
(
	SELECT ISNULL(EC1.major_id,EC2.major_id) AS major_id, 
      ISNULL(EC1.minor_id,EC2.minor_id) AS minor_id, 
      EC1.information_type_name, 
      EC2.sensitivity_label_name 
      FROM 
		(
			SELECT major_id, minor_id,
              NULLIF(value,'') AS information_type_name
			FROM sys.extended_properties 
            WHERE NAME = 'sys_information_type_name'
		) EC1
            FULL OUTER JOIN 
				(
					SELECT major_id, minor_id, 
						NULLIF(value,'') AS sensitivity_label_name
					FROM sys.extended_properties 
                    WHERE  NAME = 'sys_sensitivity_label_name') EC2 
                    ON ( EC2.major_id = EC1.major_id AND EC2.minor_id = EC1.minor_id )
				) EP 
 JOIN sys.objects objects ON EP.major_id = objects.object_id 
 JOIN sys.columns columns ON ( EP.major_id = columns.object_id AND EP.minor_id = columns.column_id )
GO


/* drop objects */
drop table people
go
