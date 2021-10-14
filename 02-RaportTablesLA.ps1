## REQS ## You will need ARMClient, AZ CLI, and Az modules installed https://github.com/swiftsolves-msft/PowerShell-Scripts/blob/master/TableRetentionReport.ps1


# Variables for Workspace to report on
$subid = "1f6bb7ce-dab8-4d53-9c3b-4a96cfc5523a"
$workspaceid = "6652660f-9e04-4fae-a6d9-f9a7ae3c47c0"
$workspacerg = "Logs_RG"
$workspacename = "Logs-ALL-workspace"

# Authentication time across PS and ARMClient

Login-AzAccount

Set-AzContext -SubscriptionId $subid

ARMClient.exe azlogin
nbhgngh
# Create a report hash table
$report = $null
$report = @{}

# get distinct tables where data is stored in Log Analytics
$tables = Invoke-AzOperationalInsightsQuery -WorkspaceId $workspaceid -Query "union withsource = tt * | distinct tt"

$tables = $tables.Results.tt

#Obtain Log ANalytics retention setting at workspace
$works = Get-AzOperationalInsightsWorkspace -ResourceGroupName $workspacerg -Name $workspacename
$worksret = $works.retentionInDays

# Iterate through the differnt tables and report on their retention settings
foreach ($table in $tables){

    # Using ARM to find the data table properties
    $armcall = "/subscriptions/" + $subid + "/resourceGroups/" + $workspacerg + "/providers/Microsoft.OperationalInsights/workspaces/" + $workspacename + "/Tables/" + $table +  "?api-version=2017-04-26-preview"
    
    $answer = armclient GET $armcall

    # conversion to manipulate strings easier
    $answer = $answer | ConvertFrom-Json

    # conditional check the data table has a unique retention set
    if ($answer.properties.retentionInDays -ge 1){

        Write-host "True"
        Write-Host $answer.properties.retentionInDays
        Write-Host $table
        $report.Add( $table, $answer.properties.retentionInDays )
    
    }

    # If not uniue then the data table is getting retention from the workspace setting
    Elseif ($answer.properties.retentionInDays -le 1) {

        Write-host "False"
        Write-Host $worksret
        Write-Host $table
        $report.Add( $table, $worksret )

    }

}

$report
