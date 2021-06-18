#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

$OS = (Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property *)
$ver = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
$dver = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion
$ubr = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").UBR
$branch = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").BuildBranch
$lab = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").BuildLab
$build = $OS.BuildNumber + "." + $ubr

Write-Output "OS Name : $($OS.Caption)"
if ($null -eq $dver) {
	Write-Output "Version : $ver"
}
else {
	Write-Output "Version : $dver"
}
Write-Output "Build Number : $build"
Write-Output ""
Write-Output "Architecture : $($OS.OSArchitecture)"
Write-Output "Build Branch : $branch"
Write-Output "Build Lab : $lab"
Write-Output ""
Write-Output "Install Date : $($OS.InstallDate)"
Write-Output "Last Bootup : $($OS.Lastbootuptime)"
Write-Output ""
Write-Output "Windows Directory : $($OS.WindowsDirectory)"
Write-Output "System Directory  : $($OS.SystemDirectory)"
Write-Output "Boot Device : $($OS.BootDevice)"
