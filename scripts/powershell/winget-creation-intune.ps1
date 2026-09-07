#installation command to be included into install.ps1

Winget Install GitHub.Copilot --silent --accept-source-agreements --accept-package-agreements

#uninstallation command to be included into uninstall.ps1

winget uninstall --id Microsoft.VCLibs.Desktop.14 -e --silent --all-versions
exit 0

#detection custom powershell script

$InstallCheck = winget list --id GitHub.Copilot --exact --accept-source-agreements
    if ($InstallCheck -like "*GitHub.Copilot*") {
Write-output "Installed"  
          Exit 0
    }
Clear-Host  
  Exit 0


#install command line reference for intune / sccm

powershell.exe -ExecutionPolicy Bypass -NonInteractive -WindowStyle Hidden -File install.ps1/uninstall.ps1