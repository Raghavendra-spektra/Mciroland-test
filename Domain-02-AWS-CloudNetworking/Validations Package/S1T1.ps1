$region = "us-east-1"
$deployment_id = $deployment_id

Set-DefaultAWSRegion -Region $region

$stopRetry = $false
[int]$retryCount = 0
$maxRetries = 3

do {
    try {
        # Authentication check
        $identity = Get-STSCallerIdentity
        $identity.Arn | Out-Null

        # Verify VPC creation
        $vpcs = Get-EC2Vpc -Filter @{Name="tag:Name"; Values="Production-VPC"}
        
        if ($vpcs.Count -eq 0) {
            throw "VPC not found"
        }

        $message = @{
            Status  = "Succeeded"
            Message = "VPC validation passed."
        } | ConvertTo-Json

        Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [System.Net.HttpStatusCode]::OK
            Body       = $message
        })

        $stopRetry = $true
    }
    catch {
        if ($retryCount -ge $maxRetries) {
            $message = @{
                Status  = "Failed"
                Message = "Retry exhausted: $($_.Exception.Message)"
            } | ConvertTo-Json

            Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
                StatusCode = [System.Net.HttpStatusCode]::OK
                Body       = $message
            })

            $stopRetry = $true
        }
        else {
            Start-Sleep -Seconds 60
            $retryCount++
        }
    }

} while ($stopRetry -eq $false)
