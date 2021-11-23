#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
# The $RmAPI statements require the PowershellRM plugin.
#---------------------------------------------------------------
# Change Log:
#
# July 5th, 2021:    Added additional information.
#                    Handle null values when page file is system managed.
#
# October 18, 2021:  Added $Long parameter.
#
# October 30, 2021:  Converted for use with PowershellRM
#

function Update {
    # Get the LongInfo variable from the skin
    $Long = $RmAPI.Variable("LongInfo", 0)

    # From Win32_PageFileUsage
    $PFUsage = (Get-CimInstance -ClassName Win32_PageFileUsage | Select-Object -Property *)
    $CurrentSize = [math]::Round(($PFUsage.AllocatedBaseSize / 1024), 2).ToString('N2')
    $CurrentUsage = [math]::Round(($PFUsage.CurrentUsage / 1024), 2).ToString('N2')
    $PercentUsage = [math]::Round(($PFUsage.CurrentUsage / $PFUsage.AllocatedBaseSize) * 100, 1).ToString('N1')
    $PeakUsage = [math]::Round(($PFUsage.PeakUsage / 1024), 2).ToString('N2')
    $PercentPeak = [math]::Round(($PFUsage.PeakUsage / $PFUsage.AllocatedBaseSize) * 100, 1).ToString('N1')
    $PFName = $PFUsage.Name
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

    # New StringBuilder object
    $sb = New-Object -TypeName "System.Text.StringBuilder";

    $sb.AppendLine("Current Size:  $CurrentSize GB")
    $sb.AppendLine("Current Usage:  $CurrentUsage GB  ($PercentUsage%)")
    $sb.AppendLine("Peak Usage:  $PeakUsage GB  ($PercentPeak%)")
    if ($Long -eq 1) {

        if ($null -ne $InitialSize -and $InitialSize -gt 0) {
            $sb.AppendLine("Initial Size:  $InitialSize GB")
        }
        if ($null -ne $MaxSize -and $MaxSize -gt 0) {
            $sb.AppendLine("Max Size:  $MaxSize GB")
        }
        $sb.AppendLine("")
        if ($null -ne $Status) {
            $sb.AppendLine("Status:  $Status")
        }
        if ($null -ne $PFName) {
            $sb.AppendLine("Filename:  $PFName")
        }
        elseif ($null -ne $PFName2) {
            $sb.AppendLine("Filename:  $PFName2")
        }
        else {
            $sb.AppendLine("Filename:  Unable to determine")
        }
        $sb.AppendLine("System Managed:  $SysManaged")
        $sb.AppendLine("Temporary:  $TempPage")
    }

    $Global:stuff = $sb.ToString()
}
