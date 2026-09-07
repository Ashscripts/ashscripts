$Drive = Get-PSDrive -Name C

[PSCustomObject]@{
    FreeGB  = [math]::Round($Drive.Free / 1GB, 2)
    TotalGB = [math]::Round(($Drive.Used + $Drive.Free) / 1GB, 2)
}