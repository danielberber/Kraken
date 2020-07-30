Update dbo.jobs
set run_count = run_count+1,
    run_date = getdate()
where job_name like @Name