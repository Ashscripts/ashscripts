if ((Get-ADTPendingReboot).IsSystemRebootPending)
     {
         Show-ADTInstallationPrompt -Message 'You have a pending reboot on your machine, please restart the machine and restart the installation!' -ButtonLeftText 'OK' -Icon Error -NoWait
     }