# Kraken 0.1

Kraken is a PowerShell Module which collects useful sql server metadata information for auditing and reporting purposes. It executes a series of lightweight, non-intrusive sql server queries and stores the information in your repository database. It is backward compatible down to SQL Server 2008 R2. Information collected includes:

  - Availability Groups, Replicas and Listener information
  - Availability Group Databases
  - Backups (Latest Backup per database and per type)
  - Database File (size and growth setting information)
  - Database Size
  - HADR Clusters, members and networks
  - OS Info
  - SQL Logins
  - Server Properties
  - Server Role Membership
  - Volume Information
  - Sys configurations
 
You could configure this to run on a schedule to get the full potential and be able to report on things like Volume and Database Size over time.

# Getting Started
 
#### Install dependencies

The only dependency is on sqlserver. Please install the sql server module prior installing Kraken

```sh
Install-module sqlserver
```

### Install Kraken Module

```sh
 Install-module Kraken
```

### Create Database & login

  - Create a repository database in your SQL Server, it could be any name but for simplicity you can name it Kraken
  - Create a sql login and map it to your repository database with read and write privileges "db_datareader" and "db_darawriter" should do. This login information will be needed on the next step when saving the values to Kraken config file.

### Set Kraken config values

Kraken uses a config file to retain information of the repository server and database, as well as the sql login that will be used to connect to the target servers and collect the information. The password for the account is encrypted.

Run the following cmdlet to set these values

```sh
 Set-DBSettings
```
- credentials: enter the sql login and password previously created on the repository server. It has to be a sql account, trusted authentication is not supported for now.
- dbserver: sqlservername.fqdn.com\instancename (enter the server name on this format)
- dbname: Kraken (it could be any name but use Kraken for identification purposes)

### Create the database schema

If your Windows account has enough privileges on the repository database to deploy the schema objects and write to the database, just execute the following command:

```sh
 Set-DBSchema
```

If you wan to use a sql account to connect and deploy the schema you can also do the same by doing the following:

```sh
 $Credential = Get-Credential
 Set-DBSchema -Credential $Credential
```

### Populate your sql_instances table

Insert values to the sql_instances table.

- id: identity column, it auto populates
- instance_name: use the same format as in the example below
- Environment: could be anything you defined based on your environment, i.e. DEV, TST, STG, QA, PRD
- Active: A value of 1 is active, a value of 0 is disabled and the process won't run against that target

| id | instance_name | environment | active |
| ------ | ------ |------ | ------ |
| 1 | sqlserver.fqdn.com\instancename | DEV | 1

### Create login and set permission on target servers

Create a login with the same name and password used in your repository database in all your target servers. This time though the only privileges needed are the following. Execute this after the login creation.

```sh
use [master]
GRANT VIEW SERVER STATE TO [<same user as in repo database>];
GO
GRANT VIEW ANY DEFINITION TO [<same user as in repo database>];
GO
GRANT VIEW ANY DATABASE TO [<same user as in repo database>];
GO
GRANT CONNECT ANY DATABASE to [<same user as in repo database>];
GO 
```

### Release the Kraken!

I wanted to call this cmdlet *Release-TheKraken* but.... "Release" is a PowerShell reserved word so I ended up using Invoke. Anyway you can run the following command now:

```sh
 Invoke-TheKraken
```

This cmdlet can accept different parameters:

- -All (switch) - This is default one. It will execute the process against all your active sql servers listed on the sql_instances table
- Environment (parameter) - Based on the values you defined in the environment column in sql_instances, you can use this parameter to only execute the process against a particular environment type. 
- Name (parameter) - You can also execute the process against specific sql servers instances by using this parameter, you can comma separate them if you want to include multiple. The SQL Instance must exist in y our sql_instances table otherwise the process will not execute against that target sql instance.

### Future enhancements

 - Make the process run in parallel
 

 
