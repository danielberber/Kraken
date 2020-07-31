function Get-Job {
    [OutputType('void')]
    [CmdletBinding()]
    param
    (

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$JobName,

        [Parameter(ValueFromPipeline)]
        [System.Management.Automation.Credential()]
        [PSCredential] $Credential
    )

    begin {
        $ErrorActionPreference = 'Stop'
        $connSettings = Get-ConnectionString
        $ModulePath = (Split-Path $PSScriptRoot)
        $GetJob = "$ModulePath\Private\SQLScripts\Get-Job.sql"

        $credSplat = @{}
        if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
            $credSplat['Credential'] = $Credential
        }
    }

    process {
        $sqlParameters = @{Name = $JobName }
        $Job = Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database @credSplat -InputFile $GetJob -sqlparameters $sqlParameters 
        Return $Job

    }
}