REM for /d %%A in (C:\Users\*) do (			
REM RMDIR /s /q "%%A\AppData\Local\Dassault Systemes\DraftSight")			
			
REM for /d %%A in (C:\Users\*) do (			
REM RMDIR /s /q "%%A\AppData\Roaming\Microsoft\Templates\Normal.dotm")			
			
REM for /d %%A in (C:\Users\*) do IF EXIST %%A\%ULocal%AppData\Roaming\DfSapAddin\dfs_sap.key (			
REM RMDIR /s /q "%%A\AppData\Roaming\DfSapAddin")			
			
for /f "delims=" %%a in ('REG QUERY "HKEY_USERS"') do (			
REG DELETE "%%a\Software\Microsoft\Active Setup\Installed Components\DLLforDraftsight_PK1_1.0.0_x64_ENG_001" /f)