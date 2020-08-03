SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
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
   seeding_mode_desc   = CONVERT(nvarchar(60)  , NULL),
   version = CONVERT(smallint, NULL),
   basic_features = CONVERT (bit, NULL),
   dtc_support = CONVERT (bit, NULL),
   db_failover = CONVERT (bit, NULL),
   is_distributed = CONVERT (bit, NULL)
)
select m.* from potential_columns
CROSS APPLY 
(
select name as AGName, failure_condition_level, health_check_timeout, automated_backup_preference_desc, version, basic_features, dtc_support, db_failover, is_distributed  from  sys.availability_groups 
) AS m;
END
