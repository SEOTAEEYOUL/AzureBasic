
Write-Output "."
Write-Output "."
Write-Output "."

# d=pwd
$d=Get-Location
Set-Location "C:\Program Files"
$a1=Get-ChildItem | sort -Property length -Descending | Select-Object -First 1 -Property Directory
$a1

$files=Get-ChildItem
$files

Set-Location "$d"

$a2=Get-ChildItem | sort -Property length -Descending | Select-Object -First 1 -Property Directory
$a2