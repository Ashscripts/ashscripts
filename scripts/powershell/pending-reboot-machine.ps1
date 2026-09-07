$pend = $false
 if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA SilentlyContinue) { $pend = $true }
     if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA SilentlyContinue) { $pend = $true }

If ($pend -eq $true)
{
	$UserResponse1 = Show-InstallationPrompt -Title 'Pending Restart' -Message 'Package has detected a pending restart. Please reboot the system and rerun the installation.' -ButtonRight 'Restart Now' -ButtonLeft 'Restart Later'       
	    If($UserResponse1 -eq 'Restart Now'){Execute-Process -Path "$dirSupportFiles\Restart.exe" -WindowStyle Hidden -NoWait}
	            Exit-Script -ExitCode 1603
}