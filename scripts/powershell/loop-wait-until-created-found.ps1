$folderPath = "C:\temp\New folder\a"  # Replace with the actual folder path

while (!(Test-Path $folderPath)) {
    Start-Sleep -Seconds 5  # Check for the folder every 5 seconds
}
#operation