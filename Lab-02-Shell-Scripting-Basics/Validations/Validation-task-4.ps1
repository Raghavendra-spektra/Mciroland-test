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

SCRIPT="/home/labuser/backup-folder.sh"
SOURCE="/home/labuser/LabData"
BACKUP_DIR="/home/labuser/backups"
REPORT="/home/labuser/reports/BackupLog.txt"

[ -f "$SCRIPT" ] || PASS=false

mkdir -p "$SOURCE"
mkdir -p "$BACKUP_DIR"

# Create sample files required by lab
echo "Sample File 1" > "$SOURCE/file1.txt"
echo "Sample File 2" > "$SOURCE/file2.txt"
echo "Sample File 3" > "$SOURCE/file3.txt"

rm -f "$BACKUP_DIR"/*.tar.gz
rm -f "$REPORT"

OUTPUT=$(bash "$SCRIPT" 2>&1)

LATEST=$(find "$BACKUP_DIR" -name "*.tar.gz" | head -1)

[ -n "$LATEST" ] || PASS=false

# Verify archive is valid
tar -tzf "$LATEST" >/dev/null 2>&1 || PASS=false

# Verify sample files are included
tar -tzf "$LATEST" | grep -q "file1.txt" || PASS=false
tar -tzf "$LATEST" | grep -q "file2.txt" || PASS=false
tar -tzf "$LATEST" | grep -q "file3.txt" || PASS=false

# Verify timestamp format in filename
BASENAME=$(basename "$LATEST")

echo "$BASENAME" | grep -Eq '[0-9]{8}-[0-9]{6}\.tar\.gz$' || PASS=false

# Report validation
[ -f "$REPORT" ] || PASS=false
[ -s "$REPORT" ] || PASS=false

grep -q "^Backup Time:" "$REPORT" || PASS=false
grep -q "^Source Path:" "$REPORT" || PASS=false
grep -q "^Backup File Name:" "$REPORT" || PASS=false
grep -q "^Backup Size:" "$REPORT" || PASS=false

# Success message displayed
[ -n "$OUTPUT" ] || PASS=false

if $PASS
then
    echo "TASK-4 PASSED"
    exit 0
else
    echo "TASK-4 FAILED"
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
                Message = "TASK-4 validation passed."
            } | ConvertTo-Json
 
        }
        else {
 
            $message = @{
                Status  = "Failed"
                Message = "TASK-4 validation failed."
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