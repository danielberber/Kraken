--  9 = 2005              13 = 2016
-- 10 = 2008/2008 R2      14 = 2017
-- 11 = 2012              15 = 2019
-- 12 = 2014
DECLARE @MajorVersion int, @sql nvarchar(max); 

SET @MajorVersion = CONVERT(int,PARSENAME(CONVERT(varchar(32),
   SERVERPROPERTY('ProductVersion')),4));

IF @MajorVersion >= 11
BEGIN
;WITH potential_columns AS
(
  SELECT 
    -- in case we do encounter the old columns:
   seeding_mode_desc   = CONVERT(nvarchar(60), NULL)
)
select m.* from potential_columns
CROSS APPLY 
(
 SELECT AG.name as AGName, AR.replica_server_name, SUSER_SNAME(AR.owner_sid) as [replica_owner],RS.is_local, role_desc, operational_state_desc, connected_state_desc, recovery_health_desc, synchronization_health_desc, AR.endpoint_url, AR.availability_mode_desc,
AR.failover_mode_desc, AR.session_timeout, AR.primary_role_allow_connections_desc, AR.secondary_role_allow_connections_desc, AR.create_date, AR.modify_date, Ar.backup_priority, AR.read_only_routing_url, seeding_mode_desc
from sys.availability_groups AG
join sys.dm_hadr_availability_replica_states RS
on AG.group_id = RS.group_id
join sys.availability_replicas AR
on RS.replica_id = AR.replica_id
) AS m;
END