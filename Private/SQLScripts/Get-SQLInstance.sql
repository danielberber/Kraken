SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
select id, instance_name, environment, active from dbo.sql_instances where active = 1