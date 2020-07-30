function Get-DBCredential{
    [OutputType('System.Management.Automation.PSCredential')]
    [CmdletBinding()]
    param
    (
    )
    begin {
        $ErrorActionPreference = 'Stop'
        $script:PSConfigPath = (Get-Item $PSScriptRoot).Parent.FullName
        $json = Get-Content -Path $script:PSConfigPath\Kraken.config.json -Raw | ConvertFrom-Json
    }

    process {

        #This can get the password in plain text
        #$Password = $Credential.GetNetworkCredential().Password
        $Password = $json.dbsettings.password | ConvertTo-SecureString
        #This can get the password in plain text as well
        #$Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password)) 
        $User = $json.dbsettings.username
        
        $Credential = New-Object System.Management.Automation.PsCredential($User, $Password)
        Return $Credential
    }
}