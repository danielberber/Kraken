<#
.SYNOPSIS
  Creates the database schema objects

.DESCRIPTION
  Database must be created manually by the user. This powershell then creates all the required tables, indexes and foreign keys in the database.
  It takes the SQL Server Instance and database name from Kraken.config.json

.PARAMETER Credential
    Optional, if no Credential is provided it will use Windows Authentication and your current user to create the database objects.
    If a credential is specified it will use SQL Authentication

.INPUTS
  Credential [PSCredential]

.OUTPUTS
  None 
  
.EXAMPLE
  Run with Windows Authentication
  
  Set-DBSchema

.EXAMPLE
  Run with SQL Authentication
  
  $Credential = Get-Credential
  Set-DBSchema -Credential $Credential

.LINK
            https://github.com/dokier/Kraken
#>
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