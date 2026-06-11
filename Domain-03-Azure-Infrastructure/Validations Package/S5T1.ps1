# VNet Configuration Validation
$resourceGroup = "production-rg"
$vnetName = "ProductionVNet"

try {
    $vnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroup -Name $vnetName -ErrorAction Stop
    $subnets = $vnet.Subnets
    
    if ($subnets.Count -ge 2) {
        Write-Output "PASS"
    } else {
        Write-Output "FAIL"
    }
}
catch {
    Write-Output "FAIL"
}
