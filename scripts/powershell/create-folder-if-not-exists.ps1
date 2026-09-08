if (!(Test-Path "C:\YourFolderPath")) 
{ 
New-Item -ItemType Directory -Path "C:\YourFolderPath" -ErrorAction SilentlyContinue 
}