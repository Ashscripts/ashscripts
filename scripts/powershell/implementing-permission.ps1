Start-Process "cmd.exe" -ArgumentList "/C cacls `"$envprogramfiles\KiCad\10.0`" /t /c /e /p Users:F" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue

#cmd.exe /C cacls $envProgramFilesX86\SuoYuan /t /c /e /p Users:F