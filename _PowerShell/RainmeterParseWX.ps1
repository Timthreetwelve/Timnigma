#---------------------------------------------------------------
# This script is used by the Rainmeter Timnigma suite of skins.
# It must be located in the Timnigma\_PowerShell folder.
#---------------------------------------------------------------
# Any variable passed back to the skin must be $Global.
# The $RmAPI statements require the PowershellRM plugin.
#---------------------------------------------------------------
# Change Log:
#
# July 1st, 2021:  Added dew point.
#
Function Parse {
    # Zip code
    $zip = $RmAPI.VariableStr("WxLocation", "unknown")

    # Heartbeat
    $hb = $RmAPI.VariableStr("Heartbeat", "N").ToUpper().Substring(0, 1)
    if ($hb -eq "Y") {
        $RmAPI.Log("WX heartbeat $zip")
    }

    # Constants
    $jsonFile = Join-Path $env:TEMP "rainmeter.wx.$zip.json"
    $logfile = Join-Path $env:TEMP "rainmeter.wx.$zip.log"
    $deg = [Char]0x00B0
    $tempSuffix = $deg + "F"

    # Read the data from the GetWeatherData measure .
    # If it is empty return "Empty" and write a warning message
    $in = $RmAPI.MeasureStr("GetWeatherData", "Empty")
    if ($in -eq "Empty") {
        $RmAPI.LogWarning("Input was empty")
        return "Empty"
    }

    # Format the JSON and write it to a file in the temp directory
    try {
        $json = Format-Json -json $in
        Set-Content -Path $jsonFile -Value $json
    }
    catch {
        $RmAPI.LogError("Error formatting or writing weather data. Is it formatted as JSON?")
    }

    # Read the weather data
    try {
        $WxData = Get-Content -Path $jsonFile | ConvertFrom-Json
    }
    catch {
        $RmAPI.LogError("Error reading weather data. Is it formatted as JSON?")
    }

    # Check for error message
    if ($null -ne $WxData.message) {
        $RmAPI.LogWarning("Error message received from OpenWeatherMap.org")
        $Global:Details = $WxData.message
        $Global:City = "Error"
        return
    }

    # City
    $Global:City = $WXData.name

    # Temperature
    $Global:Temp = [Math]::Round($WXData.main.temp, 0)

    # Feels like
    $feelsLike = [Math]::Round($WXData.main.feels_like, 0)

    # Humidity
    $humidity = $WXData.main.humidity

    # Dew Point
    $dewPoint = ConvertTo-DewPoint -tempF $WxData.main.temp -humid $WxData.main.humidity

    # Barometric pressure
    $pressure = $WXData.main.pressure
    # Convert pressure to inches of mercury
    $pressure = [Math]::Round(($pressure / 33.86), 2)
    $pressureSuffix = "inHg"

    # Wind
    $windSpeed = [Math]::Round($WXData.wind.speed, 0)
    $windGust = [Math]::Round($WXData.wind.gust, 0)
    $windDirDeg = $WXData.wind.deg
    $windDirTxt = Convert-DegreeToDirection -dir $windDirDeg

    # Describe the wind direction according to the WindDegrees skin variable
    $wd = $RmAPI.VariableStr("WindDegrees", "N").ToUpper().Substring(0, 1)
    switch ($wd) {
        "Y" { $windPhrase = "The wind is from $windDirDeg$Deg at $windSpeed mph" }
        "B" { $windphrase = "The wind is from the $windDirTxt ($windDirDeg$Deg) at $windSpeed mph" }
        Default { $windphrase = "The wind is from the $windDirTxt at $windSpeed mph" }
    }

    # Visibility
    $visibility = [Math]::Round(($WxData.visibility / 1609.344), 1)

    # Weather description
    $weatherDesc = (Get-Culture).TextInfo.ToTitleCase($WXData.weather.description)

    # Sun rise and set
    $sunRise = Convert-Timestamp -UnixDate $WxData.sys.sunrise
    $sunSet = Convert-Timestamp -UnixDate $WxData.sys.sunset
    $now = Get-Date
    if ($now.ticks -le $sunRise.ticks) {
        $srPhrase = "will be at {0}" -f $sunRise.ToShortTimeString()
    }
    else {
        $srPhrase = "was at {0}" -f $sunRise.ToShortTimeString()
    }
    if ($now.ticks -le $sunSet.ticks) {
        $ssPhrase = "will be at {0}" -f $sunSet.ToShortTimeString()
    }
    else {
        $ssPhrase = "was at {0}" -f $sunSet.ToShortTimeString()
    }

    # Last update
    $lastUpdate = Convert-Timestamp -UnixDate $WXData.dt
    $luPhrase = "{0} at {1}" -f $lastUpdate.ToShortDateString(), $lastUpdate.ToShortTimeString()

    # New StringBuiler object
    $sb = New-Object -TypeName "System.Text.StringBuilder";

    # Create details for tooltip
    $sb.AppendLine("Currently it is $Global:Temp$tempSuffix with $weatherDesc")
    $sb.AppendLine("It feels like $feelsLike$tempSuffix")
    if ($windGust -gt 5) {
        $sb.AppendLine($windphrase)
        $sb.AppendLine("The wind is gusting to $windGust mph")
    }
    else {
        $sb.AppendLine($windphrase)
    }
    $sb.AppendLine("The humidity is $humidity%")
    $sb.AppendLine("The dew point is $dewPoint$tempSuffix")
    $sb.AppendLine("The pressure is $pressure $pressureSuffix")
    $sb.AppendLine("Visiblity is $visibility miles")
    $sb.AppendLine("Sunrise $srPhrase")
    $sb.AppendLine("Sunset $ssPhrase")
    $sb.AppendLine("Last updated:  $luPhrase")

    $Global:Details = $sb.ToString()

    $log = $RmAPI.VariableStr("Logging", "N").ToUpper().Substring(0, 1)
    if ($log -eq "Y") {
        Write-ToLog -details $sb.ToString()
    }
}

#################### Helper functions ####################

function ConvertTo-DewPoint ($tempF, $humid ) {
    # - Formula based on https://cals.arizona.edu/azmet/dewpoint.html
    $tempC = ($tempF - 32 ) / 1.8
    $x = ([Math]::Log($humid / 100) + ((17.27 * $tempC) / (237.3 + $tempC))) / 17.27
    $dewC = (237.3 * $x) / (1 - $x)
    $dewPoint = [Math]::Round((($dewC * 1.8) + 32), 0)
    return $dewPoint
}

Function Convert-Timestamp ($UnixDate) {
    $dt = [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
    return $dt
}

function Convert-DegreeToDirection ([Double]$dir) {
    # Thanks SO! https://stackoverflow.com/a/7490772
    $dirArray = @( "North", "NNE", "NE", "ENE", "East", "ESE", "SE", "SSE",
        "South", "SSW", "SW", "WSW", "West", "WNW", "NW", "NNW", "North")
    $windDir = $dirArray[[Math]::floor(($dir / 22.5) + 0.5 )]
    return $windDir
}

Function Format-Json ($json) {
    # Thanks SO! https://stackoverflow.com/a/61988399
    $PrettifiedJSON = ($json) | ConvertFrom-Json | ConvertTo-Json -Depth 100 |
        ForEach-Object { [System.Text.RegularExpressions.Regex]::Unescape($_) }
    return $PrettifiedJSON
}

Function Write-ToLog ($details) {
    $now = Get-Date
    $header = $("--- Logged: " + $now.ToString("g") + " ---")
    Add-Content -Path $logfile -Value $header -Encoding utf8
    Add-Content -Path $logfile -Value $details -Encoding utf8
}
