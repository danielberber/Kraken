with DBs as (select name, type, database_id from sys.databases
cross apply (select 'L' as type union select 'D' as type union select 'I' as type) q)
select
d.name,
backup_start_date, backup_finish_date, d.type, device_type, is_copy_only,  compressed_backup_size, user_name
from (
SELECT database_name, type, device_type, is_copy_only, backup_start_date, backup_finish_date,
row_number() over(partition by database_name, type order by backup_start_date desc) rn,
compressed_backup_size, user_name
FROM msdb.dbo.backupset b JOIN msdb.dbo.backupmediafamily m 
ON b.media_set_id = m.media_set_id
where device_type = 2) q right join DBs d
on d.name = q.database_name and d.type = q.type
where (rn = 1 or rn is null) and d.database_id <> 2
order by name, d.type