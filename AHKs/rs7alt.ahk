; this line is a comment.
; this code is for an Autohotkey script that works on the Windows 11 operating system. If you download Autohotkey, you must use the deprecated AHK version v1.1. 
; for Authotkey Installation and information on cyber security, see https://youtu.be/5g4filjx7eM?si=xZb8A3qP6wVRYuFZ

; Donate With Crypto:

; Bitcoin (BTC): bc1q2makllwj2h0shvheekyrsklhsa4syrrzutrmhr

; Litecoin (LTC): MDgCMYornMT2Rtho9tjX21wKqpqof6qYkf

; Created by https://github.com/NSC9 - GNUv3 License (https://www.gnu.org/licenses/)

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
; whileleft mouse button is held down. 
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
    KeyWait, lButton, T0.09
    If ErrorLevel
    {
        While (GetKeyState("lButton", "P"))
        {
           Sendinput {Click}
           Sleep, 15
        }
        KeyWait, lButton
    }
return
q::1
w::2
g::
    Send, {Media_Play_Pause}  ; Sends the play/pause media key
return

; ags maul
;  c::
        MouseGetPos xpos, ypos	
	SendInput, {F1}
	Sleep, 50
	MouseMove, 1615, 560
	SendInput {Click}
	Sleep, 50
	MouseMove, 1380, 305
	SendInput {Click}
	Sleep, 50
	MouseMove, 1385, 300
	SendInput {Click}
	Sleep, 50
	MouseMove, 1380, 305
	SendInput {Click}
    	Sleep 30 ; Pause 50 milliseconds between clicks (adjust as needed)
        MouseMove, %xpos%, %ypos%
	Sleep, 50
	SendInput {Click, %xpos%, %ypos%,left}
	Sleep, 50
	SendInput {Click, %xpos%, %ypos%,left}
	Sleep, 50
	SendInput {Click, %xpos%, %ypos%,left}
return

#If

^Space::
WinSet, AlwaysOnTop, Toggle, ahk_exe chrome.exe
return
