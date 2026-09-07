Get-CimInstance Win32_Process |
Where-Object { $_.CommandLine } |
Sort-Object @{Expression={[int64]$_.WorkingSetSize}; Descending=$true} |
Select-Object -First 20 `
    Name,
    @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSetSize / 1MB, 2)}},
    CommandLine