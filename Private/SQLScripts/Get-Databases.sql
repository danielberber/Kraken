SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
;WITH potential_columns AS
(
  SELECT 
    -- in case we do encounter the old columns:
   is_auto_create_stats_incremental_on = CONVERT (bit, NULL),
   is_query_store_on = CONVERT (bit, NULL),
   containment_desc = CONVERT (nvarchar(60), NULL),
   target_recovery_time_in_seconds = CONVERT (int, NULL),
   delayed_durability_desc = CONVERT(nvarchar(60), null),
   is_memory_optimized_elevate_to_snapshot_on = CONVERT (bit, NULL),
   is_federation_member = CONVERT (bit, NULL),
   is_remote_data_archive_enabled = CONVERT (bit, NULL),
   is_mixed_page_allocation_on = CONVERT (bit, NULL),
   is_temporal_history_retention_enabled = CONVERT (bit, NULL),
   catalog_collation_type_desc = CONVERT(nvarchar(60), null),
   physical_database_name = CONVERT(nvarchar(128),null),
   is_result_set_caching_on = CONVERT (bit, NULL),
   is_memory_optimized_enabled = CONVERT (bit, NULL)
)
select m.* from potential_columns
CROSS APPLY 
(
select database_id, name, owner_sid, SUSER_SNAME(owner_sid) as database_owner, create_date, compatibility_level, collation_name, user_access_desc, is_read_only, is_auto_close_on, is_auto_shrink_on,
state_desc, is_in_standby, snapshot_isolation_state_desc, is_read_committed_snapshot_on, recovery_model_desc, page_verify_option_desc,
is_auto_create_stats_on, is_auto_create_stats_incremental_on, is_auto_update_stats_on, is_auto_update_stats_async_on, 
is_ansi_nulls_on, is_ansi_padding_on, is_ansi_warnings_on, is_arithabort_on, is_concat_null_yields_null_on, is_numeric_roundabort_on,
is_quoted_identifier_on, is_recursive_triggers_on, is_cursor_close_on_commit_on, is_local_cursor_default, is_fulltext_enabled, is_trustworthy_on,
is_db_chaining_on, is_parameterization_forced, is_master_key_encrypted_by_server, is_query_store_on, is_published, is_subscribed, is_merge_published,
is_distributor, is_sync_with_backup, is_broker_enabled, log_reuse_wait_desc,
is_date_correlation_on, is_cdc_enabled, is_encrypted, is_honor_broker_priority_on, containment_desc, target_recovery_time_in_seconds, delayed_durability_desc,
is_memory_optimized_elevate_to_snapshot_on, is_federation_member, is_remote_data_archive_enabled, is_mixed_page_allocation_on, is_temporal_history_retention_enabled,
catalog_collation_type_desc, physical_database_name, is_result_set_caching_on, is_memory_optimized_enabled
from sys.databases
) AS m;