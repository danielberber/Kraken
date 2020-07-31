function Get-SQLInstance {
    [OutputType('void')]
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param
    (

        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'ById')]
        [ValidateNotNullOrEmpty()]
        [int[]]$Id,

        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'ByName')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name,

        [Parameter(Mandatory, ParameterSetName = 'ByEnv')]
        [ValidateNotNullOrEmpty()]
        #[ValidateSet("DEV", "TST", "STG", "PRD")]
        [string[]]$Environment,

        [Parameter(ParameterSetName = 'All')]
        [switch]$All,

        [Parameter(ValueFromPipeline)]
        [System.Management.Automation.Credential()]
        [PSCredential] $Credential
    )

    begin {
        $ErrorActionPreference = 'Stop'
        $connSettings = Get-ConnectionString
        $ModulePath = (Split-Path $PSScriptRoot)
        $GetSQLInstance = "$ModulePath\Private\SQLScripts\Get-SQLInstance.sql"

        
        $credSplat = @{}
        if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
            $credSplat['Credential'] = $Credential
        }
    }

    process {
        $SQLInstanceList = Invoke-Sqlcmd2 -ServerInstance $connSettings.server -Database $connSettings.database -InputFile $GetSQLInstance @credSplat
        switch ($PSCmdlet.ParameterSetName) {
            #$PSBoundParameters.Keys

            'ById' {
                $SQLInstanceList | Where-Object { $_.id -in $Id }
            }
            'ByName' {
                $SQLInstanceList | Where-Object { $_.instance_name -in $Name }
            }
            'ByEnv' {
                $SQLInstanceList | Where-Object { $_.environment -in $Environment }
            }
            'All' {
                $SQLInstanceList
            }
        } 
    }
}