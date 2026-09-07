Copy-ADTFile -Path "$($adtSession.DirFiles)\plugins" -Destination "$envProgramFiles\Bambu Studio\Appdata\" -Recurse -ErrorAction SilentlyContinue
        Copy-ADTFile -Path "$($adtSession.DirFiles)\copyplugin.ps1" -Destination "$envProgramFiles\Bambu Studio\copyplugin.ps1" -ErrorAction SilentlyContinue

        $sact = "`"$envWinDir\System32\WindowsPowerShell\v1.0\powershell.exe`" " + "-ExecutionPolicy Bypass -NoProfile -NonInteractive -WindowStyle Hidden -File `"$envProgramFiles\Bambu Studio\copyplugin.ps1`""

        Set-ADTRegistryKey -LiteralPath 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\BambuStudio_02.03.01.51_x64_ENG_001' -Name 'StubPath'  -Type String -Value $sact
        Set-ADTRegistryKey -LiteralPath 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\BambuStudio_02.03.01.51_x64_ENG_001' -Name 'Version'  -Type String -Value '1,0'