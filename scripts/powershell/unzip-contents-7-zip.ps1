$strFileName = "$envProgramFiles\7-Zip\7z.exe"		
$Arg = "x " + '"' + "$dirFiles\Tc12.0.0.0_wntx64.zip" + '"' + " -o" + '"' + "$envsystemdrive\temp\Teamcenter_12.4\" + '"' + " -y"		
$Arg1 = "x " + '"' + "$dirFiles\Tc12.4.0.0_wntx64.zip" + '"' + " -o" + '"' + "$envsystemdrive\temp\Teamcenter_12.4\" + '"' + " -y"		
		
Start-Process -FilePath $strFileName -ArgumentList $Arg -Wait -WindowStyle Hidden		
Wait-Process -Name 7z		
Start-Process -FilePath $strFileName -ArgumentList $Arg1 -Wait -WindowStyle Hidden		
Wait-Process -Name 7z