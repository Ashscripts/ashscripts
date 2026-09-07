# Import the ConfigMgr module
Import-Module "E:\Program files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager\ConfigurationManager.psd1"

# Set your site code and connect
$SiteCode = "S01"   # <-- Replace with your SCCM Site Code
Set-Location "$SiteCode`:"

# Provide the collection name
$CollectionName = "Aspenv15_Installed_Devices"   # <-- Replace with your collection name

# Path to the text file containing device names
$DeviceList = "C:\Users\shaiadm\Desktop\dev.txt"

# Read devices
$Devices = Get-Content -Path $DeviceList

foreach ($Device in $Devices) {
    Write-Host "Processing device: $Device" -ForegroundColor Cyan

    # Get device info from SCCM
    $CMDevice = Get-CMDevice -Name $Device

    if ($CMDevice) {
        # Add device to the collection
        Add-CMDeviceCollectionDirectMembershipRule `
            -CollectionName $CollectionName `
            -ResourceId $CMDevice.ResourceID

        Write-Host "Added: $Device" -ForegroundColor Green
    }
    else {
        Write-Host "Device not found in SCCM: $Device" -ForegroundColor Yellow
    }
}

Write-Host "---- Completed ----" -ForegroundColor Magenta