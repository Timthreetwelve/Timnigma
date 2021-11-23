#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------
function Update {
    return
}

function Report {
    # Path to temp file
    $tempfile = Join-Path $env:TEMP BattReport.html

    # Delete file if it exists
    if (Test-Path -Path $tempfile) {
        Remove-Item -Path $tempfile -Force
    }

    # Generate report
    powercfg /batteryreport /output $tempfile

    # Delay just a bit
    Start-Sleep -Milliseconds 250

    # Open report in default browser
    try {
        Start-Process $tempfile -ErrorAction SilentlyContinue
    }
    catch {
        $RmAPI.LogError($PSItem.Exception.Message)
    }
}
