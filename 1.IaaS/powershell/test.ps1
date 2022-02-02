'ActiveDirectory', 'SQLServer' |
   ForEach-Object {Get-Command -Module $_} |
        Group-Object -Property ModuleName -NoElement |
	         Sort-Object -Property Count -Descending

$ComputerName = 'DC01', 'WEB01'
foreach ($Computer in $ComputerName) {
	  Get-ADComputer -Identity $Computer
}
