; Donate With Crypto:

; Bitcoin (BTC): bc1q2makllwj2h0shvheekyrsklhsa4syrrzutrmhr

; Litecoin: MDgCMYornMT2Rtho9tjX21wKqpqof6qYkf

; Created by https://github.com/NSC9 - MIT License

;  logitech mouse 300 dpi // windows mouse @ 6/11 // stick keys off // 1920x1080p resolution // java runtime parameters -xmx8000m window mousespeed 11
;  #Persistent
;  SetTimer, WatchCursor, 100
;  return

;  WatchCursor:
;  MouseGetPos, xpos, ypos 
;  PixelGetColor, color, %xpos%, %ypos%
;  tooltip, The cursor is at X%xpos% Y%ypos% and color is %color%.
;  return


^up::SoundSet +5
^down::SoundSet -5

#IfWinActive,   OpenOSRS ; ahk_exe OpenOSRS.exe

`::Suspend

;  *tab::shift
;  *capslock::shift
z::left
x::right


*w:: 
	sendinput {Esc}
	return  
*e:: 
	sendinput {Esc}
	return  
*a::
	sendinput {f1}
	return

*s::  ; was d
	sendinput {f2} 
	return  

*d::  ; was f
  	sendinput {f3}
        return

*f::  ; was d
	sendinput {f4} 
	return  

*g::  ;  was g
	sendinput {f5}
	return
*h::  ;  was g
	sendinput {f5}
	return
*+a::
	sendinput {f1}
	return

*+s::  ; was d
	sendinput {f2} 
	return  

*+d::  ; was f
  	sendinput {f3}
        return

*+f::  ; was d
	sendinput {f4} 
	return  

*+g::  ;  was g
	sendinput {f5}
	return

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


;  x::
	BlockInput, MouseMove
	Critical
	MouseGetPos xpos, ypos	
	SendInput {Click, 1197, 216, 1}   ; quick prayer
	sleep, 20
	SendInput, {F4}
	Sleep, 60
	SendInput {Click, 1492, 532, 1} ; teleblock spell
	MouseMove, xpos, ypos , 0
        Sleep, 60
	SendInput {Click, %xpos%, %ypos%,1}	
        sleep, 20
	SendInput, {F1}
	BlockInput, MouseMoveOff
	Critical Off
	return


;  claw maul w/ cbow switch after (tribrid)
;  space::
	BlockInput, MouseMove
	Critical
	MouseGetPos xpos, ypos

	SendInput, {F1}
	Sleep, 20
	SendInput {Click, 1328, 640, 1}   ; 4th row 2nd column
	Sleep, 20
	SendInput, {F5}
	Sleep, 20
	SendInput {Click, 1305, 881, 1}
	Sleep, 20 
	SendInput {Click, %xpos%, %ypos%,1}
	BlockInput, MouseMoveOff
	
	Sleep, 700
	BlockInput, MouseMove
	MouseGetPos xpos, ypos
	Send, {F3}
	Sleep, 5
        Click, 1373, 875
	Sleep, 25
	Send, {F1}
	Sleep, 5
	Click, 1237, 642 Left     ; 4th row 1st column
	;   Click, 1273, 580 Left     ; 2nd row 1st column
	Sleep, 50
	MouseMove, xpos, ypos , 0
        Sleep, 20
	BlockInput, MouseMoveOff
	sendinput {click, %xpos%, %ypos%,1}
	Critical Off
	return




; volly throwaxe
;  space::
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
	BlockInput, MouseMove
	Critical
	MouseGetPos xpos, ypos
	MouseMove, xpos, ypos , 0
        Sleep, 20
	SendInput {Click, %xpos%, %ypos%,left}
	Sleep, 60
	SendInput, {F1}
	Sleep, 30
	SendInput {Click, 1450, 854, 1}   ; 4th row 2nd column
	Sleep, 40
	;  SendInput {Click, 1364, 480, 1}   ; body
	;  Sleep, 40
	;  SendInput {Click, 1364, 551, 1}   ; legs
	;  Sleep, 40
	;  SendInput {Click, 1430, 560, 1}   ; amulet
	;  Sleep, 40
	Sendinput, {F3}
	Sleep, 40
        Sendinput {Click, 1510, 875,1}
	Sleep, 20
	SendInput, {F5}
	Sleep, 30
	SendInput {Click, 1387, 900, 1}
	Sleep, 20
        MouseMove, %xpos%, %ypos% , 0
	Sleep, 90
	SendInput {Click, %xpos%, %ypos%,left}
	Sleep, 30
	SendInput, {F1}
	;  Sleep, 500
	;  Sendinput {Click, 1610, 853,1} ; pneck
        ;  Sleep, 20
	;  Sendinput {Click, 1610, 781,1} ; pneck
        ;  Sleep, 20
	;  Sendinput {Click, 1610, 721,1} ; pneck
        ;  Sleep, 40
	;  MouseMove, %xpos%, %ypos% , 0
	BlockInput, MouseMoveOff
	Critical Off
	return

;  e::
	sendinput ^{backspace}
	sleep, 40
	sendinput {#}freakshow
	sleep, 40
	sendinput {enter}
	sleep, 40
	sendinput {shift down}
	sleep, 40
	sendinput {shift up}
	sleep, 200
	return
;  +e::
	sendinput ^{backspace}
	sleep, 40
	sendinput flash2:shake: {#}freakshow
	sleep, 40
	sendinput {enter}
	sleep, 40
	sendinput {shift down}
	sleep, 40
	sendinput {shift up}
	sleep, 200
	return


; #If Suspended = False && WinActive("ahk_exe openosrs.exe")

+lbutton::lbutton

^+*lbutton::
    sendinput {Click} ; was send {Click}
    KeyWait, lButton, T0.010; was T0.081
    If ErrorLevel
    {
        While (GetKeyState("lButton", "P"))
        {
	   Sendinput {Click}
           Sleep, 15
           ;  Random, Rand, 15, 25 ;  was 8,15
           ;  Sleep, %Rand%

        }
        KeyWait, lButton
    }
    return


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
;  space::
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
	BlockInput, MouseMove
	MouseGetPos xpos, ypos

	; MouseMove, xpos, ypos , 0
        ; Sleep, 20
	; SendInput {Click, %xpos%, %ypos%,left}
	; Sleep, 60

	SendInput, {F1}
	Sleep, 20
	SendInput {Click, 1525, 854, 1}   ; 4th row 2nd column
	Sleep, 20
	SendInput, {F5}
	Sleep, 30
	SendInput {Click, 1450, 900, 1}
	Sleep, 20
	; SendInput {Click, 1450, 900, 1}
	; Sleep, 20
        MouseMove, %xpos%, %ypos% , 0
	Sleep, 220
	SendInput {Click, %xpos%, %ypos%,left}
	;  Sleep, 30
	;  SendInput, {F1}
	;  Sleep, 500
	;  Sendinput {Click, 1610, 853,1} ; pneck
        ;  Sleep, 20
	;  Sendinput {Click, 1610, 781,1} ; pneck
        ;  Sleep, 20
	;  Sendinput {Click, 1610, 721,1} ; pneck
        ;  Sleep, 40
	;  MouseMove, %xpos%, %ypos% , 0
	BlockInput, MouseMoveOff
	Critical Off
	return

; teleblock
;  *space::
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
	BlockInput, MouseMove
	Critical
	MouseGetPos xpos, ypos	
	SendInput {Click, 1275, 216, 1}   ; quick prayer
	Sleep, 20
	SendInput, {F4}
	Sleep, 100
	SendInput {Click, 1600, 855, 1} ; teleblock spell
        ;  SendInput {Click, 1400, 555, 1} ; ice barrage
	MouseMove, xpos, ypos , 0
        Sleep, 120
	SendInput {Click, %xpos%, %ypos%,1}	
       	Sleep, 50
	SendInput, {F1}
	BlockInput, MouseMoveOff
	Critical Off
	;  Sleep, 1500
        ;  Sendinput, mw {enter}
        Return

; insta-maul
;  space::
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
	BlockInput, MouseMove
	MouseGetPos xpos, ypos
	MouseMove, xpos, ypos , 0
        Sleep, 30
	SendInput, {F1}
	Sleep, 70
	SendInput {Click, 1560, 950, 1}   ; 4th row 2nd column
	Sleep, 60
	SendInput {Click, 1525, 854, 1}   ; 4th row 2nd column
	Sleep, 70	
	SendInput {Click, %xpos%, %ypos%,left}
	Sleep, 100
	SendInput {Click, %xpos%, %ypos%,left}
	Sleep, 40
	Sendinput, {F3}
	Sleep, 70
        Sendinput {Click, 1510, 875,1}
	Sleep, 70
	SendInput, {F5}
	Sleep, 70
	SendInput {Click, 1450, 900, 1}
	Sleep, 20
	SendInput {Click, 1450, 900, 1}
	Sleep, 20
	SendInput {Click, 1450, 900, 1}
	Sleep, 80
        MouseMove, %xpos%, %ypos% , 0
	Sleep, 20
	; SendInput {Click, %xpos%, %ypos%,left}
	; Sleep, 60
	; SendInput {Click, %xpos%, %ypos%,left}
	; Sleep, 40

	; Sendinput, {F3}
	; Sleep, 50
        ; Sendinput {Click, 1570, 875,1}
	; Sleep, 40
        ; MouseMove, %xpos%, %ypos% , 0
	; Sleep, 40

	SendInput, {F1}
	;  Sleep, 500
	;  Sendinput {Click, 1610, 853,1} ; pneck
        ;  Sleep, 20
	;  Sendinput {Click, 1610, 781,1} ; pneck
        ;  Sleep, 20
	;  Sendinput {Click, 1610, 721,1} ; pneck
        ;  Sleep, 40
	;  MouseMove, %xpos%, %ypos% , 0
	BlockInput, MouseMoveOff
	Critical Off
	return

#If
