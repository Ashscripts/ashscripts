$registryKeys = @(
        "HKLM:\SOFTWARE\Classes\.py",
        "HKLM:\SOFTWARE\Classes\.pyc",
        "HKLM:\SOFTWARE\Classes\.pyd",
        "HKLM:\SOFTWARE\Classes\.pyo",
        "HKLM:\SOFTWARE\Classes\.pyw",
        "HKLM:\SOFTWARE\Classes\.pyz",
        "HKLM:\SOFTWARE\Classes\.pyzw",
        "HKLM:\SOFTWARE\Classes\Python.ArchiveFile",
        "HKLM:\SOFTWARE\Classes\Python.CompiledFile",
        "HKLM:\SOFTWARE\Classes\Python.Extension",
        "HKLM:\SOFTWARE\Classes\Python.File",
        "HKLM:\SOFTWARE\Classes\Python.NoConArchiveFile",
        "HKLM:\SOFTWARE\Classes\Python.NoConFile",    
        "HKLM:\SOFTWARE\WOW6432Node\Python",
        "HKLM:\SOFTWARE\Python"
        )

        foreach ($key in $registryKeys) {
            if (Test-Path $key) {
                Remove-Item -Path $key -Recurse -Force -ErrorAction SilentlyContinue
            }
        }


                $RegistryPaths = @(
            "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
            "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
        )

        foreach ($Path in $RegistryPaths) {

            if (Test-Path $Path) {

               $Apps = Get-ChildItem -Path $Path -ErrorAction SilentlyContinue

                foreach ($App in $Apps) {

                    $Props = Get-ItemProperty -Path $App.PSPath -ErrorAction SilentlyContinue

                    # Check for Publisher string match
                    if ($Props.Publisher -like "*Python*") {

                        $KeyName = $App.PSChildName
                        $FullPath = Join-Path -Path $Path -ChildPath $KeyName -ErrorAction SilentlyContinue
                        Remove-Item -Path $FullPath -Recurse -Force -ErrorAction SilentlyContinue
                    }
                }
            }
        }