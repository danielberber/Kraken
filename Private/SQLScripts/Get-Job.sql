SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NUMERIC_ROUNDABORT OFF
SET ARITHABORT ON
select id, job_name, enabled, run_date, run_count from dbo.jobs where job_name like @Name