<# LOG FILE LOCATION "c:\Temp\ClientCleanup.log"
#>

$ErrorActionPreference = 'SilentlyContinue'

New-Item -ItemType Directory -Force -Path "C:\Temp"
New-Item -ItemType "file" -Path "c:\Temp\ClientCleanup.log"

#TIMESTAMP FUNCTION FOR LOGGING
function Get-TimeStamp {
    
    return "[{0:MM/dd/yy} {0:hh:mm}]" -f (Get-Date)
    
}
#TIMESTAMP FUNCTION ENDS HERE......

#SMSAGENT HOST CLEANUP
Start-Sleep -s 10
Stop-Service ccmexec -Force
Stop-Service ccmsetup -Force
$service = Get-WmiObject -Class Win32_Service -Filter "Name='ccmexec'"
Start-Sleep -s 5
$service.delete()
$arrService_1 = Get-Service -Name "ccmexec"
if ($arrService_1.Status -ne 'Running')
{
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) 
::::::::::::::::::::::::::::::::::::::::::::STARTING THE SCRIPT EXECUTION::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) SMS Agent Host was Deleted Successfully."
}

#SMSAGENT HOST IS IN KILLED........

#REMOVING MIF AND SMSCFG FILES
Start-Sleep -s 10
Remove-Item –path "C:\Windows\SMSCFG.INI"
Get-ChildItem -path "C:\Windows\*.mif" | Remove-Item -Force
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) .MIF and SMSCFG.ini removed"
#REMOVED MIF AND SMSCFG FILES............

#TASK SCHEDULE KILLER
if ($(Get-ScheduledTask -TaskPath '\Microsoft\Configuration Manager\' -TaskName "Configuration Manager Health Evaluation" -ErrorAction SilentlyContinue).TaskName -eq "Configuration Manager Health Evaluation")
 {
    Unregister-ScheduledTask -TaskPath '\Microsoft\Configuration Manager\' -TaskName "Configuration Manager Health Evaluation" -Confirm:$False
}

if ($(Get-ScheduledTask -TaskPath '\Microsoft\Configuration Manager\' -TaskName "Configuration Manager Idle Detection" -ErrorAction SilentlyContinue).TaskName -eq "Configuration Manager Idle Detection")
 {
    Unregister-ScheduledTask -TaskPath '\Microsoft\Configuration Manager\' -TaskName "Configuration Manager Idle Detection" -Confirm:$False
}

if ($(Get-ScheduledTask -TaskPath '\Microsoft\Configuration Manager\' -TaskName "Configuration Manager Passport for Work Certificate Enrollment Task" -ErrorAction SilentlyContinue).TaskName -eq "Configuration Manager Passport for Work Certificate Enrollment Task")
 {
    Unregister-ScheduledTask -TaskPath '\Microsoft\Configuration Manager\' -TaskName "Configuration Manager Passport for Work Certificate Enrollment Task" -Confirm:$False
}
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) ConfigMgr Task Schedules Un-Registered."
#TASK SCHEDULE KILLED SUCCESSFULLY..........

#GARBAGE REGISTRY CLEANER
$regkeypath1= "hklm:\SOFTWARE\ConfigMgrStartup"
$regkeypath2= "hklm:\SOFTWARE\Microsoft\CCM"
$regkeypath3= "hklm:\SOFTWARE\Microsoft\CCMSetup"
$regkeypath4= "hklm:\SOFTWARE\WOW6432Node\Microsoft\CCM"
$regkeypath5= "hklm:\SOFTWARE\Microsoft\SMS"
$regkeypath6= "hklm:\SOFTWARE\WOW6432Node\Microsoft\SMS"
$value1 = (Get-ItemProperty $regkeypath).test -eq $null
$value2 = (Get-ItemProperty $regkeypath).test -eq $null
$value3 = (Get-ItemProperty $regkeypath).test -eq $null
$value4 = (Get-ItemProperty $regkeypath).test -eq $null
$value5 = (Get-ItemProperty $regkeypath).test -eq $null
$value6 = (Get-ItemProperty $regkeypath).test -eq $null
If ($value1 -eq $False) {Remove-ItemProperty -path $regkeypath1 -Force}
If ($value2 -eq $False) {Remove-ItemProperty -path $regkeypath2 -Force}
If ($value3 -eq $False) {Remove-ItemProperty - path $regkeypath3 -Force}
If ($value4 -eq $False) {Remove-ItemProperty -path $regkeypath4 -Force}
If ($value5 -eq $False) {Remove-ItemProperty -path $regkeypath5 -Force}
If ($value6 -eq $False) {Remove-ItemProperty -path $regkeypath6 -Force}
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) SCCM Client related Garbage Registries cleaned up."
#GARBAGE REGISTRY CLEANED..........

#GARBAGE FOLDER REMOVER
Remove-Item "C:\Windows\CCM" -Force -Recurse
Remove-Item "C:\Windows\ccmcache" -Force -Recurse
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) CCM and ccmcache folder deletion initiated."
#GARBAGE FOLDER REMOVED..........

#CLEANING UP CLIENT RELATED CERTIFICATES
$smscert = "hklm:\SOFTWARE\Microsoft\SystemCertificates\SMS"
$smscert64 = "hklm:\SOFTWARE\WOW6432Node\Microsoft\SystemCertificates\SMS"
$smsval = (Get-ItemProperty $smscert).test -eq $null
$smsvall = (Get-ItemProperty $smscert64).test -eq $null
If ($smsval -eq $False) {Remove-ItemProperty -path $smscert -Force}
If ($smsvall -eq $False) {Remove-ItemProperty -path $smscert64 -Force}
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) SCCM Client Certificated Deleted."
#CLIENT RELATED CERTIFICATES REMOVED..........

#CLIENT WMI CLEANUP
Start-Sleep -s 5
$wmi_check = 'winmgmt'
$arrService = Get-Service -Name $wmi_check
if ($arrService.Status -eq 'Running')
{
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) WMI Service is in good state, initiating CCM and SMS Namespace deletion."
$computer_name = $env:computername
Invoke-Command -ComputerName $computer_name {Get-WmiObject -query "Select * From __Namespace Where Name='CCM'" -Namespace "root" | Remove-WmiObject}
Invoke-Command -ComputerName $computer_name {Get-WmiObject -query "Select * From __Namespace Where Name='SMS'" -Namespace "root\cimv2" | Remove-WmiObject}
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) CCM and SMS Namespace Deleted Successfully."
}
if ($arrService.Status -ne 'Running')
{
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) WMI Service is not active, Starting the service."
Start-Service winmgmt -Force
$computer_name = $env:computername
Invoke-Command -ComputerName $computer_name {Get-WmiObject -query "Select * From __Namespace Where Name='CCM'" -Namespace "root" | Remove-WmiObject}
Invoke-Command -ComputerName $computer_name {Get-WmiObject -query "Select * From __Namespace Where Name='SMS'" -Namespace "root\cimv2" | Remove-WmiObject}
}
#WMI CLEANUP DONE..........

#LOGGING THE STATUS
Start-Sleep -s 7
if ($arrService.Status -ne 'Running')
{
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) The winmgmt service cannot be started."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) Either access denied. or some other application is blocking/preventing it to get started."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) Script will be Aborted."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) Finished with Error!"
exit
}
else
{
if (Test-Path "${env:systemdrive}\Windows\ccmsetup\ccmsetup.exe")
{
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) Client has the ccmsetup sources, will use the same for installation."
Start-Process "${env:systemdrive}\Windows\ccmsetup\ccmsetup.exe" -ArgumentList "/mp:SEPCSCM008.company.com SMSSITECODE=S01" -Wait -PassThru
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) The installation of sccm client was initiated."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) Please check in C:\Windows\ccmsetup.log to check the installation progress."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) If success code is 7, the SCCM Client has been installed but reboot is required."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) If success code is 0, the Client has been installed, reboot is not required."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) If still the installation issue occurs, WMI needs to be repaired or Firewall Confliction."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) For Windows 10, Firewall Service (in services.msc) needs to be started."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) The Log Completed Here...."
exit
}
else
{
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) Client does not have the ccmsetup sources."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) Please copy it from compliant machine under C:\Windows\ folder and re-run the script."
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) At the moment, Script Aborts Here and Installation Skipped...."
}
}
Add-Content "c:\Temp\ClientCleanup.log" "$(Get-TimeStamp) ::::::::::::::::::::::::::::::::::::::::::::SCRIPT COMPLETED::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
#SCRIPT ENDS HERE........