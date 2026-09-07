$ErrorActionPreference = 'SilentlyContinue'		
		
$folders = @(		
    "C:\Program Files\Siemens\Automation",		
    "C:\Program Files\Common Files\Siemens\TelemetryConnector",		
    "C:\Program Files\Common Files\Siemens\AlmPanelPlugin",		
    "C:\Program Files\Common Files\Siemens\Automation",		
    "C:\Program Files\Common Files\Siemens\CommunicationSettings",		
    "C:\Program Files\Common Files\Siemens\ETWEventCollector",		
    "C:\Program Files\Common Files\Siemens\HmiRTmDriver64",		
    "C:\Program Files\Common Files\Siemens\S7wnsmsx",		
    "C:\Program Files\Common Files\Siemens\SimNetCom",		
    "C:\Program Files\Common Files\Siemens\sws",		
    "C:\Program Files (x86)\Siemens\PLCSIM",		
    "C:\Program Files (x86)\Siemens\Automation",		
    "C:\Program Files (x86)\Common Files\Siemens\SimNetCom",		
    "C:\Program Files (x86)\Common Files\Siemens\sws",		
    "C:\Program Files (x86)\Common Files\Siemens\Automation",		
    "C:\Program Files (x86)\Common Files\Siemens\Bin",		
    "C:\Program Files (x86)\Common Files\Siemens\Compatibility",		
    "C:\Program Files (x86)\Common Files\Siemens\CoRtHmiRTmSim",		
    "C:\Program Files (x86)\Common Files\Siemens\HmiRTmDriver32",		
    "C:\Program Files (x86)\Common Files\Siemens\HmiRTmSim",		
    "C:\Program Files (x86)\Common Files\Siemens\InteropS7cl",		
    "C:\Program Files (x86)\Common Files\Siemens\OPC",		
    "C:\Program Files (x86)\Common Files\Siemens\PTProSave",		
    "C:\Program Files (x86)\Common Files\Siemens\PTSymLib",		
    "C:\Program Files (x86)\Common Files\Siemens\PTTouchInput",		
    "C:\Program Files (x86)\Common Files\Siemens\s7wmedb",		
    "C:\Program Files (x86)\Common Files\Siemens\SeCon",		
    "C:\ProgramData\Siemens\CoRtHmiRTm",		
    "C:\ProgramData\Siemens\UserManagement",		
    "C:\ProgramData\Siemens\Automation",		
    "C:\ProgramData\Siemens\ETWEventCollector",		
    "C:\ProgramData\Siemens\S7-PCT"		
)		
		
		
foreach ($folder in $folders) {		
    $dllFiles = Get-ChildItem -Path $folder -Recurse -Filter "*.dll"		
		
    foreach ($dllFile in $dllFiles) {		
        $dllPath = $dllFile.FullName		
       # Write-Host "Deregistering $dllPath"		
        Start-Process -FilePath "regsvr32.exe" -ArgumentList "/u /s `"$dllPath`"" -Wait -PassThru -WindowStyle hidden -ErrorAction SilentlyContinue		
    }		
}