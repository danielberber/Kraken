SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
SELECT  
SERVERPROPERTY('Edition') AS Edition,
SERVERPROPERTY('ProductVersion') AS ProductVersion,
SERVERPROPERTY('ProductLevel') AS ProductLevel,
SERVERPROPERTY('Collation') as Collation,
SERVERPROPERTY('ProductUpdateLevel') as ProductUpdateLevel,
SERVERPROPERTY('ProductUpdateReference') as ProductUpdateReference,
SERVERPROPERTY('ResourceLastUpdateDateTime') as ResourceLastUpdateDateTime,
SERVERPROPERTY('HadrManagerStatus') AS HadrManagerStatus,
SERVERPROPERTY('IsAdvancedAnalyticsInstalled') AS IsAdvancedAnalyticsInstalled,
SERVERPROPERTY('IsHadrEnabled') AS IsHadrEnabled,
SERVERPROPERTY('IsClustered') AS IsClustered,
SERVERPROPERTY('IsFullTextInstalled') AS IsFullTextInstalled,
SERVERPROPERTY ('IsSingleUser') as IsSingleUser,
SERVERPROPERTY('IsXTPSupported') as IsXTPSupported,
SERVERPROPERTY('IsPolyBaseInstalled') as IsPolyBaseInstalled,
SERVERPROPERTY('IsIntegratedSecurityOnly') as IsIntegratedSecurityOnly,
SERVERPROPERTY('IsBigDataCluster') as IsBigDataCluster,
SERVERPROPERTY('FilestreamEffectiveLevel') as FilestreamEffectiveLevel,
create_date as SQLInstallDate
FROM sys.server_principals
WHERE sid = 0x010100000000000512000000