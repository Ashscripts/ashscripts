$folderPath = "C:\Temp\Target"
while (!(Test-Path $folderPath)) { Start-Sleep -Seconds 5 }