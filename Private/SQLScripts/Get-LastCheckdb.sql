SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON

if object_id('tempdb..#dblist') is not NULL drop table #dblist
declare @name sysname, @cmd varchar(max)
declare @dbinfo table (db_name sysname NULL, ParentObject nvarchar(50),
Object nvarchar(50),Field nvarchar(50),Value nvarchar(100))
select name, 'DBCC DBINFO('''+name+''') WITH TABLERESULTS' as cmd into #dblist
from sys.databases where name <> 'tempdb' and (state+is_in_standby) = 0
select top 1 @name=name, @cmd=cmd from #dblist order by name
while (@@ROWCOUNT > 0) begin
                insert into @dbinfo (ParentObject, Object, Field, Value) exec (@cmd)
                update @dbinfo set db_name = @name where db_name is null
                delete from #dblist where name = @name
                select top 1 @name=name, @cmd=cmd from #dblist order by name
end
select db_name, CONVERT(datetime2(7),value) as last_checkdb 
from @dbinfo where Field = 'dbi_dbccLastKnownGood'