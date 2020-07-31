function Set-DBSchema {
    [OutputType('void')]
    [CmdletBinding()]
    param
    (
        [Parameter(ValueFromPipeline)]
        [System.Management.Automation.Credential()]
        [PSCredential] $Credential
    )

    begin {
        $ErrorActionPreference = 'Stop'
        $connSettings = Get-ConnectionString
        $ModulePath = (Split-Path $PSScriptRoot)
        $DBSchema = "$ModulePath\Private\SQLScripts\Set-DBSchema.sql"

        $credSplat = @{}
        if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
            $credSplat['Credential'] = $Credential
        }
    }

    process {
        try {
            Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database @credSplat -InputFile $DBSchema
            Write-Output "Database schema created succesfully"
        }
        catch {
            Write-Output "Error creating the database schema: $($_.Exception.Message)"
        }
    }
}