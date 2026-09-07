$SearchRoot1 = Get-ChildItem -Path "$envProgramFilesX86\Moxa" -ErrorAction SilentlyContinue
If ($SearchRoot1 -eq $null) 	
{ 	
	Remove-Item -Path "$envProgramFilesX86\Moxa" -Force -ErrorAction SilentlyContinue	
}