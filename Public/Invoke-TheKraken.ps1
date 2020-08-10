<#
.SYNOPSIS
  Executes the collector process

.DESCRIPTION
  Invoke-TheKraken is the main process which collects metadata information and stores it into the repository database

.PARAMETER Environment
    Must match values set on the column environment on the sql_instances table. It executes the process against target sql servers that meet the environment criteria

.PARAMETER Name
    Must match instance_name column values on the sql_instances table. It executes the process against specific target sql servers pass in this comma separated list. SQL Instance must exist in the sql_instances table

.PARAMETER All
    If this Switch is used, the process is executed against all Active SQL Server Instances listed on the sql_instances table

.PARAMETER Credential
    Credential [PSCredential] - If not specified it uses Trusted Authentication, else it will SQL Authentication

.PARAMETER Throttle
    Number of concurrent running runspace jobs which are allowed at a time.

.INPUTS
  Credential [PSCredential]

.OUTPUTS
  None 
  
.EXAMPLE
  Executes the process just against DEV Target Servers
  
  Invoke-TheKraken -Environment "DEV"

.EXAMPLE
  Executes the process just against All Target Servers
  
  Invoke-TheKraken -All
  
.LINK
            https://github.com/dokier/Kraken
#>
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
        [PSCredential] $Credential,

        [int] $Throttle = $env:NUMBER_OF_PROCESSORS
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
        $Private = @(Get-ChildItem -Path $PSScriptRoot\..\Private\*.ps1 -ErrorAction SilentlyContinue)

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

        #Removing old jobs in case the user aborted the process Ctrl C and re-executes on the same session
        Get-RSJob -Name "Kraken" | Remove-RSJob
        #SCRIPT BLOCK to go parallel
        $SQLInstanceList | Start-RSJob -Name { "Kraken" } -Throttle $Throttle -ScriptBlock {   
            
            #$_.instance_name
            $RunDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
            
            #Passing parent variables to scriptblock
            $LocalJob = $Using:Job
            $LocalInstance = $_.instance_name
            $LocalInstanceId = $_.id
            $LocalCommands = $Using:Commands
            $LocalcmdNames = $Using:cmdNames
            $LocaldefaultDB = $Using:defaultDB
            $LocalconnSettings = $Using:connSettings

            Write-Output $_.instance_name

            try {
                Invoke-Sqlcmd2  -ServerInstance $_.instance_name -Query "PRINT 'hello world'" @Using:credSplat -ErrorAction Stop
                $ConnStatus = $True
                
                Write-JobMessage -RunDate $RunDate -RunCount $Using:RunCount -SQLInstance $LocalInstance -JobId $LocalJob.id -StepName "Test-Connectivity" -Success $True @Using:credSplat
            }
            catch {
                $ConnStatus = $False
                Write-JobMessage -RunDate $RunDate -RunCount $Using:RunCount -SQLInstance $LocalInstance -JobId $LocalJob.id -StepName "Test-Connectivity" -Success $False -ExceptionMessage $_.Exception.Message @Using:credSplat
                Write-Output "Test-Connectivity FAILED. Exception: $($_.Exception.Message)"
            } 
            
            if ($ConnStatus -eq $True) { 
                foreach ($cmdName in $LocalcmdNames) {
                    $QueryPath = "$Using:ModulePath\Private\SQLScripts\$($LocalCommands.$cmdName.query_name)"
                    $RunDate = Get-Date
                    Try {
                        $DataSet = Invoke-Sqlcmd2 -ServerInstance $LocalInstance -Database $LocaldefaultDB -InputFile $QueryPath -as psobject @Using:credSplat #-ErrorAction Continue
                        $DataSet | Add-Member -MemberType NoteProperty -Name "job_id" -Value $LocalJob.Id
                        $DataSet | Add-Member -MemberType NoteProperty -Name "run_date" -Value $RunDate
                        $DataSet | Add-Member -MemberType NoteProperty -Name "run_count" -Value $Using:RunCount
                        $DataSet | Add-Member -MemberType NoteProperty -Name "instance_id" -Value $LocalInstanceId
                        $DataSet | Add-Member -MemberType NoteProperty  -Name "id" -Value ""
                        If ($Dataset){
                        Write-WrappedSqlTableData -ServerInstance $LocalconnSettings.server -DatabaseName $LocalconnSettings.database -SchemaName dbo -TableName $LocalCommands.$cmdName.dest_table -InputData $DataSet @Using:credSplat -Force -ErrorAction Stop
                        }
                        Write-JobMessage -RunDate $RunDate -RunCount $Using:RunCount -SQLInstance $LocalInstance -JobId $LocalJob.id -StepName $cmdName -Success $True @Using:credSplat
                    }
                    catch {
                        Write-JobMessage -RunDate $RunDate -RunCount $Using:RunCount -SQLInstance $LocalInstance -JobId $LocalJob.id -StepName $cmdName -Success $False -ExceptionMessage $_.Exception.Message @Using:credSplat
                        Write-Output "$($cmdName) FAILED. Exception: $($_.Exception.Message)"
                    }                
                }
            } 
        } -FunctionFilesToImport $Private 
    
        Write-Host "`nThrottle Value: $($Throttle)" -ForegroundColor Cyan

        $runningJobs = (Get-RSJob -State Running).Count

        While ($runningJobs -ne 0) {
            $jobs = Get-RSJob
            $runningJobs = $Jobs.Where{ $PSItem.State -eq 'Running' }.Count
            $WaitingJobs = $Jobs.Where{ $PSItem.State -eq 'NotStarted' }.Count
            $CompletedJobs = $Jobs.Where{ $PSItem.State -eq 'Completed' }.Count
            $FailedJobs = $Jobs.Where{ $PSItem.State -eq 'Failed' }.Count
             
            Write-Host "$runningJobs Jobs Running - $WaitingJobs Jobs Waiting - $CompletedJobs Jobs Finished - $FailedJobs Jobs Failed" -ForegroundColor Cyan
            Start-Sleep -Seconds 5
        }

        Write-Output "`nALL JOBS HAVE FINISHED"
        Write-Output "`nJOBS OUTPUT -" 
        Get-RSJob -Name "Kraken" | Receive-RSJob      
        Write-Output "`nREMOVING OLD JOBS"
        Get-RSJob -Name "Kraken" | Remove-RSJob
        Write-Output "FINISHED" 
    } # Process
}