function Update-RunCount {
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
        $UpdateRunCount = "$ModulePath\Private\SQLScripts\Update-RunCount.sql"
    }

    process {
         $sqlParameters = @{Name=$JobName}

         Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database -Credential $dbCredential -InputFile $UpdateRunCount -sqlparameters $sqlParameters 
         
         #Return $RunCount

    }
}