$ShortcutSource1 = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Dassault Systemes\DraftSight 2019 x64.lnk"
    $ShortcutName1   = "DraftSight 2019 x64.lnk"

    # Get all user profiles except system ones
    $UserProfiles1 = Get-ChildItem "C:\Users" -ErrorAction SilentlyContinue | Where-Object {
        $_.PSIsContainer -and
        $_.Name -notin @("Default", "Default User", "Public", "All Users", "defaultuser0")
    }

    foreach ($Profile1 in $UserProfiles1) 
    {
        $TaskbarPath1 = Join-Path $Profile1.FullName "AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
        $PinnedShortcut1 = Join-Path $TaskbarPath1 $ShortcutName1
        if (Test-Path $PinnedShortcut1) 
        {
            Remove-Item $PinnedShortcut1 -Force -ErrorAction SilentlyContinue            
        }
    }