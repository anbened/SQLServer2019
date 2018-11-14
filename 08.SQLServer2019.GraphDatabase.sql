

USE  dbTest;
go

-- Create NODE tables
CREATE TABLE Person 
(
  ID INTEGER PRIMARY KEY, 
  name VARCHAR(100)
) AS NODE;

CREATE TABLE City 
(
  ID INTEGER PRIMARY KEY, 
  name VARCHAR(100), 
  stateName VARCHAR(100)
) AS NODE;

-- Create EDGE tables. 
CREATE TABLE likes (rating INTEGER) AS EDGE;


-- Insert data into node tables. Inserting into a node table is same as inserting into a regular table
INSERT INTO Person VALUES (1,'John');
INSERT INTO Person VALUES (2,'Mary');
INSERT INTO City VALUES (1,'Bellevue','wa');
GO

select * from Person
select * from City
select * from Likes
GO


/* NEW from SQL Server 2019 */
--> CONSTRAINT [ConstraintName] CONNECTION ([SourceTableName] TO [DestinationTableName])
ALTER TABLE dbo.likes ADD CONSTRAINT ecLikes CONNECTION (Person TO City)
GO


-- Insert into edge table. While inserting into an edge table, 
-- you need to provide the $node_id from $from_id and $to_id columns.

--> OK
INSERT INTO likes VALUES ((SELECT $node_id FROM Person WHERE id = 1), 
       (SELECT $node_id FROM City WHERE id = 1),9);

--> OK
INSERT INTO likes VALUES ((SELECT $node_id FROM Person WHERE id = 2), 
      (SELECT $node_id FROM City WHERE id = 1),9);

--> ERROR
INSERT INTO likes VALUES ((SELECT $node_id FROM Person WHERE id = 3), 
      (SELECT $node_id FROM City WHERE id = 2),9);


-- Find City that John likes
SELECT City.name
FROM Person, likes, City
WHERE MATCH (Person-(likes)->City)
AND Person.name = 'John';
GO


/* drop objects */
drop table [dbo].[likes]
drop table [dbo].[City]
drop table [dbo].[Person]
GO