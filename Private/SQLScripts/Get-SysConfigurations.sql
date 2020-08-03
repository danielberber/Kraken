SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
select configuration_id, name, value, minimum, maximum, value_in_use from sys.configurations