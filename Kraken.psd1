@{
	RootModule        = 'Kraken.psm1'
	ModuleVersion     = '0.1'
	GUID              = '6c92d16e-9da5-4f35-8567-11a211f85833'
	Author            = 'Daniel Berber'
	Copyright         = '(c) Daniel Berber. All rights reserved.'
	Description       = 'Kraken retrieves metadata information from a list of SQL Server Instances and stores the information in a database for reporting & auditing purposes'
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