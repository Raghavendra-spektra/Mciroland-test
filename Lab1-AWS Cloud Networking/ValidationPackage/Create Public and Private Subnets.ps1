$regions = @(
    "us-east-1",
    "us-east-2",
    "us-west-2"
)

Set-DefaultAWSRegion -Region $region

try {

    $requiredSubnets = @(
        "Public-Subnet-A",
        "Public-Subnet-B",
        "Private-Subnet-A",
        "Private-Subnet-B"
    )

    $subnets = Get-EC2Subnet

    $foundSubnets = @()
    $availabilityZones = @()

    foreach ($subnetName in $requiredSubnets) {

        $subnet = $subnets | Where-Object {
            ($_.Tags | Where-Object {
                $_.Key -eq "Name" -and $_.Value -eq $subnetName
            })
        } | Select-Object -First 1

        if (-not $subnet) {
            throw "Subnet $subnetName not found."
        }

        if ($subnet.CidrBlock -notmatch "/24$") {
            throw "Subnet $subnetName is not using a /24 CIDR block."
        }

        $foundSubnets += $subnet
        $availabilityZones += $subnet.AvailabilityZone
    }

    $uniqueAZs = $availabilityZones | Select-Object -Unique

    if ($uniqueAZs.Count -lt 2) {
        throw "Subnets are not distributed across at least 2 Availability Zones."
    }

    $message = @{
        Status  = "Succeeded"
        Message = "All required subnets exist, use /24 CIDR blocks, and are distributed across at least 2 Availability Zones."
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