function Get-ConnectionString{
    [OutputType('pscustomobject')]
    [CmdletBinding()]
    param()
    begin {
        $ErrorActionPreference = 'Stop'
        $script:PSConfigPath = (Get-Item $PSScriptRoot).Parent.FullName
        $json = Get-Content -Path $script:PSConfigPath\Kraken.config.json -Raw | ConvertFrom-Json
    }

    process {

        $connDetails = @{
        Server = $json.dbsettings.server
        Database = $json.dbsettings.database
        }

        Return $connDetails
    }
}