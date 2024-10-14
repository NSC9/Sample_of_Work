#IfWinActive,   RuneLite
; #IfWinActive,   Old School RuneScape
`::Suspend

;  *tab::shift
;  *capslock::shift

; this block of code allows one to shift-drag items while still being able to spam click
; while the left mouse button is held down. 
*Shift::
    if (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 500)
        return  ; Prevents action if the Shift key was recently pressed
    Send, {LButton Down}  ; Send left mouse button down click
    Sleep, 200            ; Wait for 800 milliseconds
    Send, {LButton Up}    ; Send left mouse button up click
return

*Shift Up::return  ; Ensures Shift key is handled properly when released



*lbutton::

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

    Sendinput {Click} ; was send {Click}
    KeyWait, lButton, T0.11
    If ErrorLevel
    {
        While (GetKeyState("lButton", "P"))
        {
	   Sendinput {Click}
           Sleep, 60
           ;  Random, Rand, 15, 25 ;  was 8,15
           ;  Sleep, %Rand%

        }
        KeyWait, lButton
    }
    return


; ags maul
g::
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
	Critical
        MouseGetPos xpos, ypos	
        BlockInput, MouseMove
	
	SendInput, {F1}
	Sleep, 40
	SendInput {Click, 1150, 600, 1} ; client mouse pos
	Sleep, 40
	SendInput {Click, 1155, 295, 1}
	Sleep, 40
	SendInput {Click, 1165, 305, 1}
	Sleep, 40
	SendInput {Click, 1160, 300, 1}
	Sleep, 20
        MouseMove, %xpos%, %ypos%
	Sleep, 220
	SendInput {Click, %xpos%, %ypos%,left}
	BlockInput, MouseMoveOff
	Critical Off
	return
#If
