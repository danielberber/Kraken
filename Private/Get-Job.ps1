function Get-Job {
    [OutputType('void')]
    [CmdletBinding()]
    param
    (

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$JobName
    )

    begin {
        $ErrorActionPreference = 'Stop'
        $connSettings = Get-ConnectionString
        $dbCredential = Get-DBCredential
        $ModulePath = (Split-Path $PSScriptRoot)
        $GetJob = "$ModulePath\Private\SQLScripts\Get-Job.sql"
    }

    process {
         $sqlParameters = @{Name=$JobName}

         $Job = Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database -Credential $dbCredential -InputFile $GetJob -sqlparameters $sqlParameters 
         
         Return $Job

    }
}