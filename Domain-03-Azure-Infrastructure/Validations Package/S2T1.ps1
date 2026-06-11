# SSH Access Validation
$resourceGroup = "production-rg"
$vmName = "ProductionVM"

try {
    $vm = Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName -ErrorAction Stop
    $nsg = Get-AzNetworkSecurityGroup | Where-Object { $_.ResourceGroupName -eq $resourceGroup }
    
    $sshRule = $nsg.SecurityRules | Where-Object { $_.DestinationPortRange -eq "22" }
    
    if ($sshRule -and $sshRule.Access -eq "Allow") {
        Write-Output "PASS"
    } else {
        Write-Output "FAIL"
    }
}
catch {
    Write-Output "FAIL"
}
