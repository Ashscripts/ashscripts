function Set-RegistryValueForAllUsers {		
    <#		
    .SYNOPSIS		
        This function uses Active Setup to create a "seeder" key which creates or modifies a user-based registry value		
        for all users on a computer. If the key path doesn't exist to the value, it will automatically create the key and add the value.		
    .EXAMPLE		
        PS> Set-RegistryValueForAllUsers -RegistryInstance @{'Name' = 'Setting'; 'Type' = 'String'; 'Value' = 'someval'; 'Path' = 'SOFTWARE\Microsoft\Windows\Something'}		
        This example would modify the string registry value 'Type' in the path 'SOFTWARE\Microsoft\Windows\Something' to 'someval'		
        for every user registry hive.		
    .PARAMETER RegistryInstance		
         A hash table containing key names of 'Name' designating the registry value name, 'Type' to designate the type		
        of registry value which can be 'String,Binary,Dword,ExpandString or MultiString', 'Value' which is the value itself of the		
        registry value and 'Path' designating the parent registry key the registry value is in.		
    #>		
    [CmdletBinding()]		
    param (		
        [Parameter(Mandatory = $true)]		
        [hashtable[]]$RegistryInstance		
    )		
    try {		
        New-PSDrive -Name HKU -PSProvider Registry -Root Registry::HKEY_USERS | Out-Null -ErrorAction SilentlyContinue		
		
        ## Change the registry values for the currently logged on user. Each logged on user SID is under HKEY_USERS		
        $LoggedOnSids = $(Get-ChildItem HKU: | Where-Object { $_.Name -match 'S-\d-\d+-(\d+-){1,14}\d+$' } | foreach-object { $_.Name })		
       		
        foreach ($sid in $LoggedOnSids) {		
       		
            foreach ($instance in $RegistryInstance) {		
                ## Create the key path if it doesn't exist		
                if (!(Test-Path "HKU:\$sid\$($instance.Path)")) {		
                    New-Item -Path "HKU:\$sid\$($instance.Path | Split-Path -Parent)" -Name ($instance.Path | Split-Path -Leaf) -Force | Out-Null -ErrorAction SilentlyContinue		
                }		
                ## Create (or modify) the value specified in the param		
                Set-ItemProperty -Path "HKU:\$sid\$($instance.Path)" -Name $instance.Name -Value $instance.Value -Type $instance.Type -Force -ErrorAction SilentlyContinue		
            }		
        }		
		
        		
        foreach ($instance in $RegistryInstance) {		
            ## Generate a unique value (usually a GUID) to use for Active Setup		
            $Guid = [guid]::NewGuid().Guid		
            $ActiveSetupRegParentPath = 'HKLM:\Software\Microsoft\Active Setup\Installed Components'		
            ## Create the GUID registry key under the Active Setup key		
            New-Item -Path $ActiveSetupRegParentPath -Name $Guid -Force | Out-Null -ErrorAction SilentlyContinue		
            $ActiveSetupRegPath = "HKLM:\Software\Microsoft\Active Setup\Installed Components\$Guid"		
            		
            switch ($instance.Type) {		
                'String' {		
                    $RegValueType = 'REG_SZ'		
                }		
                'Dword' {		
                    $RegValueType = 'REG_DWORD'		
                }		
                'Binary' {		
                    $RegValueType = 'REG_BINARY'		
                }		
                'ExpandString' {		
                    $RegValueType = 'REG_EXPAND_SZ'		
                }		
                'MultiString' {		
                    $RegValueType = 'REG_MULTI_SZ'		
                }		
                default {		
                    #throw "Registry type '$($instance.Type)' not recognized"		
                }		
            }		
		
            ## Build the registry value to use for Active Setup which is the command to create the registry value in all user hives		
            $ActiveSetupValue = "reg add `"{0}`" /v {1} /t {2} /d {3} /f" -f "HKCU\$($instance.Path)", $instance.Name, $RegValueType, $instance.Value		
           		
            ## Create the necessary Active Setup registry values		
            Set-ItemProperty -Path $ActiveSetupRegPath -Name '(Default)' -Value 'Active Setup Test' -Force -ErrorAction SilentlyContinue		
            Set-ItemProperty -Path $ActiveSetupRegPath -Name 'Version' -Value '1' -Force -ErrorAction SilentlyContinue		
            Set-ItemProperty -Path $ActiveSetupRegPath -Name 'StubPath' -Value $ActiveSetupValue -Force -ErrorAction SilentlyContinue		
        }		
    }		
    catch {		
        		
    }		
}		
		
		
		
Set-RegistryValueForAllUsers -RegistryInstance @{'Name' = 'LandscapeFileOnServer'; 'Type' = 'ExpandString'; 'Value' = '\\Sulshares.company-ext.com\SAPUILandscape.xml'; 'Path' = 'SOFTWARE\SAP\SAPLogon\Options'} -ErrorAction SilentlyContinue