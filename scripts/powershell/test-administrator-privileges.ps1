$Identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$Principal = New-Object Security.Principal.WindowsPrincipal($Identity)
$Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)