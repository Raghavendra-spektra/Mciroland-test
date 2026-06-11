# Automation Runbook Validation
$resourceGroup = "production-rg"
$automationAccount = "ProductionAutomation"

try {
    $runbooks = Get-AzAutomationRunbook -ResourceGroupName $resourceGroup -AutomationAccountName $automationAccount -ErrorAction Stop
    
    if ($runbooks.Count -gt 0) {
        Write-Output "PASS"
    } else {
        Write-Output "FAIL"
    }
}
catch {
    Write-Output "FAIL"
}
