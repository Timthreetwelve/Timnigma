#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

param (
    [Parameter()]
    [String]
    $DevID = '0'
)

$dev = Get-PhysicalDisk | Where-Object { $_.DeviceID -eq $DevID }

Write-Output "`nDevice ID: $($dev.DeviceID)"
Write-Output "Size: $([Math]::Round($dev.Size / 1GB, 2).ToString()) GB"
Write-Output "Status: $($dev.OperationalStatus)"
Write-Output "Health: $($dev.HealthStatus)"
Write-Output "Media Type: $($dev.MediaType)"
Write-Output "Bus Type: $($dev.BusType)"
