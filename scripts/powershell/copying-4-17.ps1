Copy-ADTFile -Path 'C:\Path\file.txt' -Destination 'D:\Destination\file.txt' -ErrorAction SilentlyContinue

Copy-ADTFile -Path "$($adtSession.DirFiles)\CefLibZip\*" -Destination "$envlocalappdata\Programs\Tagetik Excel .NET Client" -Recurse