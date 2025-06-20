#IfWinActive, RuneLite
tab::Suspend

LButton::
    ; Send the first click immediately
    Click down
    Sleep, 35
    Click up
    
    ; Start a timer to send subsequent clicks every 55 ms
    SetTimer, ClickTimer, 15
return

ClickTimer:
    if GetKeyState("LButton", "P")
    {
        ; Button is still held, send another click
        Click down
        Sleep, 10
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
    SetTimer, ClickTimer, Off
return

; AGS maul sequence
; c::
    n := 100
    MouseGetPos xpos, ypos
    SendInput, {F1}
    Sleep, %n%
    MouseMove, 588, 332, 0  ; Top left inventory
    SendInput {Click}
    Sleep, %n%
    MouseMove, 590, 184, 0  ; Spec orb
    SendInput {Click}
    Sleep, %n%
    MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
    Sleep, %n%
    MouseMove, %xpos%, %ypos%, 0 
    SendInput {Click}
return

#IfWinActive  ; End the context-sensitive hotkey
