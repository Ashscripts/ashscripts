$SEL = Select-String -Path "C:\Users\A\Desktop\filetoread.txt" -Pattern "<version> 12.0.4 1</version>"
while ($SEL -eq $null) { Start-Sleep 10 }
#operation when found