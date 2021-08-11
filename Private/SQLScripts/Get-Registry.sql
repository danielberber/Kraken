SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON

IF OBJECT_ID('tempdb..#dep') IS NOT NULL BEGIN 
       DROP TABLE #dep 
END
CREATE TABLE #dep (
       Value VARCHAR(1024) NOT NULL,
       ServiceName VARCHAR(1024) NOT NULL,
       Data VARCHAR(1024) NULL
)

--Get SQL Service Dependencies
DECLARE @key2 VARCHAR(512) = 'SYSTEM\CurrentControlSet\Services\MSSQL$' + ISNULL(CAST(SERVERPROPERTY('InstanceName') AS VARCHAR(64)), '')
DECLARE @FullKey varchar(512) =  'HKLM\' + @key2

INSERT INTO #dep ( Value,  ServiceName, Data)
EXEC master..xp_regread @rootkey = 'HKEY_LOCAL_MACHINE',
       @key = @key2,
       @value_name = 'DependOnService'

DECLARE @depends VARCHAR(8000) = (SELECT STUFF(( 
       SELECT ', ' + d.ServiceName FROM #dep d
       FOR XML PATH('') 
), 1, 2, ''))

--Get Everything else

DECLARE @value VARCHAR(64),   @key VARCHAR(512) = 'SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\'    

EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @key = @key,  @value_name = 'ActivePowerScheme',  @value = @value OUTPUT;  

--Get Host Name
DECLARE @hostvalue VARCHAR(64),   @hostkey VARCHAR(512) = 'Software\Microsoft\Virtual Machine\Guest\Parameters'  

EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @hostkey = @hostkey,  @value_name = 'HostName',  @hostvalue = @hostvalue OUTPUT; 


SELECT 'powerplan' as setting_name, 'HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\' as registry_key,  
'ActivePowerScheme' as  value_name, value_data = CASE @value  WHEN '381b4222-f694-41f0-9685-ff5bb260df2e' THEN 'Balanced'  
WHEN '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c' THEN 'High Performance'  
WHEN 'a1841308-3541-4fab-bc81-f71556f20b4a' THEN 'Power Saver'  
Else @value  
END
UNION
SELECT 'hyperv_host' as setting_name, 'HKLM\Software\Microsoft\Virtual Machine\Guest\Parameters' as registry_key, 'HostName' as value_name,
 @hostvalue as value_data
UNION  SELECT setting_name = CASE   
WHEN registry_key like '%SQLAgent%' and value_name = 'ObjectName' THEN   'sqlagent_account'   
WHEN registry_key like '%MSSQL%' and value_name = 'ObjectName' THEN   'sql_account'  
WHEN registry_key like '%SQLAgent%' and value_name = 'DependOnService' THEN   'sqlagent_dependencies'  
else value_name
END,  registry_key,  value_name,  value_data  
FROM sys.dm_server_registry  
WHERE (registry_key LIKE N'%HKLM\SYSTEM\CurrentControlSet\Services\%'  and value_name in ('ObjectName','DependOnService'))  or (registry_key like '%IPAll' and value_name in ('TcpPort','TcpDynamicPorts'))
UNION
SELECT 'sql_dependencies' as  setting_name,  @FullKey as registry_key, 'DependOnService' as value_name, @depends as dependencies