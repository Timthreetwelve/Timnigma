# Timnigma

[![GitHub](https://img.shields.io/github/license/Timthreetwelve/Timnigma?style=plastic)](https://github.com/Timthreetwelve/Timnigma/blob/main/LICENSE)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/Timthreetwelve/Timnigma?style=plastic)](https://github.com/Timthreetwelve/Timnigma/releases/latest) 
[![GitHub all releases](https://img.shields.io/github/downloads/Timthreetwelve/Timnigma/total?style=plastic)](https://github.com/Timthreetwelve/Timnigma/releases) 
[![GitHub commits since latest release (by date)](https://img.shields.io/github/commits-since/timthreetwelve/timnigma/latest?style=plastic)](https://github.com/Timthreetwelve/Timnigma/commits/main)
[![GitHub last commit](https://img.shields.io/github/last-commit/timthreetwelve/timnigma?style=plastic)](https://github.com/Timthreetwelve/Timnigma/commits/main)
![](https://img.shields.io/badge/joy-100%25-blueviolet?style=plastic)

Timnigma is a suite of [Rainmeter](https://www.rainmeter.net/) skins. It is based on the [Enigma](https://www.kaelri.com/projects/enigma/) suite.  

### Prerequisites

* A familiarity with Rainmeter and  version 4.3 or higher.
* Many of the skins require [HWiNFO](https://www.hwinfo.com/) version 7.02 or later.
* The weather skin requires an API key from [OpenWeatherMap](https://home.openweathermap.org/users/sign_up) and the [PowershellRM Plugin](https://khanhas.gitbook.io/powershellrm/)
* PowerShell - either PowerShell.exe or pwsh.exe.
* An editor such as Notepad++ or Visual Studio Code.
* A fair amount of patience and willingness to tweak the code.

### Configuring Timnigma

* Install the Timnigma .rmskin file.
* Load the Background skin.
* Left click on the "hamburger" menu on the left end of the background bar.
* Select Timnigma Settings and adjust the settings to work best for you.
* Read [this](https://docs.rainmeter.net/tips/hwinfo/) post on configuring HWiNFO then read it again.
* Instead of updating individual meters, update the HWiNFO.inc file (located in the _IncludeFile folder) with the index values obtained when configuring the sensors. Use the Edit HWiNFO button in the settings app.
* Load the HWiNFO skin. It will be red if HWiNFO isn't configured correctly. Left-click to show the menu which has an entry to show the registry values.
* 👉 **NEW** 👈 Use the HWiNFO VSB Viewer to find the Index numbers for HWiNFO sensors. The  HWiNFO VSB Viewer is located in the _HWiNFOViewer folder and is accessible as a menu item in the HWiNFO and Background skins.
* The most current version of HWiNFO VSB Viewer can be found [here](https://github.com/Timthreetwelve/HWiNFO-VSB-Viewer).

### Features

* Additional information is available in a tooltip when hovering the mouse over any meter.
* Many meters have actions available on a context menu when left-clicking on the meter.
* Several meters have variants. Choose to have bar graphs or not.
* Easily adjust the transparency of the background bar by scrolling the mouse wheel over the "hamburger" menu at the right end of the bar.
* Easily adjust the volume by scrolling the mouse wheel while hovering over the Volume meter.

### Final Thoughts

* This configuration works on my machine. It may require additional tweaks on your machine.
* Don't be afraid to experiment.
* You may need to associate .inc files with your editor.
* If you are using Visual Studio Code, you may want to install the Rainmeter Support extension.
