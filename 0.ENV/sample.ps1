echo "스크립트 예제"
echo "..."
echo ""

# Write-Output "PowerShell Version : $PSVersionTable"
# $PSVersionTable

echo "데이터 처리"
(2+2)*3/7 > foo.txt
Get-Content foo.txt
Get-ChildItem | sort -Descending
echo "."
$a = Get-ChildItem | sort -Property length -Descending | Select-Object -First 1 -Property Directory
$a
echo "."
echo "."
echo "."

echo "while"
$i=0
while($i++ -lt 10) { if ($i % 2) { "$i is odd" } else {"$i is even"}}

echo ""
echo "foreach"
foreach ($i in 1..10) { if ($i % 2) {"$i is odd"}}

echo ""
echo "function"
function hello {
  param($name = "bub")
  "Hello $name, how are you"
}
hello
hello Bruce

Write-Output -InputObject "hello"
Write-Output "hello"

ls
dir



echo ""
echo "...."
Invoke-Command ./servie.ps1
