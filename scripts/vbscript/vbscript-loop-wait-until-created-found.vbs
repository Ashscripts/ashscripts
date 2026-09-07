ON ERROR RESUME NEXT		
		
Set fso = CreateObject("Scripting.FileSystemObject")		
		
' Specify the folder to monitor and the filename to search for		
folder = "C:\temp\New folder" ' Replace with the actual folder path		
searchFile = "file.txt" ' Replace with the actual filename		
		
Do While True		
    ' Check if the file exists		
    If fso.FileExists(folder & "\" & searchFile) Then		
        ' File found! Perform actions here		
        MsgBox "File found: " & folder & "\" & searchFile		
        Exit Do ' Exit the loop		
    End If		
		
    ' File not found, wait for a specified interval		
    WScript.Sleep 5000 ' Wait for 5 seconds (adjust as needed)		
Loop