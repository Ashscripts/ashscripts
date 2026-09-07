#Folder xcopy:
Start-Process "xcopy.exe" -ArgumentList "`"$($adtSession.DirFiles)\client_specific`" `"$envprogramfiles\Siemens\tc24\portal\plugins\client_specific`" /E /H /Y /I" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue

#File xcopy:
Start-Process "xcopy.exe" -ArgumentList "`"$($adtSession.DirFiles)\client_specific.properties`" `"$envprogramfiles\Siemens\tc24\portal\plugins\configuration\`" /Y" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue