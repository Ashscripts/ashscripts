$pkg = Get-AppxProvisionedPackage -Online | Where-Object {
    $_.DisplayName -like "*LenovoSettingsforEnterprise*" -and $_.Version -eq "20.2511.24.0"
}

if ($pkg) 
{