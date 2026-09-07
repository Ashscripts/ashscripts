ON ERROR RESUME NEXT
Set wiInstaller = CreateObject("WindowsInstaller.Installer")
wiInstaller.AddSource "{448FDA57-C414-429F-8B6E-FCF4E09DAFEB}", "", "C:\Windows\Temp\SetupHydraulicDLLfix"
wiInstaller.AddSource "{448FDA57-C414-429F-8B6E-FCF4E09DAFEB}", "", "C:\Windows\Temp\SetupHydraulicDLLfix"
wiInstaller.ForceSourceListResolution "{448FDA57-C414-429F-8B6E-FCF4E09DAFEB}", ""