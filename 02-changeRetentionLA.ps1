ARMClient.exe get "/subscriptions/1f6bb7ce-dab8-4d53-9c3b-4a96cfc5523a/resourceGroups/Logs_RG/providers/Microsoft.OperationalInsights/workspaces/Logs-ALL-workspace?api-version=2015-03-20"

ARMClient.exe put "/subscriptions/1f6bb7ce-dab8-4d53-9c3b-4a96cfc5523a/resourceGroups/Logs_RG/providers/Microsoft.OperationalInsights/workspaces/Logs-ALL-workspace/Tables/OfficeActivity?api-version=2017-04-26-preview" "{'properties':{'retentionInDays':35}}"
