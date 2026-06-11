# Auto Scaling Group Validation
$region = "us-east-1"

Set-DefaultAWSRegion -Region $region

try {
    $asg = Get-ASAutoScalingGroup -AutoScalingGroupName "production-asg" -ErrorAction Stop
    
    if ($asg.DesiredCapacity -ge 1) {
        echo "PASS"
    } else {
        echo "FAIL"
    }
}
catch {
    echo "FAIL"
}
