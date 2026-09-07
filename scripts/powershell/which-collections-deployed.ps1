<#
.SYNOPSIS
    Generates a report showing SCCM application deployments to "All Users",
    other collections, or no deployment at all.

.COMPATIBILITY
    PowerShell 5.1
    SCCM Current Branch
#>

#region Configuration

$SiteCode        = "S01"  # 🔧 CHANGE to your site code
$ProviderMachine = "SEPCSCM008.company.com"  # 🔧 CHANGE if required
$AppListPath     = "C:\Users\shaiadm\Desktop\dev.txt"
$ReportPath      = "C:\Users\shaiadm\Desktop\dev.csv"

#endregion Configuration

#region Load SCCM Module

try {
    Import-Module "E:\Program files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager\ConfigurationManager.psd1"
    Set-Location "$SiteCode`:"
}
catch {
    throw "Failed to load Configuration Manager module. Verify SCCM console install."
}

#endregion Load SCCM Module

#region Validation

if (-not (Test-Path $AppListPath)) {
    throw "Application list file not found: $AppListPath"
}

#endregion Validation

#region Processing

$Results = foreach ($AppName in Get-Content $AppListPath) {

    $AppName = $AppName.Trim()
    if ([string]::IsNullOrWhiteSpace($AppName)) { continue }

    try {
        $App = Get-CMApplication -Name $AppName -ErrorAction SilentlyContinue

        if (-not $App) {
            [PSCustomObject]@{
                ApplicationName     = $AppName
                DeployedToAllUsers  = "Not Found"
                OtherCollections    = ""
                NoDeployment        = "N/A"
            }
            continue
        }

        $Deployments = Get-CMApplicationDeployment -ApplicationName $AppName

        # No deployments
        if (-not $Deployments) {
            [PSCustomObject]@{
                ApplicationName     = $AppName
                DeployedToAllUsers  = "No"
                OtherCollections    = ""
                NoDeployment        = "Yes"
            }
            continue
        }

        $AllUsersDeployment = $Deployments |
            Where-Object { $_.CollectionName -eq "All Users" }

        $OtherCollections = $Deployments |
            Where-Object { $_.CollectionName -ne "All Users" } |
            Select-Object -ExpandProperty CollectionName -Unique

        [PSCustomObject]@{
            ApplicationName     = $AppName
            DeployedToAllUsers  = if ($AllUsersDeployment) { "Yes" } else { "No" }
            OtherCollections    = if ($OtherCollections) { $OtherCollections -join "; " } else { "" }
            NoDeployment        = "No"
        }
    }
    catch {
        [PSCustomObject]@{
            ApplicationName     = $AppName
            DeployedToAllUsers  = "Error"
            OtherCollections    = ""
            NoDeployment        = "Error"
        }
    }
}

#endregion Processing

#region Export

$Results | Export-Csv -Path $ReportPath -NoTypeInformation -Encoding UTF8
Write-Host "SCCM deployment report generated:" -ForegroundColor Green
Write-Host $ReportPath

#endregion Export