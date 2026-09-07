$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{A3B2FFEE-2245-47AB-967C-DB473C4DE3D1}"
$display_Version = Get-ItemProperty -Path $regPath -Name "DisplayVersion" -ErrorAction SilentlyContinue

If ($display_Version.DisplayVersion -eq "24.06.8300.00006")
{
	#perform operation
}