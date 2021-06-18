#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

$OS = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property *
$CS = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property *
$date = $OS.LastBootUpTime.ToLongDateString()
$time = $OS.LastBootUpTime.ToLongTimeString()
$comp = $CS.Name
$bootstate = $CS.BootupState
Write-Output "This computer ($comp)"
Write-Output "was last booted on:"
Write-Output "$date at $time"
Write-Output ""
Write-Output "The bootup state was: $bootstate"
