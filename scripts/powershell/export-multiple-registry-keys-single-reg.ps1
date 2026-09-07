# Output reg file
$OutputFile = "C:\Temp\SuwellReader_AllKeys.reg"
# List of registry keys to export
$RegKeys = @(
    "HKLM\SOFTWARE\Classes\Applications\SuwellReader.exe",
    "HKLM\SOFTWARE\Classes\Interface\{3DEB6A7F-6465-14D4-96CB-4347F5444765}",
    "HKLM\SOFTWARE\Classes\Interface\{505CCAC3-5124-481D-B7B4-B040538008F9}",
    "HKLM\SOFTWARE\Classes\TypeLib\{33670D88-9F7E-55C2-F199-2E324916748A}",
    "HKLM\SOFTWARE\Classes\WOW6432Node\CLSID\{C7F277DC-6C47-AB2C-FB6A-070DC8BE7533}",
    "HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{3DEB6A7F-6465-14D4-96CB-4347F5444765}",
    "HKLM\SOFTWARE\Classes\WOW6432Node\Interface\{505CCAC3-5124-481D-B7B4-B040538008F9}",
    "HKLM\SOFTWARE\Classes\WOW6432Node\TypeLib\{33670D88-9F7E-55C2-F199-2E324916748A}",
    "HKLM\SOFTWARE\Classes\.ofd",
    "HKLM\SOFTWARE\Classes\OFD Document",
    "HKLM\SOFTWARE\Classes\suwellofd",
    "HKLM\SOFTWARE\Classes\suwellreaderax.OFDReaderActiveX",
    "HKLM\SOFTWARE\Classes\suwellreaderax.OFDReaderActiveX.1",
    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\SuwellReader.exe",
    "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\App Paths\SuwellReader.exe",
    "HKLM\SOFTWARE\WOW6432Node\MozillaPlugins\@suwell.cn/npSuwellReader",
    "HKLM\SOFTWARE\WOW6432Node\Classes\CLSID\{C7F277DC-6C47-AB2C-FB6A-070DC8BE7533}",
    "HKLM\SOFTWARE\WOW6432Node\Classes\Interface\{3DEB6A7F-6465-14D4-96CB-4347F5444765}",
    "HKLM\SOFTWARE\WOW6432Node\Classes\Interface\{505CCAC3-5124-481D-B7B4-B040538008F9}",
    "HKLM\SOFTWARE\WOW6432Node\Classes\TypeLib\{33670D88-9F7E-55C2-F199-2E324916748A}"
)
# Create temp folder
$TempFolder = "C:\Temp\RegExportTemp"
if (!(Test-Path $TempFolder)) { New-Item -ItemType Directory -Path $TempFolder | Out-Null }
# Create/Reset final output file with .reg header
"Windows Registry Editor Version 5.00`r`n" | Out-File -FilePath $OutputFile -Encoding Unicode
# Export each key
foreach ($Key in $RegKeys) {
    $SafeKeyName = ($Key -replace "[\\:\{\}\/]", "_")
    $TempFile = "$TempFolder\$SafeKeyName.reg"
    Write-Host "Exporting $Key ..."
    # Export registry key
    reg export "$Key" "$TempFile" /y 2>$null
    # Check if export succeeded
    if (Test-Path $TempFile) {
        # Append content to final reg file (skip header)
        (Get-Content $TempFile | Select-Object -Skip 1) |
            Out-File -FilePath $OutputFile -Append -Encoding Unicode
    } else {
        Write-Host "❗ Failed to export: $Key"
    }
}
Write-Host "`n All keys exported to: $OutputFile"
# Cleanup temporary files
Remove-Item $TempFolder -Recurse -Force