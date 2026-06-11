$regions = @(
    "us-east-1",
    "us-east-2",
    "us-west-2"
)

Set-DefaultAWSRegion -Region $region

try {

    $instance = Get-EC2Instance | ForEach-Object { $_.Instances } | Where-Object {
        $_.State.Name.Value -eq "running" -and
        ($_.Tags | Where-Object {
            $_.Key -eq "Name" -and $_.Value -eq "Lab1-App-Server"
        })
    } | Select-Object -First 1

    if (-not $instance) {
        throw "EC2 instance 'Lab1-App-Server' not found or not running."
    }

    if ($instance.InstanceType.Value -notin @("t2.micro", "t3.micro")) {
        throw "Instance type is not t2.micro or t3.micro."
    }

    $message = @{
        Status  = "Succeeded"
        Message = "Lab1-App-Server exists, is running, and uses a valid instance type."
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