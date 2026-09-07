if(!(Test-Path -Path "$envProgramdata\Microsoft\Windows\Start Menu\Programs\HST TOOLS"))
{
	New-Item -path "$envProgramdata\Microsoft\Windows\Start Menu\Programs\HST TOOLS" -ItemType directory -Force -ErrorAction SilentlyContinue
}