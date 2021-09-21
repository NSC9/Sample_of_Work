;  #Persistent
;  SetTimer, WatchCursor, 100
;  return

;  WatchCursor:
;  MouseGetPos, xpos, ypos 
;  PixelGetColor, color, %xpos%, %ypos%
;  Tooltip, The cursor is at X%xpos% Y%ypos% and color is %color%.
;  return

#IfWinActive, ahk_exe openosrs.exe
WinActivate, OpenOSRS
#Persistent 
CoordMode, Pixel, Client
Xpos11 := 1411
Ypos11 := 893
SetColor := 0x060673
SetTimer, WatchLife, 30
Return

WatchLife: 
Pixelgetcolor, Color, Xpos11, Ypos11
if (Color = SetColor)
{
    Critical
	BlockInput, MouseMove
	MouseGetPos xpos, ypos
	Send, {F1}
	Sleep, 0
	Click, 1339, 650 Left    ; 4th row 2nd column
	;  Sleep, 1
	Send, {F5}
	;  Sleep, 0
	Click, 1305, 881
	; Sleep, 1
	;  MouseMove, xpos, ypos , 1
	Click, %xpos%, %ypos%
	BlockInput, MouseMoveOff
	
	Sleep, 700
	BlockInput, MouseMove
	MouseGetPos xpos, ypos
	Send, {F3}
	Sleep, 5
        Click, 1405, 875
	Sleep, 25
	Send, {F1}
	Sleep, 5
	Click, 1273, 650 Left     ; 4th row 1st column
	;   Click, 1273, 580 Left     ; 2nd row 1st column
	Sleep, 50
	BlockInput, MouseMoveOff
	click, %xpos%, %ypos%
	Critical Off
	sleep 20000
}
Else
{
}

Return
#IF