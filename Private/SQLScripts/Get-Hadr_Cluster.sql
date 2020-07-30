--  9 = 2005              13 = 2016
-- 10 = 2008/2008 R2      14 = 2017
-- 11 = 2012              15 = 2019
-- 12 = 2014
DECLARE @MajorVersion int, @sql nvarchar(max); 

SET @MajorVersion = CONVERT(int,PARSENAME(CONVERT(varchar(32),
   SERVERPROPERTY('ProductVersion')),4));

IF @MajorVersion >= 11
BEGIN
select * from sys.dm_hadr_cluster
END