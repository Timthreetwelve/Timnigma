#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

$SysManaged = (Get-CimInstance Win32_ComputerSystem).AutomaticManagedPagefile
$PFSetting = (Get-CimInstance -ClassName Win32_PageFileSetting | Select-Object -property *)
$InitialGB = [math]::Round(($PFSetting.InitialSize / 1024), 1)
$MaximumGB = [math]::Round(($PFSetting.MaximumSize / 1024), 1)

Write-Output "Filename:  $($PFSetting.Name)"
Write-Output "System Managed:  $SysManaged"
Write-Output "Initial Size:  $InitialGB GB"
Write-Output "Maximum Size:  $MaximumGB GB"