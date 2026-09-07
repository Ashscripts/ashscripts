Start-ADTMsiProcess -Action 'Install' -FilePath 'OnsightConnectEnterprise.msi' -Transforms 'LibrestreamOnsighConnect_11.4.18.55050_x86_ENG_001.mst' -ArgumentList 'SKIP_LICENSING=Y OE_CONFIG_PATH=C:\WINDOWS\TEMP\OeConfig.xml /QN'
#Start-ADTMsiProcess -Action 'Install' -FilePath 'Adobe_FlashPlayer_11.2.202.233_x64_EN.msi'
#Start-ADTMsiProcess -Action 'Patch' -FilePath 'Adobe_Reader_11.0.3_EN.msp'
#Start-ADTMsiProcess -Action 'Uninstall' -ProductCode '{8AF832CF-9D85-4B2E-AA2B-5667F9974909}' -ArgumentList 'MSIRESTARTMANAGERCONTROL=Disable MSIRMSHUTDOWN=2 REBOOT=ReallySuppress MSIDISABLERMRESTART=1 REBOOTPROMPT=S /QN'
#Start-ADTMsiProcess -Action 'Uninstall' -ProductCode '{F205B7B8-8C19-4D18-8302-EE4B3682EDAE}' -ArgumentList '/QN'
#MSIRESTARTMANAGERCONTROL=Disable MSIRMSHUTDOWN=2 REBOOT=ReallySuppress MSIDISABLERMRESTART=1 REBOOTPROMPT=S /qn