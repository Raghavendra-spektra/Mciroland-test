$regions = @(
    "us-east-1",
    "us-east-2",
    "us-west-2"
)

Set-DefaultAWSRegion -Region $region

try {

    # Validate Auto Scaling Group
    $asg = Get-ASAutoScalingGroup -AutoScalingGroupName "Lab1-ASG" -ErrorAction Stop

    if (-not $asg) {
        throw "Auto Scaling Group 'Lab1-ASG' not found."
    }

    # Validate instances are deployed in private subnets
    $privateSubnets = Get-EC2Subnet | Where-Object {
        ($_.Tags | Where-Object {
            $_.Key -eq "Name" -and $_.Value -in @("Private-Subnet-A","Private-Subnet-B")
        })
    }

    $privateSubnetIds = $privateSubnets.SubnetId

    $asgSubnetIds = $asg.VPCZoneIdentifier -split ","

    $allPrivate = $true

    foreach ($subnetId in $asgSubnetIds) {
        if ($privateSubnetIds -notcontains $subnetId.Trim()) {
            $allPrivate = $false
        }
    }

    if (-not $allPrivate) {
        throw "ASG is not configured to use only private subnets."
    }

    # Validate Target Group Registration
    $targetGroup = Get-ELB2TargetGroup | Where-Object {
        $_.TargetGroupName -eq "Lab1-TG"
    } | Select-Object -First 1

    if (-not $targetGroup) {
        throw "Target Group 'Lab1-TG' not found."
    }

    $asgTargetGroups = Get-ASLoadBalancerTargetGroup `
        -AutoScalingGroupName "Lab1-ASG" `
        -ErrorAction SilentlyContinue

    $registered = $asgTargetGroups | Where-Object {
        $_.LoadBalancerTargetGroupARN -eq $targetGroup.TargetGroupArn
    }

    if (-not $registered) {
        throw "Lab1-ASG is not registered with Lab1-TG."
    }

    $message = @{
        Status  = "Succeeded"
        Message = "Lab1-ASG exists, uses private subnets, and is registered with Lab1-TG."
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