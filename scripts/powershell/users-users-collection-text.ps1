# Import SCCM module
Import-Module "E:\Program files\Microsoft Configuration Manager\AdminConsole\bin\ConfigurationManager\ConfigurationManager.psd1"

# Set Site Code
$SiteCode = "S01"   # <-- Change this
Set-Location ($SiteCode + ":")

# Collection Name
$CollectionName = "ALL_CLN_ACCOUNT"   # <-- Change this

# TXT file path (one user per line)
$TxtFilePath = "C:\Users\shaiadm\Desktop\USR.TXT"   # <-- Change this

# Read users from TXT file
$UserList = Get-Content $TxtFilePath

# Get existing members to avoid duplicates
$ExistingMembers = Get-CMUserCollectionMember -CollectionName $CollectionName

foreach ($UserName in $UserList) {

    try {
        # Get SCCM User
        $CMUser = Get-CMUser -Name $UserName

        if ($CMUser) {

            if ($ExistingMembers.ResourceId -contains $CMUser.ResourceId) {
                Write-Host "$UserName already exists in collection" -ForegroundColor Yellow
            }
            else {
                # Add user to collection
                Add-CMUserCollectionDirectMembershipRule `
                    -CollectionName $CollectionName `
                    -ResourceId $CMUser.ResourceId

                Write-Host "Added: $UserName" -ForegroundColor Green
            }
        }
        else {
            Write-Host "User not found in SCCM: $UserName" -ForegroundColor Magenta
        }
    }
    catch {
        Write-Host "Error processing $UserName : $_" -ForegroundColor Red
    }
}

Write-Host "User import completed." -ForegroundColor Cyan