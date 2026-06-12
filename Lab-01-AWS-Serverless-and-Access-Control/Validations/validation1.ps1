$region = "us-east-1"

Set-DefaultAWSRegion -Region $region

try {

    $lambda = Get-LMFunctionConfiguration `
        -FunctionName "ServerlessWebApp" `
        -ErrorAction Stop

    if ($lambda.Runtime -eq "python3.12") {

        $message = @{
            Status  = "Succeeded"
            Message = "Lambda function exists and runtime is python3.12."
        } | ConvertTo-Json
    }
    else {

        $message = @{
            Status  = "Failed"
            Message = "Runtime is not python3.12."
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