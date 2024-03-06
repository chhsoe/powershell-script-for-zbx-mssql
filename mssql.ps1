$instanceName = 'YourInstanceName'
$server = "localhost"
$username = "xx"
$password = "xx"
$query = 'SELECT name FROM sys.databases'
$queryResults = @()
$data = @()


# If using Windows Authentication
$databases = Invoke-Sqlcmd -ServerInstance $server -Username $username -Password $password -Query $query
$queryResults += $databases
foreach ($dbName in $queryResults) {
    $data += @{
        "{#DBS}" = $dbName[0]
    }
}


# If you need to use SQL Server authentication, include the -Username and -Password parameters
# $databases = Invoke-Sqlcmd -ServerInstance $instanceName -Database 'master' -Query $query -Username 'YourUsername' -Password 'YourPassword'

$discoveryData = @{
    "data" = $data
} | ConvertTo-Json -Compress

Write-Host $discoveryData
