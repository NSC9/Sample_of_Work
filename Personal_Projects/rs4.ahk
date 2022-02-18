;                                            logitech mouse 300 dpi // windows mouse @ 6/11 // stick keys off // 1920x1080p resolution // java runtime parameters -xmx8000m window mousespeed 11
;  #Persistent
;  SetTimer, WatchCursor, 100
;  return

;  WatchCursor:
;  MouseGetPos, xpos, ypos 
;  PixelGetColor, color, %xpos%, %ypos%
;  tooltip, The cursor is at X%xpos% Y%ypos% and color is %color%.
;  return

;  ^del::
;  Sendinput Gimnickdick@gmail.com{tab}
;  sleep, 100
;  Sendinput Gimnickdick784512
;  sleep, 100
;  return 

;   ^del::
; 	Sendinput decima5productions@gmail.com{tab}
; 	sleep, 100
; 	Sendinput p1vjffdu79fm1gi5sr5udq2nol
; 	sleep, 100
;	Sendinput {enter}
; 	return 

;  WinActivate, ahk_exe obs64.exe
;  send {f10}

;  WinActivate, ahk_exe openosrs.exe
;  return

^up::SoundSet +5
^down::SoundSet -5

^d::
	sendinput `````````+{Enter}`````````
	Sleep, 170
	sendinput {Backspace}
	Sleep, 170
	sendinput {Up 1}
	Sleep, 170
	sendinput {Right}
	Sleep, 170    
	sendinput {Backspace}                
	return


#IfWinActive,   OpenOSRS ; ahk_exe OpenOSRS.exe

`::Suspend

;  *tab::shift
;  *capslock::shift
LAlt::left
Space::right
;  c::f12
LWin::shift

q:: 
	sendinput {f9}
	return  
*d:: 
	sendinput {Esc}
	return  

*z::f1

*x::f2

*c::f3

*v::f4  

*b::f5

+*z::f1
+*x::f2
*+c::f3

*+v::f4

*+b::f5


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





; #If Suspended = False && WinActive("ahk_exe openosrs.exe")

+lbutton::lbutton
^rbutton::rbutton

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
    Sleep, 0
    KeyWait, lButton, T0.105 ; was 0.132
    If ErrorLevel
    {
        While (GetKeyState("lButton", "P"))
        {
           ;  Sendinput {Click} ; was send {Click}
           ;  Random, Rand, 90, 120 ;  was 8,15
           ;  Sleep, %Rand%
		   
           Sendinput {Click} ; was send {Click}
           Sleep, 70

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

	SendInput, {F1}
	Sleep, 170
	SendInput {Click, 1437, 907, 1}   
	Sleep, 20
	SendInput {F5}
	Sleep, 20
	SendInput {Click, 1387, 905, 1}
	Sleep 40

        MouseMove, %xpos%, %ypos% , 0
 	Sleep, 100
	SendInput {Click, %xpos%, %ypos%,left}

	BlockInput, MouseMoveOff
	Critical Off
	return



; teleblock
;  c::
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
	SendInput {Click,862, 163, 1}   ; quick prayer
	Sleep, 20
	SendInput, {F4}
	;  SendInput {Click, 736, 461, 1}
	;  Sleep, 100
	SendInput {Click, 950, 611, 1}
	Sleep, 20
	MouseMove, xpos, ypos , 0
        Sleep, 120
	SendInput {Click, %xpos%, %ypos%,1}	
        Sleep, 50
	SendInput, {F1}
	BlockInput, MouseMoveOff
	Critical Off

        Return


#If
