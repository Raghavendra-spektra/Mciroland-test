$regions = @(
    "us-east-1",
    "us-east-2",
    "us-west-2"
)

Set-DefaultAWSRegion -Region $region

try {

    # Validate NAT Gateway
    $natGateway = Get-EC2NatGateway | Where-Object {
        ($_.Tags | Where-Object {
            $_.Key -eq "Name" -and $_.Value -eq "Lab1-NAT-GW"
        })
    } | Select-Object -First 1

    if (-not $natGateway) {
        throw "NAT Gateway 'Lab1-NAT-GW' not found."
    }

    # Validate Route Table
    $routeTable = Get-EC2RouteTable | Where-Object {
        ($_.Tags | Where-Object {
            $_.Key -eq "Name" -and $_.Value -eq "Private-RT"
        })
    } | Select-Object -First 1

    if (-not $routeTable) {
        throw "Route Table 'Private-RT' not found."
    }

    $message = @{
        Status  = "Succeeded"
        Message = "Lab1-NAT-GW and Private-RT exist."
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