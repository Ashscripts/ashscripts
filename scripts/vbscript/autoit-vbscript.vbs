ON ERROR RESUME NEXT	
	
Set fso = CreateObject("Scripting.FileSystemObject")	
Set objShell = WScript.CreateObject("WScript.Shell")	
	
objShell.MinimizeAll	
wscript.sleep 2000	
	
If (fso.FolderExists("C:\ProgramData\replication_finish")) Then	
      fso.DeleteFolder("C:\ProgramData\replication_finish"), True	
End if	
	
objShell.Run "C:\Temp\Repli_src\notice.hta",1, false	
objShell.Run "msiexec /i " & chr(34) & "C:\Temp\Repli_src\Double-Take.msi" & chr(34) & " TRANSFORMS=" & chr (34) & "C:\Temp\Repli_src\1033.MST" & chr(34) & " /L*v " & chr(34) & "C:\WINDOWS\Maintenance\Logs\Applications\CarboniteDoubletakeSOURCE_8.5.3.98_x64_ENG_001.log" & chr(34), True	
	
targetWindowTitle = "Carbonite Replication - InstallShield Wizard"	
	
windowFound = False	
	
Do	
    WScript.Sleep 1000 ' Wait for 1 second before checking again	
	
    ' Check if the window with the specific title exists	
    If objShell.AppActivate(targetWindowTitle) Then	
        windowFound = True	
    End If	
Loop Until windowFound	
	
' Once the window is found, send the Enter key	
objShell.AppActivate targetWindowTitle	
WScript.Sleep 500 ' Delay to ensure the window is in focus	
objShell.SendKeys "{ENTER}"	
wscript.sleep 4000	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
'objShell.SendKeys "{ENTER}"	
'wscript.sleep 2000	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{TAB}"	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
objShell.SendKeys "{ENTER}"	
wscript.sleep 2000	
objShell.SendKeys "{ENTER}"	
	
folderPath_1 = "C:\ProgramData\replication_finish" ' Replace with your desired folder path	
	
Do Until FolderExists(folderPath_1)	
    WScript.Sleep 1000 ' Sleep for 1 second before checking again	
Loop	
	
targetWindowTitle1 = "Carbonite Replication - InstallShield Wizard"	
	
windowFound1 = False	
	
Do	
    WScript.Sleep 1000 ' Wait for 1 second before checking again	
	
    ' Check if the window with the specific title exists	
    If objShell.AppActivate(targetWindowTitle1) Then	
        windowFound1 = True	
    End If	
Loop Until windowFound1	
	
' Once the window is found, send the Enter key	
objShell.AppActivate targetWindowTitle1	
WScript.Sleep 500 ' Delay to ensure the window is in focus	
objShell.SendKeys "{ENTER}"	
	
Function FolderExists(folderPath_1)	
    Set objFSO = CreateObject("Scripting.FileSystemObject")	
    FolderExists = objFSO.FolderExists(folderPath_1)	
    Set objFSO = Nothing	
End Function	
	
Set fso = Nothing	
Set objShell = Nothing