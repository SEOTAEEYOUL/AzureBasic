Write-Output "Windwos Time 서비스 중기 후 기동"
Write-Output "stop"
Get-Service -Name W32Time | Stop-Service
Write-Output "."
Get-Service -Name W32Time

Write-Output "start"
Get-Service -Name W32Time | Start-Service
Write-Output "."
Get-Service -Name W32Time
