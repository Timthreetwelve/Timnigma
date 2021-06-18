#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------

function NotFoundHelp {
    Write-Output "`nThe HWiNFO registry VSB key was NOT found."
    Write-Output "`nVerify that HWiNFO is indeed running and in HWiNFO Settings do the following:"
    Write-Output "`n  1. Verify that 'Show Sensors on Startup' is checked."
    Write-Output "`n  2. Verify that 'Minimize Sensors instead of closing' is checked."
    Write-Output "`n  3. (Optional) Check 'Minimize sensors on Startup'."
    Write-Output "`n`nIn HWiNFO Sensor Settings:"
    Write-Output "`n  1. Select the HWiNFO Gadget tab."
    Write-Output "`n  2. Verify that 'Enable reporting to Gadget' is checked."
    Write-Output "`n  3. Verify that the desired entries show 'Yes' in the Sidebar column."
    Write-Output "`n  4. Review the instructions here: https://docs.rainmeter.net/tips/hwinfo/.`n`n"
}

function FontNote {
    Write-Output "`nNote that depending on the font used, the degree symbol may not appear correctly."
    Write-Output "This does not indicate a problem with Rainmeter, HWiNFO or this PowerShell script.`n"
}

$hw64 = Test-Path 'HKCU:\Software\HWiNFO64'
$hw32 = Test-Path 'HKCU:\Software\HWiNFO32'

if ($hw64) {
    $vsb = Test-Path 'HKCU:\Software\HWiNFO64\VSB'
    if ($vsb) {
        Write-Output "`nThe HWiNFO64 registry VSB key WAS found.`n"
        $base = [Microsoft.Win32.RegistryKey]::OpenBaseKey('CurrentUser', 256)
        $key = $base.OpenSubKey('Software\HWiNFO64\VSB', $false)
        $names = $key.GetValueNames()
        foreach ($item in $names) {
            if ($item.StartsWith("Color")) {
                Write-Output("")
            }
            else {
                Write-Output("{0,12}:  {1}" -f $item, $key.GetValue($item) )
            }
        }
        FontNote
    }
    else {
        NotFoundHelp
    }
}
elseif ($hw32) {
    $vsb = Test-Path 'HKCU:\Software\HWiNFO32\VSB'
    if ($vsb) {
        Write-Output "`nThe HWiNFO32 registry VSB key WAS found.`n"
        $base = [Microsoft.Win32.RegistryKey]::OpenBaseKey('CurrentUser', 512)
        $key = $base.OpenSubKey('Software\HWiNFO32\VSB', $false)
        $names = $key.GetValueNames()
        foreach ($item in $names) {
            if ($item.StartsWith("Color")) {
                Write-Output("")
            }
            else {
                Write-Output("{0,12}:  {1}" -f $item, $key.GetValue($item) )
            }
        }
        FontNote
    }
    else {
        NotFoundHelp
    }
}
