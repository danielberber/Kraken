function Set-DBCredential{
    [OutputType('void')]
    [CmdletBinding()]
    param
    (
    [Parameter(Mandatory, ValueFromPipeline)]
    [System.Management.Automation.Credential()]
    [PSCredential] $Credential
    )

    begin {
        $ErrorActionPreference = 'Stop'
        $script:PSConfigPath = (Get-Item $PSScriptRoot).Parent.FullName
        $json = Get-Content -Path $script:PSConfigPath\Kraken.config.json -Raw | ConvertFrom-Json
    }

    process {
        #$Password = $Credential.GetNetworkCredential().Password
        $Password = $Credential.Password | ConvertFrom-SecureString
        $User = $Credential.UserName
        Write-Output $User
        $json.dbsettings.password = $Password
        $json.dbsettings.username = $User
        $json | ConvertTo-Json -depth 100 | Set-Content $script:PSConfigPath\Kraken.config.json
    }
}