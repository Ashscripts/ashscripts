$paths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

foreach ($path in $paths) {
    Get-ItemProperty $path -ErrorAction SilentlyContinue | Where-Object {
        #$_.DisplayName -like "*Aspen*" -and $_.UninstallString -match "msiexec"
        $_.Publisher -like "*Aspen*" -and $_.UninstallString -match "msiexec"
    } | ForEach-Object {
        $name = $_.DisplayName
        $code = $_.PSChildName
        if ($code -match "^\{.*\}$") {
            $shortName = ($name -replace '\s', '').Substring(0, [Math]::Min(16, ($name -replace '\s', '').Length))
            #Write-Output "Start-ADTMsiProcess -Action 'Uninstall' -ProductCode '$code' -ArgumentList 'MSIRESTARTMANAGERCONTROL=Disable MSIRMSHUTDOWN=2 REBOOT=ReallySuppress MSIDISABLERMRESTART=1 REBOOTPROMPT=S /qn' #$shortName"
            #Write-Output "msiexec /x $code MSIRESTARTMANAGERCONTROL=Disable MSIRMSHUTDOWN=2 REBOOT=ReallySuppress MSIDISABLERMRESTART=1 REBOOTPROMPT=S /qn #$shortName"
            #Write-Output "msiexec /x $code MSIRESTARTMANAGERCONTROL=Disable MSIRMSHUTDOWN=2 REBOOT=ReallySuppress MSIDISABLERMRESTART=1 REBOOTPROMPT=S /qn"
        }
    }
}