function Write-JobMessage {
    [OutputType('void')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [DateTime]$RunDate,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [int]$RunCount,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$SQLInstance,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [int]$JobId,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$StepName,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [bool]$Success,

        [Parameter(ValueFromPipeline)]
        [string]$ExceptionMessage
    )

    begin {
        $ErrorActionPreference = 'Stop'
        $connSettings = Get-ConnectionString
        $dbCredential = Get-DBCredential
        $RunDate2 = $RunDate.ToString("yyyy-MM-dd HH:mm:ss.fff")

        $Query = " 
        INSERT INTO [dbo].[job_logs] 
                   ([run_date] 
                   ,[run_count] 
                   ,[instance_name]
                   ,[job_id]
                   ,[step_name]
                   ,[success]
                   ,[exception]) 
             VALUES 
                   ('$RunDate2' 
                   ,'$RunCount' 
                   ,'$SQLInstance'
                   ,'$JobId'
                   ,'$StepName'
                   ,'$Success'
                   ,'$ExceptionMessage') 
        " 
    }

    process {
      Invoke-sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database -Credential $dbCredential -Query $Query
    }
}