$users = Get-ChildItem C:\Users -ErrorAction silentlycontinue
foreach ($user in $users){
$folder = "$($user.fullname)\FCCCache"
   If (Test-Path $folder) {
     Remove-Item $folder -Recurse -Force -ErrorAction silentlycontinue
   }
}