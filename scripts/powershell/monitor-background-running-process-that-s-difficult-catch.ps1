# Duration to monitor (in minutes)
$DurationMinutes = 15
$EndTime = (Get-Date).AddMinutes($DurationMinutes)
Write-Host "Taking snapshot of currently running processes..."
# Get baseline (ignore list)
$baseline = @{}
Get-CimInstance Win32_Process | ForEach-Object {
    $baseline[$_.ProcessId] = $true
}
Write-Host "Baseline captured. Monitoring for $DurationMinutes minutes..."
Write-Host "------------------------------------------"
# Store already reported processes
$reported = @{}
while ((Get-Date) -lt $EndTime) {
    $currentProcesses = Get-CimInstance Win32_Process
    foreach ($proc in $currentProcesses) {
        $procId = $proc.ProcessId   #  renamed variable
        # Skip if already in baseline or already reported
        if ($baseline.ContainsKey($procId) -or $reported.ContainsKey($procId)) {
            continue
        }
        # Mark as reported
        $reported[$procId] = $true
        # Output process details
        [PSCustomObject]@{
            Time        = Get-Date -Format "HH:mm:ss"
            ProcessName = $proc.Name
            PID         = $procId
            CommandLine = $proc.CommandLine
        } | Format-List
    }
    Start-Sleep -Seconds 2
}
Write-Host "------------------------------------------"
Write-Host "Monitoring complete."