$rg = 'magazyn'
#New-AzResourceGroup -Name $rg -Location westeurope -Force

New-AzResourceGroupDeployment `
    -Name 'magazyn43534535' `
    -ResourceGroupName $rg `
    -TemplateFile '01-storage.json'