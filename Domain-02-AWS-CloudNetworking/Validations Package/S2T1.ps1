# RDS Deployment Validation
$region = "us-east-1"

Set-DefaultAWSRegion -Region $region

try {
    $rdsInstances = Get-RDSDBInstance -DBInstanceIdentifier "production-mysql" -ErrorAction Stop
    
    if ($rdsInstances.DBInstanceStatus -eq "available") {
        echo "PASS"
    } else {
        echo "FAIL"
    }
}
catch {
    echo "FAIL"
}
