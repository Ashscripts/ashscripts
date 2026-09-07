$uninstallPaths = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

foreach ($path in $uninstallPaths) {
    Get-ItemProperty $path | Where-Object {
        $_.DisplayName -like "*Aspen*" -and $_.PSObject.Properties.Name -contains "UninstallString"
    } | ForEach-Object {
        $productName = $_.DisplayName
        $uninstallString = $_.UninstallString

        # Extract product code if uninstall string contains it
        if ($uninstallString -match "\{[0-9A-Fa-f\-]{36}\}") {
            $productCode = $Matches[0]
            Write-Output "msiexec /x $productCode #$productName"
        }
    }
}