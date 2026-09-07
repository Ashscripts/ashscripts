$settingsFile = "$env:AppData\Docker\settings.json"
$settingsFile2 = "$env:AppData\Docker\settings-store.json"

if (!(Test-Path "$env:AppData\Docker"))
{
    New-Item -path "$env:AppData\Docker" -ItemType directory -Force -ErrorAction SilentlyContinue
}

Copy-Item "$env:ProgramFiles\WSL\ACT\settings-store.json" -Destination "$env:AppData\Docker\" -Force -ErrorAction SilentlyContinue
Copy-Item "$env:ProgramFiles\WSL\ACT\settings.json" -Destination "$env:AppData\Docker\" -Force -ErrorAction SilentlyContinue

if (Test-Path $settingsFile)
{
    $content = Get-Content $settingsFile -Raw -ErrorAction SilentlyContinue
    $updatedContent = $content -replace '"WslUpdateRequired"\s*:\s*true', '"WslUpdateRequired": false'
    Set-Content $settingsFile -Value $updatedContent -Encoding utf8NoBOM -Force -ErrorAction SilentlyContinue
}
if (Test-Path $settingsFile2)
{
    $content2 = Get-Content $settingsFile2 -Raw -ErrorAction SilentlyContinue
    $updatedContent2 = $content2 -replace '"WslUpdateRequired"\s*:\s*true', '"WslUpdateRequired": false'
    Set-Content $settingsFile2 -Value $updatedContent2 -Encoding utf8NoBOM -Force -ErrorAction SilentlyContinue
}

#used in docker desktop and working