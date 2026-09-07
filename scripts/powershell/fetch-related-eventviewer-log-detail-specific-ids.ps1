Get-WinEvent -LogName Application -MaxEvents 200 |
Where-Object {$_.Id -in 1000,1001,1026} |
Select-Object TimeCreated,Id,ProviderName,Message |
Format-List