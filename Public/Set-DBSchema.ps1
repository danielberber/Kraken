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
    }

    process {
        try {
            if ($Credential) {
                Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database -Credential $Credential -InputFile $DBSchema
                Write-Output "Database schema created succesfully"
            }
            else {
                Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database -InputFile $DBSchema
                Write-Output "Database schema created succesfully"
            }
        }
        catch {
            Write-Output "Error creating the database schema: $($_.Exception.Message)"
        }
    }
}