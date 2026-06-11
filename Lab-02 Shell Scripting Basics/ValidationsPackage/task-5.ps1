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

SCRIPT="/home/labuser/system-tools.sh"
REPORT="/home/labuser/reports/SystemInfoReport.txt"

[ -f "$SCRIPT" ] || PASS=false

rm -f "$REPORT"

OUTPUT=$(bash "$SCRIPT" 2>&1)

[ -f "$REPORT" ] || PASS=false
[ -s "$REPORT" ] || PASS=false

# Required report fields
grep -q "^Hostname:" "$REPORT" || PASS=false
grep -q "^Operating System:" "$REPORT" || PASS=false
grep -q "^Current User:" "$REPORT" || PASS=false
grep -q "^Filesystem:" "$REPORT" || PASS=false
grep -q "^Total Space:" "$REPORT" || PASS=false
grep -q "^Available Space:" "$REPORT" || PASS=false

# Function existence
grep -q "get_system_info()" "$SCRIPT" || PASS=false
grep -q "get_disk_status()" "$SCRIPT" || PASS=false

# Script should display output
[ -n "$OUTPUT" ] || PASS=false

if $PASS
then
    echo "TASK-5 PASSED"
    exit 0
else
    echo "TASK-5 FAILED"
    echo "===== REPORT ====="
    cat "$REPORT" 2>/dev/null
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
                Message = "TASK-5 validation passed."
            } | ConvertTo-Json
 
        }
        else {
 
            $message = @{
                Status  = "Failed"
                Message = "TASK-5 validation failed."
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