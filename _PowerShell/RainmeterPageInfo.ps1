#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------
# Change Log:
#
# July 4th, 2021:  Added additional information. Handle null values when page file is system managed.
#

# From Win32_PageFileUsage
$PFUsage = (Get-CimInstance -ClassName Win32_PageFileUsage | Select-Object -Property *)
$CurrentSize = [math]::Round(($PFUsage.AllocatedBaseSize / 1024), 2)
$CurrentUsage = [math]::Round(($PFUsage.CurrentUsage / 1024), 2)
$PercentUsage = [math]::Round(($PFUsage.CurrentUsage / $PFUsage.AllocatedBaseSize) * 100, 0)
$PeakUsage = [math]::Round(($PFUsage.PeakUsage / 1024), 2)
$PercentPeak = [math]::Round(($PFUsage.PeakUsage / $PFUsage.AllocatedBaseSize) * 100, 0)
$PFName = $PFUsage.Name
$InstallDate = $PFUsage.InstallDate
$TempPage = $PFUsage.TempPageFile
$Status = $PFUsage.Status

# From Win32_PageFileSetting
$PFSetting = (Get-CimInstance -ClassName Win32_PageFileSetting | Select-Object -Property *)
$PFName2 = $PFSetting.Name
$InitialSize = [math]::Round(($PFSetting.InitialSize / 1024), 2)
$MaxSize = [math]::Round(($PFSetting.MaximumSize / 1024), 2)

# From Win32_ComputerSystem
$SysManaged = (Get-CimInstance Win32_ComputerSystem).AutomaticManagedPagefile

# Output for Tooltip
# Note that some values are null if page file size is system managed.
Write-Output "Current Usage:  $CurrentUsage GB ($PercentUsage%)"
Write-Output "Peak Usage:  $PeakUsage GB ($PercentPeak%)"
Write-Output "Current Size:  $CurrentSize GB"
if ($null -ne $InitialSize -and $InitialSize -gt 0) {
    Write-Output "Initial Size:  $InitialSize GB"
}
if ($null -ne $MaxSize -and $MaxSize -gt 0) {
    Write-Output "Max Size:  $MaxSize GB"
}
Write-Output ""
if ($null -ne $Status) {
    Write-Output "Status:  $Status"
}
if ($null -ne $PFName) {
    Write-Output "Filename:  $PFName"
}
elseif ($null -ne $PFName2) {
    Write-Output "Filename:  $PFName2"
}
else {
    Write-Output "Filename:  Unable to determine"
}
if ($null -ne $InstallDate) {
    Write-Output "Created:  $InstallDate"
}
Write-Output "System Managed:  $SysManaged"
Write-Output "Temporary:  $TempPage"
