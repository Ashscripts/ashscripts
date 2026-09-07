ON ERROR RESUME NEXT			
			
Set WshShell = WScript.CreateObject("WScript.Shell")			
RegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager"			
RegValue = "PendingFileRenameOperations"			
			
Do			
    ' Check if the registry value exists			
    If WshShell.RegRead(RegKey & "\" & RegValue) <> "" Then			
        ' Delete the registry value			
        WshShell.RegDelete RegKey & "\" & RegValue			
        WScript.Echo "Deleted " & RegKey & "\" & RegValue			
    End If			
    WScript.Sleep 1000 ' Sleep for 1 second			
Loop			
Set WshShell = Nothing