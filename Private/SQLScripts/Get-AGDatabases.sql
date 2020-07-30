--  9 = 2005              13 = 2016
-- 10 = 2008/2008 R2      14 = 2017
-- 11 = 2012              15 = 2019
-- 12 = 2014
DECLARE @MajorVersion int, @sql nvarchar(max); 

SET @MajorVersion = CONVERT(int,PARSENAME(CONVERT(varchar(32),
   SERVERPROPERTY('ProductVersion')),4));

IF @MajorVersion >= 11
BEGIN
SELECT
AG.name AS [AGName],
AR.replica_server_name,
arstates.role_desc,
arstates.is_local,
dbcs.database_name AS [DBName],
dbrs.synchronization_state_desc,
dbrs.is_suspended,
dbcs.is_database_joined,
dbcs.is_failover_ready,
dbrs.suspend_reason_desc
FROM master.sys.availability_groups AS AG
INNER JOIN master.sys.dm_hadr_availability_group_states as agstates
   ON AG.group_id = agstates.group_id
INNER JOIN master.sys.availability_replicas AS AR
   ON AG.group_id = AR.group_id
INNER JOIN master.sys.dm_hadr_availability_replica_states AS arstates
   ON AR.replica_id = arstates.replica_id
INNER JOIN master.sys.dm_hadr_database_replica_cluster_states AS dbcs
   ON arstates.replica_id = dbcs.replica_id
INNER JOIN master.sys.dm_hadr_database_replica_states AS dbrs
   ON dbcs.replica_id = dbrs.replica_id AND dbcs.group_database_id = dbrs.group_database_id
ORDER BY AG.name ASC, dbcs.database_name
END
