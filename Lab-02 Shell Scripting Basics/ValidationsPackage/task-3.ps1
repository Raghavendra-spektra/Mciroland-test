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
        $vmName = "lab-vm-$deployment_id"
 
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
        $Commands = @(
           @'
PASS=true

SCRIPT="/home/labuser/disk-alert.sh"
LOG="/home/labuser/reports/DiskUsageLog.txt"

[ -f "$SCRIPT" ] || PASS=false

rm -f "$LOG"

OUTPUT=$(bash "$SCRIPT" 2>&1)

[ -f "$LOG" ] || PASS=false
[ -s "$LOG" ] || PASS=false

grep -q "^Filesystem:" "$LOG" || PASS=false
grep -q "^Total Size (GB):" "$LOG" || PASS=false
grep -q "^Free Space (GB):" "$LOG" || PASS=false
grep -q "^Free Percentage:" "$LOG" || PASS=false
grep -q "^Status:" "$LOG" || PASS=false
grep -q "^Date and Time:" "$LOG" || PASS=false

# Ensure root filesystem is logged
grep -q "/" "$LOG" || PASS=false

# Ensure status contains meaningful value
grep -Eiq "healthy|warning" "$LOG" || PASS=false

# Ensure percentage value exists
grep -Eq "[0-9]+%" "$LOG" || PASS=false

# Script should display output
[ -n "$OUTPUT" ] || PASS=false

if $PASS
then
    echo "TASK-3 PASSED"
    exit 0
else
    echo "TASK-3 FAILED"
    echo "===== LOG ====="
    cat "$LOG" 2>/dev/null
    exit 1
fi
'@
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
                Message = "TASK-3 validation passed."
            } | ConvertTo-Json
 
        }
        else {
 
            $message = @{
                Status  = "Failed"
                Message = "TASK-3 validation failed."
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