#Requires -Version 3.0

Param(
    [string] $ResourceGroupLocation = 'eastus',
    [string] $ResourceGroupName = 'Xtraining-network-rg',
    [string] $TemplateFile = 'azuredeploy.network.json',
    [string] $TemplateParametersFile = 'azuredeploy.network.parameters.json'
)

Connect-AzAccount

$TemplateFile = (Split-Path $MyInvocation.InvocationName) + "\" + $TemplateFile
$TemplateParametersFile = (Split-Path $MyInvocation.InvocationName) + "\" + $TemplateParametersFile
$ArtifactStagingDirectory = (Split-Path $MyInvocation.InvocationName) + "\" + $ArtifactStagingDirectory

& ((Split-Path $MyInvocation.InvocationName) + "\Deploy-RG-Template-Generic.ps1") `
    -ResourceGroupLocation $ResourceGroupLocation `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParametersFile $TemplateParametersFile