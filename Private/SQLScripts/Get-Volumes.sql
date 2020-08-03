SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
SELECT DISTINCT
  vs.volume_mount_point AS [volume],
  vs.logical_volume_name AS [label],
  vs.file_system_type,
  vs.total_bytes/1024/1024 AS [size_mb],
  vs.available_bytes/1024/1024 AS [free_space_mb],
  vs.supports_compression,
  vs.supports_alternate_streams,
  vs.supports_sparse_files,
  vs.is_read_only,
  vs.is_compressed
FROM sys.master_files AS f
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id) AS vs
ORDER BY vs.volume_mount_point;