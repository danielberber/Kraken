SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON

--SQL Version
DECLARE @MajorVersion int, @sql nvarchar(max); 
SET @MajorVersion = CONVERT(int,PARSENAME(CONVERT(varchar(32),SERVERPROPERTY('ProductVersion')),4));

--Registry Key for Windows
DECLARE @productname NVARCHAR(128),   
@currentbuild nvarchar(5),
@releaseid nvarchar(5),
@currentmajorversion int,
@currentminorversion int,
@currentversion nvarchar(5),
@oskey VARCHAR(512) = 'Software\Microsoft\Windows NT\CurrentVersion'  

IF @MajorVersion >= 14
BEGIN
DECLARE @os_type nvarchar(128)
set @os_type = (select host_platform from sys.dm_os_host_info)
IF @os_type = 'Windows'
BEGIN
EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @oskey = @oskey,  @value_name = 'CurrentBuild',  @currentbuild = @currentbuild OUTPUT; 
select host_platform, host_distribution, host_release, @currentbuild as os_build from sys.dm_os_host_info;
END
ELSE
BEGIN
select host_platform, host_distribution, host_release, null as os_build from sys.dm_os_host_info;
END
END
ELSE
BEGIN
EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @oskey = @oskey,  @value_name = 'ProductName',  @productname = @productname OUTPUT; 
EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @oskey = @oskey,  @value_name = 'CurrentBuild',  @currentbuild = @currentbuild OUTPUT; 
IF @currentbuild > 9600
BEGIN
EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @oskey = @oskey,  @value_name = 'CurrentMajorVersionNumber',  @currentmajorversion = @currentmajorversion OUTPUT; 
EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @oskey = @oskey,  @value_name = 'CurrentMinorVersionNumber',  @currentminorversion = @currentminorversion OUTPUT; 
select 'Windows' as host_platform, @productname as host_distribution, convert(nvarchar(5), @currentmajorversion) + '.' + convert(nvarchar(5), @currentminorversion) as host_release, @currentbuild as os_build
END
ELSE
BEGIN
EXEC master..xp_regread  @rootkey = 'HKEY_LOCAL_MACHINE',  @oskey = @oskey,  @value_name = 'CurrentVersion',  @currentversion = @currentversion OUTPUT; 
select 'Windows' as host_platform, @productname as host_distribution, @currentversion as host_release, @currentbuild as os_build
END
END