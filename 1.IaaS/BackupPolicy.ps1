$SchPol = Get-AzRecoveryServicesBackupSchedulePolicyObject -WorkloadType "AzureVM" 
$SchPol.ScheduleRunTimes.Clear()
$Time = Get-Date
$Time1 = Get-Date -Year $Time.Year -Month $Time.Month -Day $Time.Day -Hour $Time.Hour -Minute 0 -Second 0 -Millisecond 0
$Time1 = $Time1.ToUniversalTime()
$SchPol.ScheduleRunTimes.Add($Time1)
$SchPol.ScheduleRunFrequency.Clear
$SchPol.ScheduleRunDays.Add("Monday")
$SchPol.ScheduleRunFrequency="Weekly"
$RetPol = Get-AzRecoveryServicesBackupRetentionPolicyObject -WorkloadType "AzureVM" 
$RetPol.IsDailyScheduleEnabled=$false
$RetPol.DailySchedule.DurationCountInDays = 0
$RetPol.IsWeeklyScheduleEnabled=$true 
$RetPol.WeeklySchedule.DaysOfTheWeek.Add("Monday")
$RetPol.WeeklySchedule.DurationCountInWeeks = 365
$vault = Get-AzRecoveryServicesVault -ResourceGroupName "azurefiles" -Name "azurefilesvault"
$Pol= Get-AzRecoveryServicesBackupProtectionPolicy -Name "TestPolicy" -VaultId $vault.ID
$Pol.SnapshotRetentionInDays=5
Set-AzRecoveryServicesBackupProtectionPolicy -Policy $Pol -SchedulePolicy $SchPol -RetentionPolicy $RetPol