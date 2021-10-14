

#zainstalowanie ARM: https://github.com/projectkudu/ARMClient
#wyłaczenie Attack Surface Reduction Executable Content
#instalacja Azure CLI: $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi

#pozyskanie danych dotyczacych LA, wymagana ścieżka z API obszaru roboczego pobrana z Azure Resource Manager
ARMClient.exe get "/subscriptions/1f6bb7ce-dab8-4d53-9c3b-4a96cfc5523a/resourceGroups/Logs_RG/providers/Microsoft.OperationalInsights/workspaces/Logs-ALL-workspace?api-version=2015-03-20"

#implikacja ustawień retencyjnych na wskazana tabele
ARMClient.exe put "/subscriptions/1f6bb7ce-dab8-4d53-9c3b-4a96cfc5523a/resourceGroups/Logs_RG/providers/Microsoft.OperationalInsights/workspaces/Logs-ALL-workspace/Tables/OfficeActivity?api-version=2017-04-26-preview" "{'properties':{'retentionInDays':35}}"


ARMClient.exe get "/subscriptions/1f6bb7ce-dab8-4d53-9c3b-4a96cfc5523a/resourcegroups/logs_rg/providers/microsoft.operationalinsights/workspaces/logs-all-workspace?api-version=2015-03-20"