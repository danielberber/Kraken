function Get-ConnectionString {
    [OutputType('pscustomobject')]
    [CmdletBinding()]
    param()
    begin {
        
        $ErrorActionPreference = 'Stop'
        $json = Get-Content -Path $env:ProgramData\Kraken\Kraken.config.json -Raw | ConvertFrom-Json
    }

    process {

        $connDetails = @{
            Server   = $json.dbsettings.server
            Database = $json.dbsettings.database
        }

        Return $connDetails
    }
}