Get-CimInstance Win32_Process |
Where-Object {
    $_.CommandLine -and
    $_.WorkingSetSize -gt 100MB
} |
Sort-Object Name |
Select-Object Name, CommandLine,
    @{Name='MemoryMB';Expression={[math]::Round($_.WorkingSetSize / 1MB, 2)}}