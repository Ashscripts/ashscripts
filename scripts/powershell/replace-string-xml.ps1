$xmlFile = "C:\path\to\file.xml"	
$searchString = "[USERNAME_C]"	
$replaceString = "new string"	
	
[xml]$xml = Get-Content $xmlFile	
$xml.SelectNodes("//*[text()='$searchString']") | 	
    ForEach-Object { $_.InnerXml = $replaceString }	
$xml.Save($xmlFile)