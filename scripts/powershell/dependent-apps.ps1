Import-Module "E:\Program files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager\ConfigurationManager.psd1"

Set-Location "S01:"  # Replace XYZ with your site code (e.g., 'ABC:')
Get-CMApplication | ForEach-Object {
    $app = $_
    $deps = (Get-CMDeploymentType -ApplicationName $app.LocalizedDisplayName | 
             Select-Object -ExpandProperty Dependencies -ErrorAction SilentlyContinue)
    if ($deps.DisplayName -contains "SAPGUI_8.00SP6.1_x86_ENG_001") {
        Write-Output "$($app.LocalizedDisplayName) depends on Test01"
    }
}