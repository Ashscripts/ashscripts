Start-Process "cmd.exe" -ArgumentList "/C netsh advfirewall firewall add rule name=`"SpaixAwv4`" dir=in program=`"$envProgramFilesx86\company\ABSEL V2 Pump Selection Program\SpaixAw.exe`" remoteip=localsubnet action=allow profile=domain protocol=any" -Wait -PassThru -ErrorAction SilentlyContinue


Firewall rule deletion
Start-Process "cmd.exe" -ArgumentList "/C netsh advfirewall firewall delete rule name=`"ansyscl_str_2025`"" -Wait -PassThru -ErrorAction SilentlyContinue