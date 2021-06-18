#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

$Ram = Get-CimInstance -ClassName Win32_PhysicalMemory

foreach ($item in $Ram) {
    Write-Output ""
    Write-Output "Tag: $($Item.Tag)"
    Write-Output "Bank: $($Item.BankLabel)"
    Write-Output "Location: $($Item.DeviceLocator)"
    Write-Output "Capacity: $([math]::Round(($item.Capacity/1gb))) GB"
    Write-Output "Speed: $($Item.ConfiguredClockSpeed) MHz"
}
