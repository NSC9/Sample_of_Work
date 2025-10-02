#SingleInstance Force
#UseHook
#WinActivateForce

SetKeyDelay 150
SetMouseDelay 150
SetTitleMatchMode 2
CoordMode "Mouse", "Client"

global g_SC2_Window := "ahk_exe SC2_x64.exe"
global g_HatcheryX := 988
global g_HatcheryY := 405
time := 50

; More robust SC2 activation
EnsureSC2Active() {
    global g_SC2_Window
    if !WinActive(g_SC2_Window) {
        WinActivate(g_SC2_Window)
        WinWaitActive(g_SC2_Window, , 1)
        Sleep 200  ; Longer pause after activation
    }
    return WinActive(g_SC2_Window)
}

; Queue drones
s:: {
    global g_HatcheryX, g_HatcheryY, time
    ; BLOCK INPUT during mouse operations to prevent interference
    BlockInput "On"
    MouseGetPos &originalX, &originalY
    
    ; Click hatchery
    MouseMove g_HatcheryX, g_HatcheryY, 0
    Sleep time
    Click
    Sleep time
    
    ; Queue drones
    Loop 7 {
        Send "q"
        Sleep time
        Send "w"
        Sleep time
    }
    
    ; Return mouse and restore input
    MouseMove originalX, originalY, 0
    BlockInput "Off"
}

; Queue zerglings
d:: {
    global g_HatcheryX, g_HatcheryY, time
    
    BlockInput "On"
    MouseGetPos &originalX, &originalY
    
    ; Click hatchery
    MouseMove g_HatcheryX, g_HatcheryY, 0
    Sleep time
    Click
    Sleep time
    
    ; Queue zerglings
    Loop 7 {
        Send "q"
        Sleep time
        Send "t"
        Sleep time
    }
    
    ; Return mouse
    MouseMove originalX, originalY, 0
    BlockInput "Off"
}

; Queen inject
f:: {
    global g_HatcheryX, g_HatcheryY, time
    
    BlockInput "On"
    MouseGetPos &originalX, &originalY
    
    ; Clear selection
    Send "{esc}"
    Sleep time
    
    ; Activate queen's inject ability
    Loop 3 {
        Send "u"
        Sleep time
    }
    
    ; Click hatchery
    MouseMove g_HatcheryX, g_HatcheryY, 0
    Sleep time
    Click
    Sleep time
    
    ; Return mouse
    MouseMove originalX, originalY, 0
    BlockInput "Off"
}


; Attack-move - FIXED VERSION
space:: {
    global time
    
    ; Get current mouse position
    MouseGetPos &xpos, &ypos
    
    ; Select army and attack-move
    Send "{F2}"
    Sleep time
    Send "e"
    Sleep time
    
    ; Move to the saved position and click
    MouseMove xpos, ypos, 0
    Sleep time
    Click
}