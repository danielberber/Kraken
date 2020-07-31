function Update-RunCount {
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
        $UpdateRunCount = "$ModulePath\Private\SQLScripts\Update-RunCount.sql"

        $credSplat = @{}
        if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
            $credSplat['Credential'] = $Credential
        }
    }

    process {
        $sqlParameters = @{Name = $JobName }
        Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database @credSplat -InputFile $UpdateRunCount -sqlparameters $sqlParameters 
        #Return $RunCount
    }
}