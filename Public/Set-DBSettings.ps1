function Set-DBSettings{
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