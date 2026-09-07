$dir="C:\windows\ccmcache\"		
$exclude=@("skpswi.dat")		
$Foldercount=0		
$Filecount=0		
$size="{0:N2} GB" -f ((Get-ChildItem $dir -Recurse -force | where-object { $_.FullName -inotmatch  $exclude }|  Measure-Object -Property Length -Sum ).Sum / 1Gb) 		
Write-host $size		
$Foldercount=Get-ChildItem $dir -force| where {  $_.PSIsContainer -and $_.FullName -inotmatch  $exclude}|  Measure-Object | %{$_.Count}		
Write-host $Foldercount		
$Filecount=Get-ChildItem $dir -Force -Recurse| where { ! $_.PSIsContainer -and $_.FullName -inotmatch  $exclude}|  Measure-Object | %{$_.Count}		
Write-host $Filecount