#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

param (
    [Parameter()] [String] $DevID
)

if (-not $DevID) {
    $DevID = 0
}

$PDisk = Get-PhysicalDisk | Where-Object { $_.DeviceID -eq $DevID }
$Disk = Get-Disk | Where-Object { $_.Number -eq $DevID }

if ($null -ne $PDisk) {
    Write-Output "`nDevice ID:  $($PDisk.DeviceID)"
    Write-Output "Size:  $([Math]::Round($PDisk.Size / 1GB, 2).ToString()) GB"
    Write-Output "Media Type:  $($PDisk.MediaType)"
    Write-Output "Health:  $($PDisk.HealthStatus)"
    Write-Output "Bus Type:  $($PDisk.BusType)"
}

if ($null -ne $Disk) {
    Write-Output "Status:  $($Disk.OperationalStatus)"
    Write-Output "Logical Sector Size:  $($Disk.LogicalSectorSize)"
    Write-Output "Physical Sector Size:  $($Disk.PhysicalSectorSize)"
    Write-Output "Number of Partitions:  $($Disk.NumberOfPartitions)"
    Write-Output "Partition Style:  $($Disk.PartitionStyle)"
    if ($Disk.IsSystem) {
        Write-Output "System Drive:  $($Disk.IsSystem)"
    }
    if ($Disk.IsBoot) {
        Write-Output "Boot Drive:  $($Disk.IsBoot)"
    }
    Write-Output "Friendly Name:  $($Disk.FriendlyName)"
}

if ($null -eq $PDisk -and $null -eq $Disk) {
    Write-Output "`n Device $DevId was not found"
}