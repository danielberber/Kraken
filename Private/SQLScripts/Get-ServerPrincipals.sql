SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
;WITH potential_columns AS
(
  SELECT 
    -- in case we do encounter the old columns:
   owning_principal_id = CONVERT (int, NULL),
   is_fixed_role = CONVERT (bit, NULL)
)
select sp.* from potential_columns
CROSS APPLY 
(
select name as login_name, 
principal_id, 
sid, 
type, 
type_desc, 
is_disabled,
create_date, 
modify_date, 
default_database_name, 
default_language_name, 
credential_id, 
owning_principal_id, 
is_fixed_role 
FROM sys.server_principals
) AS sp;