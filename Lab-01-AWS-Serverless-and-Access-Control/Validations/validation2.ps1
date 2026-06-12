$region = "us-east-1"

Set-DefaultAWSRegion -Region $region

try {

    $lambda = Get-LMFunctionConfiguration -FunctionName "ServerlessWebApp" -ErrorAction Stop
    $config = Get-LMFunctionUrlConfig -FunctionName "ServerlessWebApp" -ErrorAction Stop

    if ($config -and $config.AuthType -eq "NONE") {

        $message = @{
            Status  = "Succeeded"
            Message = "Function URL is enabled with NONE auth."
        } | ConvertTo-Json -Compress
    }
    else {

        $message = @{
            Status  = "Failed"
            Message = "Function URL auth type is not NONE."
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
    StatusCode = [System.Net.HttpStatusCode]::OK
    Body       = $message
})