function Set-DBSettings{
    [OutputType('void')]
    [CmdletBinding()]
    param
    (
    [Parameter(Mandatory, ValueFromPipeline)]
    [System.Management.Automation.Credential()]
    [PSCredential] $Credential,
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
        $Password = $Credential.Password | ConvertFrom-SecureString
        $User = $Credential.UserName
        
        $json.dbsettings.password = $Password
        $json.dbsettings.username = $User
        $json.dbsettings.server = $dbserver
        $json.dbsettings.database = $dbname
        $json | ConvertTo-Json -depth 100 | Set-Content $script:PSConfigPath\Kraken.config.json
    }
}