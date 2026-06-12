$region = "us-east-1"
Set-DefaultAWSRegion -Region $region
try {
    # Get IAM role
    $role = Get-IAMRole -RoleName "lam-lab-role" -ErrorAction Stop

    # Get attached policies — returns a direct list, not a wrapper object
    $policies = Get-IAMAttachedRolePolicyList -RoleName "lam-lab-role"

    $hasS3Policy = $false
    foreach ($p in $policies) {
        if ($p.PolicyArn -like "*AmazonS3ReadOnlyAccess*") {
            $hasS3Policy = $true
            break
        }
    }

    if ($hasS3Policy) {
        $message = @{
            Status  = "Succeeded"
            Message = "IAM role exists with correct policy attached."
        } | ConvertTo-Json -Compress
    }
    else {
        $message = @{
            Status  = "Failed"
            Message = "Role or policy is missing/incorrect."
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