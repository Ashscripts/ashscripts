# Enumerate all HKEY_USERS subkeys and delete the specified Active Setup entries

$hkuBasePath = 'Registry::HKEY_USERS'
$componentName = 'IBMiAccessClientSolutions_1.1.7.2_x64_POR_001'

# Get all user hives under HKEY_USERS
$users = Get-ChildItem -Path $hkuBasePath -ErrorAction SilentlyContinue

foreach ($user in $users) {
    $sidPath = $user.PSChildName   # e.g. S-1-5-21-...

    # Paths to delete
    $regPath1 = Join-Path -Path "$hkuBasePath\$sidPath\Software\Microsoft\Active Setup\Installed Components" -ChildPath $componentName -ErrorAction SilentlyContinue
    $regPath2 = Join-Path -Path "$hkuBasePath\$sidPath\Software\WOW6432Node\Microsoft\Active Setup\Installed Components" -ChildPath $componentName -ErrorAction SilentlyContinue

    foreach ($path in @($regPath1, $regPath2)) {
        if (Test-Path -Path $path) {
            try {
                Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
                
            }
            catch {
               
            }
        }
        else {
            
        }
    }
}