#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

$rminfo = [System.Diagnostics.FileVersionInfo]::GetVersionInfo('C:\Program Files\Rainmeter\Rainmeter.exe')

Write-Output ""
Write-Output "Rainmeter Version: $($rminfo.ProductVersion)"
