SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
SELECT UPPER(SSP.name) LoginName,SSP.type_desc as 'Type',UPPER(SSPS.name) ServerRole,
                            SSP.is_disabled
                            ,SSP.default_database_name 
                            FROM sys.server_principals SSP  
                            INNER JOIN sys.server_role_members SSRM 
                            ON SSP.principal_id=SSRM.member_principal_id  
                            INNER JOIN sys.server_principals SSPS 
                            ON SSRM.role_principal_id = SSPS.principal_id