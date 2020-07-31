function Invoke-TheKraken {
    [OutputType('void')]
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param
    (
        [Parameter(ParameterSetName = 'ByEnv')]
        [ValidateNotNullOrEmpty()]
        #[ValidateSet("DEV", "TST", "STG", "PRD")]
        [string[]]$Environment,

        [Parameter(ParameterSetName = 'ByName')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Name,

        [Parameter(ParameterSetName = 'All')]
        [switch]$All,

        [Parameter(ValueFromPipeline)]
        [System.Management.Automation.Credential()]
        [PSCredential] $Credential
    )

    begin {
        #$ErrorActionPreference = 'Stop'
        $defaultDB = "master"
        $connSettings = Get-ConnectionString
        $ModulePath = (Split-Path $PSScriptRoot)
        $script:PSConfigPath = (Get-Item $PSScriptRoot).Parent.FullName
        $json = Get-Content -Path $script:PSConfigPath\Kraken.config.json -Raw | ConvertFrom-Json
        $Commands = $json.Commands
        $cmdNames = $Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

        $credSplat = @{}
        if ($Credential -ne [System.Management.Automation.PSCredential]::Empty) {
            $credSplat['Credential'] = $Credential
        }
    }

    process {
        Write-Verbose "ParameterSetName $($PSCmdlet.ParameterSetName)"

        switch ($PSCmdlet.ParameterSetName) {
            'ByEnv' {
                $SQLInstanceList = Get-SqlInstance -Environment $Environment @credSplat
            }
            'ByName' {
                $SQLInstanceList = Get-SqlInstance -Name $Name @credSplat
            }
            'All' {
                $SQLInstanceList = Get-SqlInstance -All @credSplat
            }
        }

        $Job = Get-Job -JobName  "Kraken-Main" @credSplat
        [void]$(Update-RunCount -JobName  "Kraken-Main" @credSplat)
        $RunCount = $Job.run_count + 1

        foreach ($SQLInstance in $SQLInstanceList) {
            $RunDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
            Write-Output $SQLInstance.instance_name
            try {
                Invoke-Sqlcmd2  -ServerInstance $SQLInstance.instance_name -Query "PRINT 'hello world'" @credSplat -ErrorAction Stop
                $ConnStatus = $True
                
                Write-JobMessage -RunDate $RunDate -RunCount $RunCount -SQLInstance $SQLInstance.instance_name -JobId $Job.Id -StepName "Test-Connectivity" -Success $True @credSplat
            }
            catch {
                $ConnStatus = $False
                Write-JobMessage -RunDate $RunDate -RunCount $RunCount -SQLInstance $SQLInstance.instance_name -JobId $Job.Id -StepName "Test-Connectivity" -Success $False -ExceptionMessage $_.Exception.Message @credSplat
            } 
            if ($ConnStatus -eq $True) { 
                foreach ($cmdName in $cmdNames) {
                    $QueryPath = "$ModulePath\Private\SQLScripts\$($Commands.$cmdName.query_name)"
                    $RunDate = Get-Date
                    Try {
                        $DataSet = Invoke-Sqlcmd2 -ServerInstance $SQLInstance.instance_name -Database $defaultDB -InputFile $QueryPath -as psobject @credSplat #-ErrorAction Continue
                        $DataSet | Add-Member -MemberType NoteProperty -Name "job_id" -Value $Job.Id
                        $DataSet | Add-Member -MemberType NoteProperty -Name "run_date" -Value $RunDate
                        $DataSet | Add-Member -MemberType NoteProperty -Name "run_count" -Value $RunCount
                        $DataSet | Add-Member -MemberType NoteProperty -Name "instance_id" -Value $SQLInstance.id
                        $DataSet | Add-Member -MemberType NoteProperty  -Name "id" -Value ""
                        $DataSet | Write-SqlTableData -ServerInstance $connSettings.server -DatabaseName $connSettings.database -SchemaName dbo -TableName $Commands.$cmdName.dest_table @credSplat -Force -ErrorAction Stop
                        Write-JobMessage -RunDate $RunDate -RunCount $RunCount -SQLInstance $SQLInstance.instance_name -JobId $Job.Id -StepName $cmdName -Success $True @credSplat
                    }
                    catch {
                        Write-JobMessage -RunDate $RunDate -RunCount $RunCount -SQLInstance $SQLInstance.instance_name -JobId $Job.Id -StepName $cmdName -Success $False -ExceptionMessage $_.Exception.Message @credSplat
                    }                
                }
            } 
        }
    } # Process
}