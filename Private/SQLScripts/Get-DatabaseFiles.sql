SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
CREATE TABLE #FileSize
(dbName NVARCHAR(128), 
    FileName NVARCHAR(128), 
    type_desc NVARCHAR(128),
    Size_MB DECIMAL(10,2), 
    Used_MB DECIMAL(10,2),
	physical_name nvarchar(255),
	[FileGroup] nvarchar(100),
	state_desc nvarchar(60),
	growth int,
	max_size int,
	is_media_read_only bit,
	is_read_only bit,
	is_sparse bit,
	is_percent_growth bit
);
    
INSERT INTO #FileSize(dbName, FileName, type_desc, Size_MB, Used_MB, physical_name, FileGroup, state_desc, growth, max_size, is_media_read_only, is_read_only, is_sparse, is_percent_growth)
exec sp_msforeachdb 
'use [?]; 
 SELECT DB_NAME() AS DbName, 
        DF.name AS FileName, 
        DF.type_desc,
        DF.size/128.0 AS Size_MB,  
        CAST(FILEPROPERTY(DF.name, ''SpaceUsed'') AS INT)/128.0 AS Used_MB,
		DF.physical_name,
		FG.Name,
		DF.state_desc,
		DF.growth,
		DF.max_size,
		DF.is_media_read_only,
		DF.is_read_only,
		DF.is_sparse,
		DF.is_percent_growth
FROM sys.database_files DF
left outer JOIN
sys.filegroups AS FG
ON
DF.data_space_id = FG.data_space_id';
    
SELECT * 
FROM #FileSize
    
DROP TABLE #FileSize;