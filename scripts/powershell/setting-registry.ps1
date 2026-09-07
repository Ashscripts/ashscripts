$regpath32 = "HKLM:\Software\Wow6432Node\company\Packages"
new-item -path $regpath32 -force -ErrorAction SilentlyContinue
Set-ItemProperty -force -path $regpath32 -name "Vendor" -value $adtSession.AppVendor -ErrorAction SilentlyContinue