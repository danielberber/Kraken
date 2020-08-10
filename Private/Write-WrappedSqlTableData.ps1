function Write-WrappedSqlTableData
{
[CmdletBinding()]
    param (
        [string] $ServerInstance,
        [Parameter(Mandatory=$false)]
        [string] $DatabaseName,
        [Parameter(Mandatory=$false)]
        [string] $SchemaName,
        [Parameter(Mandatory=$true,ValueFromPipeline)][ValidateNotNullOrEmpty()]
        [PSObject] $InputData,
        #[Parameter(Position=1,Mandatory=$false,ValueFromPipeline)]
        #[Microsoft.SqlServer.Management.Smo.Table[]] $InputObject,
        [Parameter(Mandatory=$false)]
        [string] $TableName,
        [Parameter(Mandatory=$false)]
        [PSCredential] $Credential,
        [Parameter(Mandatory=$false)]
        [Int32] $Timeout,
        [Parameter(Mandatory=$false)]
        [Int32] $ConnectionTimeout,
        [Parameter(Mandatory=$false)]
        [switch] $SuppressProviderContextWarning,
        [Parameter(Mandatory=$false)]
        [switch] $IgnoreProviderContext,
        [Parameter(Mandatory=$false)]
        [switch] $Force,
        [Parameter(Mandatory=$false)]
        [switch] $Passthru,
        [Parameter(Mandatory=$false)]
        [Microsoft.SqlServer.Management.PowerShell.OutputType] $OutputAs

    )
    try
    {
        # Locking on some random type that should be available everywhere..
        [System.Threading.Monitor]::Enter([guid])
        $ReturnValue = Write-SqlTableData  @PSBoundParameters
    }
    catch
    {
        $ErrorMessage = "Error during Write-WrappedSqlTableData:$([System.Environment]::NewLine)$_"
        throw $ErrorMessage
    }
    finally
    {
        # Exiting the lock
       [System.Threading.Monitor]::Exit([guid])
    }
 
    return $ReturnValue
}