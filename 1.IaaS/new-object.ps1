$SecurePassword = ConvertTo-SecureString "dlatl!00" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential("sysadmin",$SecurePassword); 
$Credential
