# Web Server Deployment Validation
$resourceGroup = "production-rg"
$vmName = "WebServer01"

try {
    $vm = Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName -ErrorAction Stop
    
    if ($vm.PowerState -eq "VM running") {
        Write-Output "PASS"
    } else {
        Write-Output "FAIL"
    }
}
catch {
    Write-Output "FAIL"
}
