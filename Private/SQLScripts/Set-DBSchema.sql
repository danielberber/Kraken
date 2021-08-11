/****** Object:  Table [dbo].[ag_databases]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'ag_databases')  
BEGIN  
CREATE TABLE [dbo].[ag_databases](
	[ag_name] [nvarchar](128) NULL,
	[replica_server_name] [nvarchar](128) NULL,
	[role_desc] [nvarchar](60) NULL,
	[is_local] [bit] NULL,
	[db_name] [nvarchar](128) NULL,
	[synchronization_state_desc] [nvarchar](60) NULL,
	[is_suspended] [bit] NULL,
	[is_database_joined] [bit] NULL,
	[is_failover_ready] [bit] NULL,
	[suspend_reason_desc] [nvarchar](60) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ag_databases] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END




/****** Object:  Table [dbo].[ag_listeners]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON
IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'ag_listeners')  
BEGIN  
CREATE TABLE [dbo].[ag_listeners](
	[ag_name] [nvarchar](128) NULL,
	[listener_name] [nvarchar](63) NULL,
	[port] [int] NULL,
	[is_conformant] [bit] NULL,
	[ip_address] [nvarchar](48) NULL,
	[ip_subnet_mask] [nvarchar](15) NULL,
	[is_dhcp] [bit] NULL,
	[network_subnet_ip] [nvarchar](48) NULL,
	[network_subnet_prefix_length] [int] NULL,
	[network_subnet_ipv4_mask] [nvarchar](45) NULL,
	[state] [tinyint] NULL,
	[state_desc] [nvarchar](60) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ag_listeners] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[availability_groups]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'availability_groups')  
BEGIN
CREATE TABLE [dbo].[availability_groups](
	[ag_name] [nvarchar](128) NULL,
	[failure_condition_level] [int] NULL,
	[health_check_timeout] [int] NULL,
	[automated_backup_preference_desc] [nvarchar](60) NULL,
	[version] [tinyint] NULL,
	[basic_features] [bit] NULL,
	[dtc_support] [bit] NULL,
	[db_failover] [bit] NULL,
	[is_distributed] [bit] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_availability_groups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[availability_replicas]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'availability_replicas')  
BEGIN
CREATE TABLE [dbo].[availability_replicas](
	[ag_name] [nvarchar](128) NULL,
	[replica_server_name] [nvarchar](256) NULL,
	[replica_owner] [nvarchar](128) NULL,
	[is_local] [bit] NULL,
	[role_desc] [nvarchar](60) NULL,
	[operational_state_desc] [nvarchar](60) NULL,
	[connected_state_desc] [nvarchar](60) NULL,
	[recovery_health_desc] [nvarchar](60) NULL,
	[synchronization_health_desc] [nvarchar](60) NULL,
	[endpoint_url] [nvarchar](128) NULL,
	[availability_mode_desc] [nvarchar](60) NULL,
	[failover_mode_desc] [nvarchar](60) NULL,
	[session_timeout] [int] NULL,
	[primary_role_allow_connections_desc] [nvarchar](60) NULL,
	[secondary_role_allow_connections_desc] [nvarchar](60) NULL,
	[create_date] [datetime2](7) NULL,
	[modify_date] [datetime2](7) NULL,
	[backup_priority] [int] NULL,
	[read_only_routing_url] [nvarchar](256) NULL,
	[seeding_mode_desc] [nvarchar](60) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_availability_replicas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[backups]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'backups')  
BEGIN
CREATE TABLE [dbo].[backups](
	[db_name] [nvarchar](128) NULL,
	[backup_start_date] [datetime2](7) NULL,
	[backup_finish_date] [datetime2](7) NULL,
	[type] [char](1) NULL,
	[device_type] [tinyint] NULL,
	[is_copy_only] [bit] NULL,
	[compressed_backup_size] [numeric](20, 0) NULL,
	[user_name] [nvarchar](128) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_backups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[database_files]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'database_files')  
BEGIN
CREATE TABLE [dbo].[database_files](
	[db_name] [nvarchar](128) NULL,
	[file_name] [nvarchar](128) NULL,
	[type_desc] [nvarchar](60) NULL,
	[size_mb] [decimal](28, 2) NULL,
	[used_mb] [decimal](28, 2) NULL,
	[physical_name] [nvarchar](260) NULL,
	[file_group] [nvarchar](128) NULL,
	[state_desc] [nvarchar](60) NULL,
	[growth] [int] NULL,
	[max_size] [int] NULL,
	[is_media_read_only] [bit] NULL,
	[is_read_only] [bit] NULL,
	[is_sparse] [bit] NULL,
	[is_percent_growth] [bit] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_database_files] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END



/****** Object:  Table [dbo].[database_size]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'database_size')  
BEGIN
CREATE TABLE [dbo].[database_size](
	[db_name] [nvarchar](128) NULL,
	[Size_MB] [decimal](28, 2) NULL,
	[Used_MB] [decimal](28, 2) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_database_size] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END



/****** Object:  Table [dbo].[databases]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'databases')  
BEGIN
CREATE TABLE [dbo].[databases](
	[database_id] [int] NULL,
	[db_name] [nvarchar](128) NULL,
	[source_database_id] [int] NULL,
	[source_database_name] [nvarchar](128) NULL,
	[owner_sid] [varbinary](85) NULL,
	[owner_name] [nvarchar](128) NULL,
	[create_date] [datetime2](7) NULL,
	[compatibility_level] [tinyint] NULL,
	[collation_name] [nvarchar](128) NULL,
	[user_access_desc] [nvarchar](60) NULL,
	[is_read_only] [bit] NULL,
	[is_auto_close_on] [bit] NULL,
	[is_auto_shrink_on] [bit] NULL,
	[state_desc] [nvarchar](60) NULL,
	[is_in_standby] [bit] NULL,
	[snapshot_isolation_state_desc] [nvarchar](60) NULL,
	[is_read_committed_snapshot_on] [bit] NULL,
	[recovery_model_desc] [nvarchar](60) NULL,
	[page_verify_option_desc] [nvarchar](60) NULL,
	[is_auto_create_stats_on] [bit] NULL,
	[is_auto_create_stats_incremental_on] [bit] NULL,
	[is_auto_update_stats_on] [bit] NULL,
	[is_auto_update_stats_async_on] [bit] NULL,
	[is_ansi_nulls_on] [bit] NULL,
	[is_ansi_padding_on] [bit] NULL,
	[is_ansi_warnings_on] [bit] NULL,
	[is_arithabort_on] [bit] NULL,
	[is_concat_null_yields_null_on] [bit] NULL,
	[is_numeric_roundabort_on] [bit] NULL,
	[is_quoted_identifier_on] [bit] NULL,
	[is_recursive_triggers_on] [bit] NULL,
	[is_cursor_close_on_commit_on] [bit] NULL,
	[is_local_cursor_default] [bit] NULL,
	[is_fulltext_enabled] [bit] NULL,
	[is_trustworthy_on] [bit] NULL,
	[is_db_chaining_on] [bit] NULL,
	[is_parameterization_forced] [bit] NULL,
	[is_master_key_encrypted_by_server] [bit] NULL,
	[is_query_store_on] [bit] NULL,
	[is_published] [bit] NULL,
	[is_subscribed] [bit] NULL,
	[is_merge_published] [bit] NULL,
	[is_distributor] [bit] NULL,
	[is_sync_with_backup] [bit] NULL,
	[is_broker_enabled] [bit] NULL,
	[log_reuse_wait_desc] [nvarchar](60) NULL,
	[is_date_correlation_on] [bit] NULL,
	[is_cdc_enabled] [bit] NULL,
	[is_encrypted] [bit] NULL,
	[is_honor_broker_priority_on] [bit] NULL,
	[containment_desc] [nvarchar](60) NULL,
	[target_recovery_time_in_seconds] [int] NULL,
	[delayed_durability_desc] [nvarchar](60) NULL,
	[is_memory_optimized_elevate_to_snapshot_on] [bit] NULL,
	[is_federation_member] [bit] NULL,
	[is_remote_data_archive_enabled] [bit] NULL,
	[is_mixed_page_allocation_on] [bit] NULL,
	[is_temporal_history_retention_enabled] [bit] NULL,
	[catalog_collation_type_desc] [nvarchar](60) NULL,
	[physical_database_name] [nvarchar](128) NULL,
	[is_result_set_caching_on] [bit] NULL,
	[is_memory_optimized_enabled] [bit] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_databases] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END



/****** Object:  Table [dbo].[hadr_cluster_members]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'hadr_cluster_members')
BEGIN
CREATE TABLE [dbo].[hadr_cluster_members](
	[member_name] [nvarchar](128) NULL,
	[member_type] [tinyint] NULL,
	[member_type_desc] [nvarchar](50) NULL,
	[member_state] [tinyint] NULL,
	[member_state_desc] [nvarchar](60) NULL,
	[number_of_quorum_votes] [tinyint] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_hadr_cluster_members] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END



/****** Object:  Table [dbo].[hadr_cluster_networks]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'hadr_cluster_networks')
BEGIN
CREATE TABLE [dbo].[hadr_cluster_networks](
	[member_name] [nvarchar](128) NULL,
	[network_subnet_ip] [nvarchar](48) NULL,
	[network_subnet_ipv4_mask] [nvarchar](45) NULL,
	[network_subnet_prefix_length] [int] NULL,
	[is_public] [bit] NULL,
	[is_ipv4] [bit] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_hadr_cluster_networks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[hadr_clusters]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'hadr_clusters')
BEGIN
CREATE TABLE [dbo].[hadr_clusters](
	[cluster_name] [nvarchar](128) NULL,
	[quorum_type] [tinyint] NULL,
	[quorum_type_desc] [nvarchar](50) NULL,
	[quorum_state] [tinyint] NULL,
	[quorum_state_desc] [nvarchar](50) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_hadr_clusters] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END



/****** Object:  Table [dbo].[job_logs]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'job_logs')
BEGIN
CREATE TABLE [dbo].[job_logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[run_date] [datetime2](7) NULL,
	[run_count] [int] NULL,
	[instance_name] [nvarchar](128) NULL,
	[job_id] [int] NULL,
	[step_name] [nvarchar](32) NULL,
	[success] [bit] NOT NULL,
	[exception] [nvarchar](2048) NULL,
 CONSTRAINT [PK_job_logs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[jobs]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'jobs')
BEGIN
CREATE TABLE [dbo].[jobs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[job_name] [varchar](128) NOT NULL,
	[enabled] [bit] NOT NULL,
	[run_date] [datetime2](7) NULL,
	[run_count] [int] NULL,
 CONSTRAINT [PK_jobs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[os_info]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'os_info')
BEGIN
CREATE TABLE [dbo].[os_info](
	[cpu_count] [int] NULL,
	[hyperthread_ratio] [int] NULL,
	[physical_memory_kb] [bigint] NULL,
	[sqlserver_start_time] [datetime2](7) NULL,
	[affinity_type_desc] [nvarchar](60) NULL,
	[virtual_machine_type_desc] [nvarchar](60) NULL,
	[softnuma_configuration_desc] [nvarchar](60) NULL,
	[sql_memory_model_desc] [nvarchar](120) NULL,
	[socket_count] [int] NULL,
	[cores_per_socket] [int] NULL,
	[numa_node_count] [int] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_os_info] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[registry]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'registry')
BEGIN
CREATE TABLE [dbo].[registry](
	[setting_name] [nvarchar](128) NULL,
	[registry_key] [nvarchar](256) NULL,
	[value_name] [nvarchar](128) NULL,
	[value_data] [nvarchar](128) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_registry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[server_properties]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'server_properties')
BEGIN
CREATE TABLE [dbo].[server_properties](
	[edition] [nvarchar](128) NULL,
	[product_version] [nvarchar](128) NULL,
	[product_level] [nvarchar](128) NULL,
	[collation] [nvarchar](128) NULL,
	[product_update_level] [nvarchar](128) NULL,
	[product_update_reference] [nvarchar](128) NULL,
	[resource_last_update_datetime] [datetime2](7) NULL,
	[hadr_manager_status] [int] NULL,
	[is_advanced_analytics_installed] [int] NULL,
	[is_hadr_enabled] [int] NULL,
	[is_clustered] [int] NULL,
	[is_fulltext_installed] [int] NULL,
	[is_single_user] [int] NULL,
	[is_xtp_supported] [int] NULL,
	[is_polybase_installed] [int] NULL,
	[is_integrated_security_only] [int] NULL,
	[is_big_data_cluster] [int] NULL,
	[filestream_effective_level] [int] NULL,
	[sql_install_date] [datetime2](7) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_server_properties] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[server_role_membership]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'server_role_membership')
BEGIN
CREATE TABLE [dbo].[server_role_membership](
	[login_name] [nvarchar](128) NULL,
	[type] [nvarchar](60) NULL,
	[server_role] [nvarchar](128) NULL,
	[is_disabled] [bit] NULL,
	[default_database_name] [nvarchar](128) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_server_role_membership] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[sql_instances]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'sql_instances')
BEGIN
CREATE TABLE [dbo].[sql_instances](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[instance_name] [nvarchar](70) NOT NULL,
	[environment] [nvarchar](35) NOT NULL,
	[active] [tinyint] NOT NULL,
 CONSTRAINT [PK_sql_instances] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[sql_logins]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'sql_logins')
BEGIN
CREATE TABLE [dbo].[sql_logins](
	[login_name] [nvarchar](128) NULL,
	[create_date] [datetime2](7) NULL,
	[modify_date] [datetime2](7) NULL,
	[sid] [varbinary](85) NULL,
	[bad_password_count] [int] NULL,
	[bad_password_time] [datetime2](7) NULL,
	[days_until_expiration] [int] NULL,
	[default_database] [nvarchar](128) NULL,
	[default_language] [nvarchar](128) NULL,
	[history_length] [int] NULL,
	[is_expired] [bit] NULL,
	[is_locked] [bit] NULL,
	[is_must_change] [bit] NULL,
	[lockout_time] [datetime2](7) NULL,
	[password_last_set_time] [datetime2](7) NULL,
	[is_policy_checked] [bit] NULL,
	[is_expiration_checked] [bit] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_sql_logins] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[sys_configurations]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'sys_configurations')
BEGIN
CREATE TABLE [dbo].[sys_configurations](
	[configuration_id] [int] NULL,
	[configuration_name] [nvarchar](35) NULL,
	[value] [int] NULL,
	[minimum] [int] NULL,
	[maximum] [int] NULL,
	[value_in_use] [int] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_sys_configurations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[tlog_space]    Script Date: 8/27/2020 9:32:22 AM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'tlog_space')
BEGIN
CREATE TABLE [dbo].[tlog_space](
	[database_name] [nvarchar](128) NULL,
	[log_size_mb] [real] NULL,
	[log_space_used_%] [real] NULL,
	[status] [int] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_tlog_space] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[volumes]    Script Date: 7/29/2020 1:17:05 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'volumes')
BEGIN
CREATE TABLE [dbo].[volumes](
	[volume_mount_point] [nvarchar](512) NULL,
	[logical_volume_name] [nvarchar](512) NULL,
	[file_system_type] [nvarchar](512) NULL,
	[size_mb] [bigint] NULL,
	[free_space_mb] [bigint] NULL,
	[supports_compression] [bit] NULL,
	[supports_alternate_streams] [bit] NULL,
	[supports_sparse_files] [bit] NULL,
	[is_read_only] [bit] NULL,
	[is_compressed] [bit] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_volumes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[server_principals]    Script Date: 2/23/2021 4:12:57 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'server_principals')
BEGIN
CREATE TABLE [dbo].[server_principals](
	[login_name] [nvarchar](128) NULL,
	[principal_id] [int] NULL,
	[sid] [varbinary](85) NULL,
	[type] [char](1) NULL,
	[type_desc] [nvarchar](60) NULL,
	[is_disabled] [int] NULL,
	[create_date] [datetime2](7) NULL,
	[modify_date] [datetime2](7) NULL,
	[default_database_name] [nvarchar](128) NULL,
	[default_language_name] [nvarchar](128) NULL,
	[credential_id] [int] NULL,
	[owning_principal_id] [int] NULL,
	[is_fixed_role] [bit] NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_server_principals] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[dbcc_checkdb]    Script Date: 7/27/2021 3:56:52 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'dbcc_checkdb')
BEGIN
CREATE TABLE [dbo].[dbcc_checkdb](
	[db_name] [nvarchar](128) NULL,
	[last_checkdb] [datetime2](7) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dbcc_checkdb] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Table [dbo].[os_version]    Script Date: 8/11/2021 4:10:19 PM ******/
SET ANSI_NULLS ON

SET QUOTED_IDENTIFIER ON

IF NOT EXISTS(SELECT 1 FROM sys.tables WHERE [name] = 'os_version')
BEGIN
CREATE TABLE [dbo].[os_version](
	[host_platform] [nvarchar](256) NULL,
	[host_distribution] [nvarchar](256) NULL,
	[host_release] [nvarchar](256) NULL,
	[os_build] [nvarchar](256) NULL,
	[job_id] [int] NOT NULL,
	[run_date] [datetime2](7) NOT NULL,
	[run_count] [int] NOT NULL,
	[instance_id] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_os_version] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

/****** Object:  Index [IX_ag_databases_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_ag_databases_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_ag_databases_instance_id] ON [dbo].[ag_databases]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_ag_databases_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_ag_databases_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_ag_databases_run_count] ON [dbo].[ag_databases]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_ag_listeners_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_ag_listeners_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_ag_listeners_instance_id] ON [dbo].[ag_listeners]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_ag_listeners_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_ag_listeners_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_ag_listeners_run_count] ON [dbo].[ag_listeners]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_availability_groups_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_availability_groups_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_availability_groups_instance_id] ON [dbo].[availability_groups]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_availability_groups_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_availability_groups_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_availability_groups_run_count] ON [dbo].[availability_groups]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_availability_replicas_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_availability_replicas_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_availability_replicas_instance_id] ON [dbo].[availability_replicas]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_availability_replicas_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_availability_replicas_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_availability_replicas_run_count] ON [dbo].[availability_replicas]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_backups_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_backups_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_backups_run_count] ON [dbo].[backups]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_database_files_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_database_files_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_database_files_instance_id] ON [dbo].[database_files]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_database_files_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_database_files_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_database_files_run_count] ON [dbo].[database_files]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_database_size_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_database_size_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_database_size_instance_id] ON [dbo].[database_size]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_database_size_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_database_size_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_database_size_run_count] ON [dbo].[database_size]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_databases_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_databases_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_databases_instance_id] ON [dbo].[databases]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_databases_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_databases_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_databases_run_count] ON [dbo].[databases]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_hadr_cluster_members_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_hadr_cluster_members_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_hadr_cluster_members_run_count] ON [dbo].[hadr_cluster_members]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_hadr_cluster_networks_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_hadr_cluster_networks_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_hadr_cluster_networks_instance_id] ON [dbo].[hadr_cluster_networks]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_hadr_cluster_networks_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_hadr_cluster_networks_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_hadr_cluster_networks_run_count] ON [dbo].[hadr_cluster_networks]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_hadr_clusters_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_hadr_clusters_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_hadr_clusters_instance_id] ON [dbo].[hadr_clusters]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_hadr_clusters_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_hadr_clusters_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_hadr_clusters_run_count] ON [dbo].[hadr_clusters]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_job_logs_job_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_job_logs_job_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_job_logs_job_id] ON [dbo].[job_logs]
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_job_logs_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_job_logs_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_job_logs_run_count] ON [dbo].[job_logs]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_os_info_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_os_info_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_os_info_instance_id] ON [dbo].[os_info]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_os_info_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_os_info_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_os_info_run_count] ON [dbo].[os_info]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_registry_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_registry_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_registry_instance_id] ON [dbo].[registry]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_registry_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_registry_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_registry_run_count] ON [dbo].[registry]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_server_properties_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_server_properties_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_server_properties_instance_id] ON [dbo].[server_properties]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_server_properties_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_server_properties_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_server_properties_run_count] ON [dbo].[server_properties]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_server_role_membership_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_server_role_membership_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_server_role_membership_instance_id] ON [dbo].[server_role_membership]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_server_role_membership_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_server_role_membership_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_server_role_membership_run_count] ON [dbo].[server_role_membership]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_sql_logins_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_sql_logins_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_sql_logins_instance_id] ON [dbo].[sql_logins]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_sql_logins_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_sql_logins_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_sql_logins_run_count] ON [dbo].[sql_logins]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_sys_configurations_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_sys_configurations_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_sys_configurations_instance_id] ON [dbo].[sys_configurations]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_sys_configurations_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_sys_configurations_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_sys_configurations_run_count] ON [dbo].[sys_configurations]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_volumes_instance_id]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_volumes_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_volumes_instance_id] ON [dbo].[volumes]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_volumes_run_count]    Script Date: 7/29/2020 1:17:05 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_volumes_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_volumes_run_count] ON [dbo].[volumes]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_volumes_instance_id]    Script Date: 8/27/2020 9:42:15 AM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_tlog_space_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_tlog_space_instance_id] ON [dbo].[tlog_space]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
/****** Object:  Index [IX_volumes_run_count]    Script Date: 8/27/2020 9:42:19 AM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_tlog_space_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_tlog_space_run_count] ON [dbo].[tlog_space]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

/****** Object:  Index [IX_tlog_space_instance_id]    Script Date: 2/23/2021 4:07:50 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_server_principals_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_server_principals_instance_id] ON [dbo].[server_principals]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

/****** Object:  Index [IX_tlog_space_instance_id]    Script Date: 2/23/2021 4:07:50 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_server_principals_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_server_principals_run_count] ON [dbo].[server_principals]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

/****** Object:  Index [IX_dbcc_checkdb_instance_id]    Script Date: 7/27/2021 3:59:44 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_dbcc_checkdb_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_dbcc_checkdb_instance_id] ON [dbo].[dbcc_checkdb]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

/****** Object:  Index [IX_dbcc_checkdb_run_count]    Script Date: 7/27/2021 3:59:51 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_dbcc_checkdb_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_dbcc_checkdb_run_count] ON [dbo].[dbcc_checkdb]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

/****** Object:  Index [IX_os_version_instance_id]    Script Date: 8/11/2021 4:11:58 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_os_version_instance_id')
BEGIN
CREATE NONCLUSTERED INDEX [IX_os_version_instance_id] ON [dbo].[os_version]
(
	[instance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

/****** Object:  Index [IX_os_version_run_count]    Script Date: 8/11/2021 4:13:07 PM ******/
IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE [name] = 'IX_os_version_run_count')
BEGIN
CREATE NONCLUSTERED INDEX [IX_os_version_run_count] ON [dbo].[os_version]
(
	[run_count] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_tlog_space')
BEGIN
ALTER TABLE [dbo].[tlog_space]  WITH NOCHECK ADD  CONSTRAINT [FK_sql_instances_tlog_space] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([id])

ALTER TABLE [dbo].[tlog_space] CHECK CONSTRAINT [FK_sql_instances_tlog_space]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_ag_databases')
BEGIN
ALTER TABLE [dbo].[ag_databases]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_ag_databases] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[ag_databases] CHECK CONSTRAINT [FK_sql_instances_ag_databases]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_ag_listeners')
BEGIN
ALTER TABLE [dbo].[ag_listeners]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_ag_listeners] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[ag_listeners] CHECK CONSTRAINT [FK_sql_instances_ag_listeners]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_availability_groups')
BEGIN
ALTER TABLE [dbo].[availability_groups]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_availability_groups] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[availability_groups] CHECK CONSTRAINT [FK_sql_instances_availability_groups]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_availability_replicas')
BEGIN
ALTER TABLE [dbo].[availability_replicas]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_availability_replicas] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[availability_replicas] CHECK CONSTRAINT [FK_sql_instances_availability_replicas]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_backups')
BEGIN
ALTER TABLE [dbo].[backups]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_backups] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[backups] CHECK CONSTRAINT [FK_sql_instances_backups]
END


IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_database_files')
BEGIN
ALTER TABLE [dbo].[database_files]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_database_files] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[database_files] CHECK CONSTRAINT [FK_sql_instances_database_files]
END


IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_database_size')
BEGIN
ALTER TABLE [dbo].[database_size]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_database_size] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[database_size] CHECK CONSTRAINT [FK_sql_instances_database_size]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_databases')
BEGIN
ALTER TABLE [dbo].[databases]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_databases] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[databases] CHECK CONSTRAINT [FK_sql_instances_databases]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_hadr_cluster_members')
BEGIN
ALTER TABLE [dbo].[hadr_cluster_members]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_hadr_cluster_members] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[hadr_cluster_members] CHECK CONSTRAINT [FK_sql_instances_hadr_cluster_members]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_hadr_cluster_networks')
BEGIN
ALTER TABLE [dbo].[hadr_cluster_networks]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_hadr_cluster_networks] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[hadr_cluster_networks] CHECK CONSTRAINT [FK_sql_instances_hadr_cluster_networks]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_hadr_clusters')
BEGIN
ALTER TABLE [dbo].[hadr_clusters]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_hadr_clusters] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[hadr_clusters] CHECK CONSTRAINT [FK_sql_instances_hadr_clusters]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_jobs_job_logs')
BEGIN
ALTER TABLE [dbo].[job_logs]  WITH CHECK ADD  CONSTRAINT [FK_jobs_job_logs] FOREIGN KEY([job_id])
REFERENCES [dbo].[jobs] ([id])

ALTER TABLE [dbo].[job_logs] CHECK CONSTRAINT [FK_jobs_job_logs]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_os_info')
BEGIN
ALTER TABLE [dbo].[os_info]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_os_info] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[os_info] CHECK CONSTRAINT [FK_sql_instances_os_info]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_registry')
BEGIN
ALTER TABLE [dbo].[registry]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_registry] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[registry] CHECK CONSTRAINT [FK_sql_instances_registry]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_server_properties')
BEGIN
ALTER TABLE [dbo].[server_properties]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_server_properties] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[server_properties] CHECK CONSTRAINT [FK_sql_instances_server_properties]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_server_role_membership')
BEGIN
ALTER TABLE [dbo].[server_role_membership]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_server_role_membership] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[server_role_membership] CHECK CONSTRAINT [FK_sql_instances_server_role_membership]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_sql_logins')
BEGIN
ALTER TABLE [dbo].[sql_logins]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_sql_logins] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[sql_logins] CHECK CONSTRAINT [FK_sql_instances_sql_logins]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_sys_configurations')
BEGIN
ALTER TABLE [dbo].[sys_configurations]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_sys_configurations] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[sys_configurations] CHECK CONSTRAINT [FK_sql_instances_sys_configurations]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_volumes')
BEGIN
ALTER TABLE [dbo].[volumes]  WITH CHECK ADD  CONSTRAINT [FK_sql_instances_volumes] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([Id])

ALTER TABLE [dbo].[volumes] CHECK CONSTRAINT [FK_sql_instances_volumes]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_server_principals')
BEGIN
ALTER TABLE [dbo].[server_principals]  WITH NOCHECK ADD  CONSTRAINT [FK_sql_instances_server_principals] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([id])

ALTER TABLE [dbo].[server_principals] CHECK CONSTRAINT [FK_sql_instances_server_principals]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_dbcc_checkdb')
BEGIN
ALTER TABLE [dbo].[dbcc_checkdb]  WITH NOCHECK ADD  CONSTRAINT [FK_sql_instances_dbcc_checkdb] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([id])

ALTER TABLE [dbo].[dbcc_checkdb] CHECK CONSTRAINT [FK_sql_instances_dbcc_checkdb]
END

IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE [name] = 'FK_sql_instances_os_version')
BEGIN
ALTER TABLE [dbo].[os_version]  WITH NOCHECK ADD  CONSTRAINT [FK_sql_instances_os_version] FOREIGN KEY([instance_id])
REFERENCES [dbo].[sql_instances] ([id])


ALTER TABLE [dbo].[os_version] CHECK CONSTRAINT [FK_sql_instances_os_version]
END

IF NOT EXISTS ( SELECT 1 FROM dbo.jobs WHERE job_name = 'Kraken-Main')
BEGIN
INSERT INTO dbo.jobs
VALUES ('Kraken-Main',1,null,0)
END