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
Select AG.name as ag_name, dns_name as listener_name, port, is_conformant, ip_address, ip_subnet_mask, is_dhcp, network_subnet_ip, network_subnet_prefix_length,
network_subnet_ipv4_mask, state, state_desc
from sys.availability_group_listeners GL
inner join sys.availability_groups AG
on GL.group_id = AG.group_id
inner join sys.availability_group_listener_ip_addresses AGLI
on AGLI.listener_id = GL.listener_id
END