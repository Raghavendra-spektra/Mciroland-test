# CloudFormation Stack Validation
$region = "us-east-1"

Set-DefaultAWSRegion -Region $region

try {
    $stack = Get-CFStack -StackName "production-vpc" -ErrorAction Stop
    
    if ($stack.StackStatus -like "*COMPLETE") {
        echo "PASS"
    } else {
        echo "FAIL"
    }
}
catch {
    echo "FAIL"
}
