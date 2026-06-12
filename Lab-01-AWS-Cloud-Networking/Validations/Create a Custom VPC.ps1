$regions = @(
    "us-east-1",
    "us-east-2",
    "us-west-2"
)

Set-DefaultAWSRegion -Region $region

try {

    $vpc = Get-EC2Vpc | Where-Object {
        ($_.Tags | Where-Object {
            $_.Key -eq "Name" -and $_.Value -eq "Lab1-VPC"
        })
    }

    if ($vpc -and $vpc.CidrBlock -eq "10.0.0.0/16") {

        $message = @{
            Status  = "Succeeded"
            Message = "Lab1-VPC exists with CIDR 10.0.0.0/16."
        } | ConvertTo-Json

    }
    else {

        $message = @{
            Status  = "Failed"
            Message = "Lab1-VPC does not exist or has an incorrect CIDR block."
        } | ConvertTo-Json

    }

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