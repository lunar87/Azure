
$config = Get-Content -Raw -Path ".\Azure\config.json" | ConvertFrom-Json
$subName = $config.subName
# Call another PowerShell script to login to Azure and set the subscription
$subscriptionId = & (".\Azure\login.ps1") -subscription $subName
echo $subscriptionId

$loc="centralus"
$rgname = $config.ResourceGroupname
New-AzResourceGroup -Name $rgname -Location $loc

$path=".\Azure\bicep\NetworkSecurityPerimeter\"
$template=$path + "nsp.bicep"
$param=$path + "nsp.param.json"
$tempParamFilePath = "nsp.param.temp.json"
(Get-Content $param) -replace '{subscriptionId}', $subscriptionId `
                             -replace '{resourceGroupName}', $config.kvResourceGroupName `
                             -replace '{keyVaultName}', $config.keyVaultName | Set-Content $tempParamFilePath
                           
Test-AzResourceGroupDeployment -ResourceGroupName $rgname `
    -TemplateFile $template -TemplateParameterFile $tempParamFilePath -Verbose

New-AzResourceGroupDeployment -ResourceGroupName $rgname `
    -TemplateFile $template -TemplateParameterFile $tempParamFilePath

Remove-Item $tempParamFilePath


Get-AzResourceGroupDeploymentOperation -ResourceGroupName $rgname `
    -DeploymentName nsp | Where-Object { $_.Properties.ProvisioningState -eq 'Failed' } `
    | Select-Object -ExpandProperty Properties | Select-Object -ExpandProperty StatusMessage `
    | Select-Object -ExpandProperty Error

# Retrieve and filter failed deployment operations
$failedOperations = Get-AzResourceGroupDeploymentOperation -ResourceGroupName $rgname `
    -DeploymentName nsp | Where-Object { $_.Properties.ProvisioningState -eq 'Failed' }

# Display the failed operations
$failedOperations | ForEach-Object {
$_.Properties.StatusMessage.Error
}

Remove-AzResourceGroup -Name $rgname -Force
