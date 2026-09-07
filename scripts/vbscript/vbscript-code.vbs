ON ERROR RESUME NEXT			
			
Const ForReading = 1			
Const ForWriting = 2			
			
Set objFSO = CreateObject("Scripting.FileSystemObject")			
Set WshShell = CreateObject("Wscript.Shell")			
usr1 = WshShell.ExpandEnvironmentStrings("%username%")			
userprof = WshShell.ExpandEnvironmentStrings("%userprofile%")			
progx861 = WshShell.ExpandEnvironmentStrings("%programfiles(x86)%")			
roam1 = WshShell.ExpandEnvironmentStrings("%appdata%")			
scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)			
			
WshShell.Run "reg delete " & chr(34) & "HKEY_CURRENT_USER\SOFTWARE\WOW6432Node\Microsoft\Active Setup\Installed Components\PhraseExpress_Uninst" & chr(34) & " /f", 0, True			
WshShell.Run "reg delete " & chr(34) & "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Active Setup\Installed Components\PhraseExpress_Uninst" & chr(34) & " /f", 0, True			
			
If Not objFSO.FolderExists(userprof & "\Documents\PhraseExpress") Then			
objFSO.CreateFolder (userprof & "\Documents\PhraseExpress")			
End If			
			
objFSO.CopyFile progx861 & "\PhraseExpress\ActiveSetup\phrases.pxp", userprof & "\Documents\PhraseExpress\phrases.pxp", True			
objFSO.CopyFile progx861 & "\PhraseExpress\ActiveSetup\words.pal", userprof & "\Documents\PhraseExpress\words.pal", True			
			
If Not objFSO.FolderExists(roam1 & "\PhraseExpress") Then			
objFSO.CreateFolder (roam1 & "\PhraseExpress")			
End If			
			
objFSO.CopyFile progx861 & "\PhraseExpress\ActiveSetup\config.xml", roam1 & "\PhraseExpress\config.xml", True			
			
objFSO.CopyFile progx861 & "\PhraseExpress\ActiveSetup\phraseexpress.lnk", roam1 & "\Microsoft\Windows\Start Menu\Programs\phraseexpress.lnk", True			
			
Set objFile = objFSO.OpenTextFile(roam1 & "\PhraseExpress\config.xml", ForReading)			
strText = objFile.ReadAll			
objFile.Close			
			
strNewText = Replace(strText, "[username1]", usr1)			
Set objFile = objFSO.OpenTextFile(roam1 & "\PhraseExpress\config.xml", ForWriting)			
objFile.WriteLine strNewText			
objFile.Close			
			
set WshShell = Nothing			
Set objFSO = Nothing