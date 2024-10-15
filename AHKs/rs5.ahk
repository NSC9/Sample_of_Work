#IfWinActive,   RuneLite
; #IfWinActive,   Old School RuneScape

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
#MaxHotkeysPerInterval 3000
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
`::Suspend

;  *tab::shift
;  *capslock::shift

; this block of code allows one to shift-drag items while still being able to spam click
; while the left mouse button is held down. 
*Shift::
    if (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 500)
        return  ; Prevents action if the Shift key was recently pressed
    Send, {LButton Down}  ; Send left mouse button down click
    Sleep, 200            ; Wait for 200 milliseconds
    Send, {LButton Up}    ; Send left mouse button up click
return

*Shift Up::return  ; Ensures Shift key is handled properly when released

*LButton::
    Sendinput {Click} ; was send {Click}
    KeyWait, lButton, T0.11
    If ErrorLevel
    {
        While (GetKeyState("lButton", "P"))
        {
           Sendinput {Click}
           Sleep, 60
        }
        KeyWait, lButton
    }
return

; ags maul
g::
	Critical
        MouseGetPos xpos, ypos	
        BlockInput, MouseMove
	
	SendInput, {F1}
	Sleep, 20
	SendInput {Click, 1150, 600, 1} ; client mouse pos
	Sleep, 40
	SendInput {Click, 1155, 295, 1}
	Sleep, 20
        MouseMove, %xpos%, %ypos%
	Sleep, 220
	SendInput {Click, %xpos%, %ypos%,left}
	BlockInput, MouseMoveOff
	Critical Off
return
#If
