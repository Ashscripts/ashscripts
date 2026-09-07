# Site configuration
$SiteCode = "S01" # Site code 
$ProviderMachineName = "sepcscm008.company.com" # SMS Provider machine name

# Customizations
$initParams = @{}
#$initParams.Add("Verbose", $true) # Uncomment this line to enable verbose logging
#$initParams.Add("ErrorAction", "Stop") # Uncomment this line to stop the script on any errors

# Do not change anything below this line

# Import the ConfigurationManager.psd1 module 
if((Get-Module ConfigurationManager) -eq $null) {
    Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1" @initParams 
}

# Connect to the site's drive if it is not already present
if((Get-PSDrive -Name $SiteCode -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
    New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $ProviderMachineName @initParams
}

# Set the current location to be the site code.
Set-Location "$($SiteCode):\" @initParams


#Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1"

# Connect to site
#Set-Location "ABC:"   # Replace ABC with your Site Code

# Get application and display localized name
<#$app = Get-CMApplication -Name "DosBox_PK1_0.74.0_x86_ENG_001"

[xml]$xml = $app.SDMPackageXML

$xml.AppMgmtDigest.Application.DisplayInfo.Info.Title
$Xml.AppMgmtDigest.Application.DisplayInfo.Info.Publisher
$Xml.AppMgmtDigest.Application.DisplayInfo.Info.Version
$Xml.AppMgmtDigest.Application.Owners.User
#>


$AppList = @(
"DosBox_PK1_0.74.0_x86_ENG_001",
"ArpselinDosBox_PK1_1.0.0_x86_ENG_001",
"HandBrake_PK1_1.1.2_x64_ENG_001")

$Results = foreach ($AppName in $AppList) {

    $App = Get-CMApplication -Name $AppName

    if ($App) {
        [xml]$Xml = $App.SDMPackageXML

        [PSCustomObject]@{
            Application_Name = $App.LocalizedDisplayName
            DisplayName      = $Xml.AppMgmtDigest.Application.DisplayInfo.Info.Title
            Version          = $Xml.AppMgmtDigest.Application.DisplayInfo.Info.Version
            Manufacturer     = $Xml.AppMgmtDigest.Application.DisplayInfo.Info.Publisher
            Owner            = $Xml.AppMgmtDigest.Application.Owners.User.ID
            Description      = $Xml.AppMgmtDigest.Application.DisplayInfo.Info.Description
        }
    }
}

$Results | Export-Csv "C:\Users\shaiadm\Desktop\appdetail_final.csv" -NoTypeInformation