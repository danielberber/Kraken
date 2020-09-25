SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON

IF OBJECT_ID ('tempdb..#dbsize', 'U') IS NOT NULL DROP TABLE #dbsize
create table #dbsize 
(DBName sysname, Size_MB decimal(30,2),Used_MB decimal(30,2)) 
  
insert into #dbsize(Dbname,Size_MB,Used_MB) 
exec sp_msforeachdb 
'use [?]; 
  select DB_NAME() AS DbName, 
sum(size)/128.0 AS File_Size_MB, 
sum(CAST(FILEPROPERTY(name, ''SpaceUsed'') AS INT))/128.0 as Space_Used_MB
from sys.database_files  where type=0 group by type' 
  
select * from #dbsize