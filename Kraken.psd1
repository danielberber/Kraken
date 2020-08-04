@{
	RootModule        = 'Kraken.psm1'
	ModuleVersion     = '1.0.2'
	GUID              = '6c92d16e-9da5-4f35-8567-11a211f85833'
	Author            = 'Daniel Berber'
	Copyright         = '(c) Daniel Berber. All rights reserved.'
	Description       = 'Kraken is a PowerShell Module which collects useful sql server metadata information for auditing and reporting purposes. It executes a series of lightweight, non-intrusive sql server queries and stores the information in your repository database. It is backward compatible down to SQL Server 2008 R2'
	RequiredModules   = @("sqlserver")
	FunctionsToExport = @('*')
	VariablesToExport = @()
	AliasesToExport   = @()
	PrivateData       = @{
		PSData = @{
			Tags       = @('PSInsight', 'REST')
			ProjectUri = 'https://github.com/dokier/Kraken'
		}
	}
}