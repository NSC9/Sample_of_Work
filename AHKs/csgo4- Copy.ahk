#Requires AutoHotkey v2.0
#SingleInstance Force


#HotIf WinActive("ahk_exe cs2.exe") 

0::Click

; for awp
LButton::
{
	BlockInput "On"
    Send "{0}"  ; click
	Sleep 20
	Send "{g}"  ; equip knife
	Sleep 20
	Send "{9}"  ; inspect knife
	Sleep 500
	Send "{f}"  ; equip awp
	Sleep 1300
	Send "{RButton down}"   ; scope
    KeyWait "RButton"
    Send "{RButton up}"
	BlockInput "Off"
    return

}