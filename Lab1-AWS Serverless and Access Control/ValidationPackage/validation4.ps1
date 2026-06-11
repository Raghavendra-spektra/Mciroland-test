$region = "us-east-1"

Set-DefaultAWSRegion -Region $region

try {

    $logGroupName = "/aws/lambda/ServerlessWebApp"

    # Ensure log group exists
    $logGroup = Get-CWLLogGroup -LogGroupNamePrefix $logGroupName

    if (-not $logGroup) {
        throw "CloudWatch log group does not exist."
    }

    # Get latest log stream
    $streams = Get-CWLLogStream -LogGroupName $logGroupName

    if (-not $streams) {
        throw "No log streams found. S3 trigger not fired yet."
    }

    $latestStream = $streams | Sort-Object LastEventTimestamp -Descending | Select-Object -First 1

    if (-not $latestStream) {
        throw "No recent log stream found."
    }

    # Get log events
    $events = Get-CWLLogEvent `
        -LogGroupName $logGroupName `
        -LogStreamName $latestStream.LogStreamName

    $logText = ($events.Events | ForEach-Object { $_.Message }) -join " "

    # Validate trigger activity (S3 upload event)
    if ($logText -match "s3" -or $logText -match "ObjectCreated" -or $logText -match "PUT") {

        $message = @{
            Status  = "Succeeded"
            Message = "S3 upload successfully logged in CloudWatch."
        } | ConvertTo-Json -Compress
    }
    else {

        $message = @{
            Status  = "Failed"
            Message = "CloudWatch logs exist but no S3 event detected."
        } | ConvertTo-Json -Compress
    }
}
catch {

    $message = @{
        Status  = "Failed"
        Message = $_.Exception.Message
    } | ConvertTo-Json -Compress
}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = 200
    Body = $message
})