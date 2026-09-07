Get-CimInstance Win32_Process |
Where-Object { $_.CommandLine } |
Sort-Object Name |
Format-Table Name, CommandLine -AutoSize -Wrap

#Select-Object Name, CommandLine | Export-Csv "C:\Temp\RunningProcesses.csv" -NoTypeInformation