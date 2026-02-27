#IfWinActive, RuneLite
#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
; SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
#MaxHotkeysPerInterval 3000
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1
tab::Suspend

; $c::
SetTimer, PrayClickTimer, 17
return

PrayClickTimer:
    if GetKeyState("c", "P")
    {
        ; Button is still held, send another click
        Click
        Sleep, 20     
        Click
        Sleep, 30
    }
    else
    {
        ; Button is released, stop the timer immediately
        SetTimer, PrayClickTimer, Off
    }
return

LButton::
    ; Prevent the default left button action
    ; Send the first click immediately
    Click down
    Sleep, 70
    Click up
    
    ; Initialize timing variables
    startTime := A_TickCount
    minDelay := 12  ; Minimum delay between clicks (fastest)
    maxDelay := 150 ; Maximum delay between clicks (slowest) ;320 CON, 150 ELSE
    growthRate := 2.6  ; Exponential growth rate
    
    ; Force mouse button up state at the beginning
    MouseClick, left, , , , , U
    
    ; Continue clicking with exponential delay increase
    while GetKeyState("LButton", "P")
    {
        ; Calculate time held in seconds
        timeHeld := (A_TickCount - startTime) / 1000
        
        ; Calculate exponential delay: delay = minDelay * e^(growthRate * timeHeld)
        currentDelay := minDelay * Exp(growthRate * timeHeld)
        
        ; Cap the maximum delay
        if (currentDelay > maxDelay)
            currentDelay := maxDelay
            
        ; Wait for the calculated delay
        Sleep, %currentDelay%
        
        ; Check if button is still held
        if !GetKeyState("LButton", "P")
            break
            
        ; Ensure button is up before clicking again
        MouseClick, left, , , , , U
        Sleep, 5
        
        ; Send the click
        Click down
        Sleep, 0
        Click up
    }
    
    ; Always ensure mouse button is released at the end
    MouseClick, left, , , , , U
    
    ; Reset variables
    startTime := 0
    
    ; Return without passing through the original click
    return

ClickTimer:
    if GetKeyState("LButton", "P")
    {
        ; Button is still held, send another click
        Click down
        Sleep, 35 ; was 14 for inferno/quiver
        Click up
    }
    else
    {
        ; Button is released, stop the timer immediately
        SetTimer, ClickTimer, Off
    }
return

; Ensure the script stops clicking when the button is released
LButton up::
    ; Force mouse button up
    MouseClick, left, , , , , U
    SetTimer, ClickTimer, Off
    
    ; Also send a final mouse up just in case
    Click up
    
    ; Small delay to ensure system registers the release
    Sleep, 10
    
    ; Send another up to be absolutely sure
    MouseClick, left, , , , , U
return

; instatab // prayer training
; $v::
    n := 100
    MouseGetPos xpos, ypos
    SendInput, {F2}
    Sleep, %n%
    MouseMove, 1600, 873, 0  ; bottom right inventory
    SendInput {Click}
    Sleep, %n%

    MouseMove, %xpos%, %ypos%, 0 
return

; instaTB
; $c::
    n := 80
    MouseGetPos xpos, ypos
    SendInput, {F4}
    Sleep, %n%
	MouseMove, 1275, 180, 0  ; bottom right inventory
    SendInput {Click}
    Sleep, %n%
    MouseMove, 1370, 433, 0  ; bottom right inventory
	Sleep, %n%
    SendInput {Click}
    Sleep, %n%
    MouseMove, %xpos%, %ypos%, 0
	Sleep, %n%	
	SendInput {Click}
return

; entity hider
;  *space::
    BlockInput, MouseMove
    n :=  30 ; was 50
    MouseGetPos xpos, ypos
    MouseMove, 1852, 121, 0  ; entity hider button
    SendInput {Click}
    Sleep, %n%
    MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
    Sleep, %n%
    MouseMove, 1853, 121, 0  ; entity hider button
    SendInput {Click}
    Sleep, %n%
    MouseMove, 1530, 303, 0
    SendInput {Click}
    Sleep, %n%
    MouseMove %xpos%, %ypos%, 0 
    BlockInput, MouseMoveOff
return

; AGS maul sequence
; g::
    BlockInput, MouseMove
    n := 40
    Sleep, %n%
    MouseGetPos xpos, ypos
    MouseMove, 1421, 589, 0  ; Top left inventory
    SendInput {Click}
    Sleep, %n%
    MouseMove, 1350, 300, 0  ; Spec orb
    SendInput {Click}
    Sleep, %n%

    MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
    Sleep, %n%
    MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
    Sleep, %n%
    MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
	MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
    Sleep, %n%
    MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
    BlockInput, MouseMoveOff
return




; VENG VW
g::
	BlockInput, MouseMove
    n := 30
	MouseGetPos xpos, ypos
	
	; SendInput, {F2}
    ; Sleep, %n%
	; MouseMove, 1355, 762, 0 
	; Sleep, %n%
    ; Click
	; Sleep, %n%
	; MouseMove, 1344, 851, 0 
	; Sleep, %n%
    ; Click
	; Sleep, %n%
	; MouseMove, 1366, 919, 0 
	; Sleep, %n%
    ; Click
	; Sleep, %n%

	
	
	SendInput, {F4}   ; open spellbook
    Sleep, %n%
	MouseMove, 1328, 469, 0  ; click veng
	Sleep, %n%
    SendInput {Click}
	Sleep, %n%

	SendInput, {F2}
    Sleep, %n%
	MouseMove, 1348, 460, 0 
	Sleep, %n%
    Click
	Sleep, %n%



    ; EXTRA ITEMS
	;MouseMove, 1450, 460, 0 
	;Sleep, %n%
    ;Click
	;Sleep, %n%
	;MouseMove, 1550, 460, 0 
	;Sleep, %n%
    ;Click
	;Sleep, %n%
	;MouseMove, 1348, 530, 0 
	;Sleep, %n%
    ;Click
	;Sleep, %n%
	;MouseMove, 1450, 530, 0 
	;Sleep, %n%
    ;Click
	
	
	
	Sleep, %n%
	Sleep, %n%
	Sleep, %n%
    MouseMove, 1350, 300, 0  ; Spec orb
    SendInput {Click}
	Sleep, %n%

    MouseMove, %xpos%, %ypos%, 0 
	Sleep, %n%
    SendInput {Click}


	BlockInput, MouseMoveOff
return


#IfWinActive  ; End the context-sensitive hotkey