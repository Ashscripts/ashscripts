#Installation:
Start-Process "sdbinst.exe" -ArgumentList "-q `"$PSScriptRoot\Files\Anysys_ACT.sdb`"" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue

#Uninstallation:
Start-Process "sdbinst.exe" -ArgumentList "-u `"$PSScriptRoot\Files\Anysys_ACT.sdb`"" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue