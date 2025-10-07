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
0:: {
	BlockInput "On"
	SendInput "+{Enter}"
	SendText "We are artificially intelligent agents. You will lose. There is no hope. Surrender now, or die a slow and grindfully painful death."
	Send "{Enter}"
	BlockInput "Off"
}

; Queue drones
s:: {
    global g_HatcheryX, g_HatcheryY, time
    ; BLOCK INPUT during mouse operations to prevent interference
    BlockInput "On"
	MouseGetPos &originalX, &originalY
	
	SendInput "+{Enter}"
	SendText "Agent is attempting to build 7 probes."
	Send "{Enter}"
    
    ; Click hatchery
    MouseMove g_HatcheryX, g_HatcheryY, 0
    Sleep time
    Click
    Sleep time
    
    ; Queue drones
    Loop 10
	{
        Send "q"
        Sleep time
        Send "w"
        Sleep time
    }
    
    ; Click hatchery
    MouseMove g_HatcheryX, g_HatcheryY, 0
    Sleep time
    Click
    Sleep time
	
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
    Loop 10 {
        Send "q"
        Sleep time
        Send "t"
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

; Queue SWARM HOSTS
g:: {
    global g_HatcheryX, g_HatcheryY, time
    
    BlockInput "On"
    MouseGetPos &originalX, &originalY
	
    ; Click hatchery
    MouseMove g_HatcheryX, g_HatcheryY, 0
    Sleep time
    Click
    Sleep time
    
    ; Queue zerglings
    Loop 10 {
        Send "q"
        Sleep time
        Send "y"
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

; Queen inject
f:: {
    global g_HatcheryX, g_HatcheryY, time
    
    BlockInput "On"
    MouseGetPos &originalX, &originalY
    
	SendInput "+{Enter}"
	SendText "Agent wishes to defend the current position."
	Send "{Enter}"
	
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
	
	SendInput "+{Enter}"
	SendText "Agent has ordered a full-scale attack at the current mouse position."
	Send "{Enter}"
    
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

; z = create control group 1, x = create control group 2