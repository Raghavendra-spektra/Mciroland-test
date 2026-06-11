$region = "us-east-1"
$deployment_id     = $deployment_id

Set-DefaultAWSRegion -Region $region

$stopRetry = $false
[int]$retryCount = 0
$maxRetries = 3

do {
    try {

        # Authentication check
        $identity = Get-STSCallerIdentity
        $identity.Arn | Out-Null

        # VM Name from deployment id
        $vmName = "labvm-$deployment_id"

        # Find instance
        $reservation = Get-EC2Instance `
            -Region $region `
            -Filter @(
                @{ Name = "tag:Name"; Values = @($vmName) },
                @{ Name = "instance-state-name"; Values = @("running") }
            )

        $instance = $reservation |
            Select-Object -ExpandProperty Instances |
            Select-Object -First 1

        if (-not $instance) {
            throw "Instance '$vmName' not found."
        }

        $instanceId = $instance.InstanceId

        # Validation script
        $commands = @(
            'PASS=true',
        '[ -f /tmp/cpu_report.txt ] || PASS=false',
        'grep -q "NI" /tmp/cpu_report.txt || PASS=false',
        'grep -q "10" /tmp/cpu_report.txt || PASS=false',
        'if $PASS; then echo "TASK-6 PASSED"; exit 0; else echo "TASK-6 FAILED"; exit 1; fi'
        )

        $response = Send-SSMCommand `
            -Region $region `
            -DocumentName "AWS-RunShellScript" `
            -InstanceId $instanceId `
            -Parameter @{
                commands = $commands
            }

        $commandId = $response.CommandId

        # Wait for completion
        do {
            Start-Sleep -Seconds 5

            $invocation = Get-SSMCommandInvocation `
                -Region $region `
                -CommandId $commandId `
                -InstanceId $instanceId

            $status = $invocation.Status.ToString()

        } while ($status -in @("Pending","InProgress","Delayed"))

        if ($status -eq "Success") {

            $message = @{
                Status  = "Succeeded"
                Message = "TASK-6 validation passed."
            } | ConvertTo-Json

        }
        else {

            $message = @{
                Status  = "Failed"
                Message = "TASK-6 validation failed."
            } | ConvertTo-Json

        }

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