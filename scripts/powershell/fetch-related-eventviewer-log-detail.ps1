Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    Id = 1000
} -MaxEvents 20 |
Select-Object TimeCreated, ProviderName, Id, Message |
Format-List