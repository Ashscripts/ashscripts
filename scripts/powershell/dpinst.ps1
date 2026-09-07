#install
<driverfolder where inf is present>\dpinst.exe /A /Q /SA /SE
Start-Process "$PSScriptRoot\Files\driversinternal\dpinst.exe" -ArgumentList "/A /Q /SA /SE" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue #driver files should be in same folder

#uninstall
Start-Process "$PSScriptRoot\Files\driversinternal\dpinst.exe" -ArgumentList "/Q /D /U `"C:\Windows\System32\DriverStore\FileRepository\vuh.inf_amd64_eea746b107e00bff\vuh.inf`"" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue