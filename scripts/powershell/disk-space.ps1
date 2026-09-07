if ((Get-WMIObject Win32_Logicaldisk -filter "deviceid='C:'").FreeSpace -lt 25GB)	
{
	#if disk space is less that 25 gb then do this	
}