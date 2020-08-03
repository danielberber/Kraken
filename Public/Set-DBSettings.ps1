<#
.SYNOPSIS
  Saves DB Settings

.DESCRIPTION
  Saves the repository SQL Server instance and database values into Kraken.config.json file

.PARAMETER dbserver
    Specifies the SQL Server instance

.PARAMETER dbname
    Specifies the SQL Server database

.INPUTS
  None. You cannot pipe objects to Set-DBSettings

.OUTPUTS
  None 
  
.EXAMPLE
  Install a DEV SQL Server 2016 with default Instance value of "INSTANCE1" including all post steps
  
  Set-DBSettings -dbserver "servername.fqdn.com\instancename" -dbname "Kraken"

.LINK
            https://github.com/dokier/Kraken
#>
function Set-DBSettings {
    [OutputType('void')]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $dbserver,
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory)]
        [string] $dbname
    )

    begin {
        $ErrorActionPreference = 'Stop'
        $script:PSConfigPath = (Get-Item $PSScriptRoot).Parent.FullName
        $json = Get-Content -Path $script:PSConfigPath\Kraken.config.json -Raw | ConvertFrom-Json
    }

    process {        
        $json.dbsettings.server = $dbserver
        $json.dbsettings.database = $dbname
        $json | ConvertTo-Json -depth 100 | Set-Content $script:PSConfigPath\Kraken.config.json
    }
}