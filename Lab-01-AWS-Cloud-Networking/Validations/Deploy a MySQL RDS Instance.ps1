$regions = @(
    "us-east-1",
    "us-east-2",
    "us-west-2"
)

Set-DefaultAWSRegion -Region $region

try {

    $rds = Get-RDSDBInstance | Select-Object -First 1

if (-not $rds) {
    throw "No RDS instance found."
}

    if (-not $rds) {
        throw "RDS instance 'Lab1-MySQL-RDS' not found."
    }

    if ($rds.Engine -ne "mysql") {
        throw "Database engine is not MySQL."
    }

    if (-not ($rds.EngineVersion.StartsWith("8."))) {
        throw "MySQL version is not 8.x."
    }

    if ($rds.DBInstanceClass -ne "db.t3.micro") {
        throw "Instance class is not db.t3.micro."
    }

    if ($rds.PubliclyAccessible -ne $false) {
        throw "Public accessibility is enabled."
    }

    if ($rds.DBInstanceStatus -ne "available") {
        throw "RDS instance is not in Available state."
    }

    $message = @{
        Status  = "Succeeded"
        Message = "Lab1-MySQL-RDS meets all required configuration criteria."
    } | ConvertTo-Json

}
catch {

    $message = @{
        Status  = "Failed"
        Message = $_.Exception.Message
    } | ConvertTo-Json

}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [System.Net.HttpStatusCode]::OK
    Body       = $message
})