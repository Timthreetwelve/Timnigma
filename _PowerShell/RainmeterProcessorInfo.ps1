#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

$procs = Get-CimInstance -ClassName Win32_Processor

foreach ($proc in $procs) {
    Write-Output "CPU ID:  $($proc.DeviceID)"
    Write-Output "Architecture:  $($proc.AddressWidth) bit"
    Write-Output "Number of Cores:  $($proc.NumberOfCores)"
    Write-Output "Logical Processors:  $($proc.NumberOfLogicalProcessors)"
    Write-Output ""
    Write-Output "$($proc.Name)"
    Write-Output "$($proc.Caption)"
    Write-Output "Manufacturer:  $($proc.Manufacturer)"
}
