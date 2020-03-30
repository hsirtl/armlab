#Requires -Version 3.0

Param(
    [string]                              $ResourceGroupLocation       = 'eastus',
    [string]                              $ResourceGroupName           = 'Xtraining-resources-rg',
    [string]                              $TemplateFile                = 'azuredeploy.trainingresources.json',
    [string]                              $TemplateParametersFile      = 'azuredeploy.trainingresources.parameters.json',
    [int]    [Parameter(Mandatory=$true)] $NumberOfVmInstances,
    [string] [Parameter(Mandatory=$true)] $virtualMachineAdminUserName,
    [string] [Parameter(Mandatory=$true)] $virtualMachineAdminPassword,
    [string]                              $virtualMachineNamePrefix    = 'MyVM0',
    [string]                              $virtualMachineSize          = 'Standard_DS1_v2',
    [string]                              $operatingSystem             = 'Server2016',
    [string]                              $dnsPrefixForPublicIP        = 'hsitvm',
    [string]                              $networkRgName               = 'Xtraining-network-rg',
    [string]                              $networkName                 = 'training-vnet',
    [string]                              $subnetName                  = 'default'
)

Connect-AzAccount

$TemplateFile = (Split-Path $MyInvocation.InvocationName) + "\" + $TemplateFile
$TemplateParametersFile = (Split-Path $MyInvocation.InvocationName) + "\" + $TemplateParametersFile
$ArtifactStagingDirectory = (Split-Path $MyInvocation.InvocationName) + "\" + $ArtifactStagingDirectory

$parameters = @{
    virtualMachineAdminUserName = @{'value'=$virtualMachineAdminUserName}
    virtualMachineAdminPassword = @{'value'=$virtualMachineAdminPassword}
    virtualMachineNamePrefix    = @{'value'=$virtualMachineNamePrefix}
    virtualMachineSize          = @{'value'=$virtualMachineSize}
    operatingSystem             = @{'value'=$operatingSystem}
    dnsPrefixForPublicIP        = @{'value'=$dnsPrefixForPublicIP}
    networkRgName               = @{'value'=$networkRgName}
    networkName                 = @{'value'=$networkName}
    subnetName                  = @{'value'=$subnetName}
}

$ContentMap = @{
    '$schema' = 'https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#'
    'contentVersion' = '1.0.0.0'
    'parameters' = $parameters
}

$Content = ($ContentMap | ConvertTo-Json)

Set-Content -Path $TemplateParametersFile -Value $Content

& ((Split-Path $MyInvocation.InvocationName) + "\Deploy-RG-Template-Generic.ps1") `    -ResourceGroupLocation $ResourceGroupLocation `    -ResourceGroupName $ResourceGroupName `    -TemplateFile $TemplateFile `    -TemplateParametersFile $TemplateParametersFile