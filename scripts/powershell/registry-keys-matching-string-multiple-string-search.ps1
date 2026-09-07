$regparent3  = "HKLM:\Software\company\Packages"
$regparent_3 = "HKLM\Software\company\Packages"

# Regex pattern covers multiple prefixes
$pattern = "^(ABSC|DEFA|DECA)"

Get-ChildItem -Path $regparent3 -ErrorAction SilentlyContinue |
    Where-Object { $_.PSChildName -match $pattern } |
    ForEach-Object {
        $regtodel = "$regparent_3\$($_.PSChildName)"
        Start-Process "reg.exe" -ArgumentList "delete `"$regtodel`" /f" `
                      -Wait -PassThru -WindowStyle Hidden -ErrorAction SilentlyContinue
    }