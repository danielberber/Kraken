SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
SELECT name, create_date, modify_date, sid,
LOGINPROPERTY(name, 'BadPasswordCount') AS 'BadPasswordCount'
,LOGINPROPERTY(name, 'BadPasswordTime') AS 'BadPasswordTime'
,LOGINPROPERTY(name, 'DaysUntilExpiration') AS 'DaysUntilExpiration'
,LOGINPROPERTY(name, 'DefaultDatabase') AS 'DefaultDatabase'
,LOGINPROPERTY(name, 'DefaultLanguage') AS 'DefaultLanguage'
,LOGINPROPERTY(name, 'HistoryLength') AS 'HistoryLength'
,LOGINPROPERTY(name, 'IsExpired') AS 'IsExpired'
,LOGINPROPERTY(name, 'IsLocked') AS 'IsLocked'
,LOGINPROPERTY(name, 'IsMustChange') AS 'IsMustChange'
,LOGINPROPERTY(name, 'LockoutTime') AS 'LockoutTime'
,LOGINPROPERTY(name, 'PasswordLastSetTime') AS 'PasswordLastSetTime'
,is_policy_checked
,is_expiration_checked
FROM    sys.sql_logins