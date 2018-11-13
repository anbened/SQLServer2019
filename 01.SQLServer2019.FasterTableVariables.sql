
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


declare @VoteStats table (PostId int, up int, down int) 
 
insert @VoteStats
select
    PostId, 
    up = sum(case when VoteTypeId = 2 then 1 else 0 end), 
    down = sum(case when VoteTypeId = 3 then 1 else 0 end)
from Votes
where VoteTypeId in (2,3)
group by PostId
 
select top 100 p.Id as [Post Link] , up, down 
from @VoteStats 
join Posts p on PostId = p.Id
where down > (up * 0.5) and p.CommunityOwnedDate is null and p.ClosedDate is null
order by up desc
GO
