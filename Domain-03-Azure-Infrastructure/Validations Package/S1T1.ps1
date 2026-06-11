# Azure ARM Template Validation
$resourceGroup = "production-rg"
$deploymentName = "arm-deployment"

try {
    $deployment = Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -Name $deploymentName -ErrorAction Stop
    
    if ($deployment.ProvisioningState -eq "Succeeded") {
        Write-Output "PASS"
    } else {
        Write-Output "FAIL"
    }
}
catch {
    Write-Output "FAIL"
}
