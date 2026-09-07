$Path = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs"

Get-ChildItem $Path -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object Name, LastWriteTime, FullName