;---------------------------------------------------------------------
; Timnigma Styles
;---------------------------------------------------------------------
[StyleMeterText]
FontColor=#ColorText#
FontFace=#Font#
FontSize=#FontSize#
StringAlign=Center
Y=4
H=18
ToolTipType=#TTType#
ToolTipIcon=Info
ToolTipHidden=#TTHide#
AntiAlias=1
DynamicVariables=1

[StyleLabelText]
FontColor=#ColorText#,200
FontFace=#Font#
FontSize=(#FontSize# - 1)
StringAlign=Center
X=0r
Y=0R
H=15
W=#CURRENTCONFIGWIDTH#
ToolTipType=#TTType#
ToolTipIcon=Info
AntiAlias=1
DynamicVariables=1

[StyleMeterBackground]
Shape=Rectangle 0,1,#CURRENTCONFIGWIDTH#,(#BarHeight#-3),5 | Fill Color 32,32,32,#BackgroundAlpha# | StrokeWidth 0
MouseOverAction=[!SetVariable BackgroundAlpha 64][!Update]
MouseLeaveAction=[!SetVariable BackgroundAlpha 1][!Update]
ToolTipType=#TTType#
ToolTipIcon=Info
ToolTipHidden=#TTHide#
DynamicVariables=1

[StyleBarMeter]
AntiAlias=1
BarOrientation=Vertical
W=4
H=30
;Uncomment the next line to show a solid bar. Helpful when aligning meters.
;SolidColor=#ColorText#
