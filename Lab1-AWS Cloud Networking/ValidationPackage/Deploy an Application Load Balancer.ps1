$regions = @(
    "us-east-1",
    "us-east-2",
    "us-west-2"
)

Set-DefaultAWSRegion -Region $region

try {

    $alb = Get-ELB2LoadBalancer | Where-Object {
        $_.LoadBalancerName -eq "Lab1-ALB"
    } | Select-Object -First 1

    if (-not $alb) {
        throw "Application Load Balancer 'Lab1-ALB' not found."
    }

    $listener = Get-ELB2Listener -LoadBalancerArn $alb.LoadBalancerArn | Where-Object {
        $_.Protocol -eq "HTTP" -and $_.Port -eq 80
    }

    if (-not $listener) {
        throw "HTTP listener on port 80 not found."
    }

    $message = @{
        Status  = "Succeeded"
        Message = "Lab1-ALB exists and has an HTTP listener on port 80."
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