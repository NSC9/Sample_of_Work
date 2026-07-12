#IfWinActive, RuneLite
#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
#MaxHotkeysPerInterval 3000
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1

; ============================================================
; SECTION 1: GLOBAL VARIABLES
; ============================================================
MonitorPixelX := 0
MonitorPixelY := 0
MonitorPixelColor := ""
MonitorActive := false
LButtonActive := true
PixelChangeDetected := false
ColorVariance := 150

; Combat & Inventory Coordinates
PIETYSPEC_X := 0
PIETYSPEC_Y := 0
AGS_X := 0
AGS_Y := 0
HARDFOOD_X := 0
HARDFOOD_Y := 0
BREW_X := 0
BREW_Y := 0
KARAM_X := 0
KARAM_Y := 0
AUTORETAL_X := 0
AUTORETAL_Y := 0

; ============================================================
; SECTION 2: TOGGLE CONTROLS (Tab, A, D, F, S)
; ============================================================

; Tab = Full script suspend
tab::Suspend

; A, D, F = DISABLE LButton & Stop Pixel Monitoring
~a::
~d::
~f::
; ~g::
    LButtonActive := false
    StopPixelMonitoring(false)  ; DON'T re-enable LButton
return

; S = ENABLE LButton & Stop Pixel Monitoring
~s::
    LButtonActive := true
    StopPixelMonitoring(true)   ; Re-enable LButton
return

; Ctrl+S = ENABLE LButton & Stop Monitoring (backup)
~^s::
    LButtonActive := true
    StopPixelMonitoring(true)
return

; Shift+S = ENABLE LButton & Stop Monitoring (backup)
~+s::
    LButtonActive := true
    StopPixelMonitoring(true)
return

; ============================================================
; SECTION 3: PIXEL MONITORING SYSTEM (G Key)
; ============================================================

; G key - Start/Stop Pixel Monitoring
~g::
	LButtonActive := false
    if (MonitorPixelX = 0 and MonitorPixelY = 0) {
        LButtonActive := false
        return
    }
    
    MonitorActive := !MonitorActive
    
    if (MonitorActive) {
        StartPixelMonitoring()
    } else {
        StopPixelMonitoring(true)  ; Re-enable LButton when manually stopping
    }
return

StartPixelMonitoring() {
    global MonitorPixelX, MonitorPixelY, MonitorPixelColor
    global PixelChangeDetected, LButtonActive
    
    ; Capture color twice for stability
    Sleep, 100
    PixelGetColor, MonitorPixelColor, %MonitorPixelX%, %MonitorPixelY%
    Sleep, 50
    PixelGetColor, MonitorPixelColor, %MonitorPixelX%, %MonitorPixelY%
    PixelChangeDetected := false
    
    Sleep, 400  ; Wait before starting timer
    
    SetTimer, MonitorPixelExpired, 6000
    SetTimer, MonitorPixel, 100
    SetTimer, RemoveToolTip, -1500
    LButtonActive := false  ; Disable LButton while monitoring
}

StopPixelMonitoring(ReEnableLButton := false) {
    global MonitorActive, PixelChangeDetected, LButtonActive
    
    MonitorActive := false
    PixelChangeDetected := false
    
    if (ReEnableLButton) {
        LButtonActive := true
    }
    ; If ReEnableLButton is false, LButtonActive keeps its current state (false)
    
    SetTimer, MonitorPixel, Off
    SetTimer, MonitorPixelExpired, Off
    SetTimer, RemoveToolTip, -1500
}

; Pixel Monitoring Timer - Checks for color changes
MonitorPixel:
    if (!MonitorActive)
        return
    
    PixelGetColor, currentColor, %MonitorPixelX%, %MonitorPixelY%
    
    ; Calculate color difference
    r1 := (currentColor & 0xFF0000) >> 16
    g1 := (currentColor & 0x00FF00) >> 8
    b1 := (currentColor & 0x0000FF)
    
    r2 := (MonitorPixelColor & 0xFF0000) >> 16
    g2 := (MonitorPixelColor & 0x00FF00) >> 8
    b2 := (MonitorPixelColor & 0x0000FF)
    
    ColorDiff := Abs(r1 - r2) + Abs(g1 - g2) + Abs(b1 - b2)
    
    ; Check if color changed significantly
    if (ColorDiff > ColorVariance && !PixelChangeDetected) {
        ; Confirm with second check
        Sleep, 50
        PixelGetColor, confirmColor, %MonitorPixelX%, %MonitorPixelY%
        
        r3 := (confirmColor & 0xFF0000) >> 16
        g3 := (confirmColor & 0x00FF00) >> 8
        b3 := (confirmColor & 0x0000FF)
        
        ColorDiff2 := Abs(r3 - r2) + Abs(g3 - g2) + Abs(b3 - b2)
        
        if (ColorDiff2 > ColorVariance) {
            PixelChangeDetected := true
            MonitorActive := false
            SetTimer, MonitorPixel, Off
            SetTimer, MonitorPixelExpired, Off
            
            Gosub, ExecuteGMAULEAT
            
            SetTimer, RemoveToolTip, -1500
            LButtonActive := true
        }
    }
return

; Monitor Expiry Timer
MonitorPixelExpired:
    StopPixelMonitoring()
    SetTimer, RemoveToolTip, -2000
return

; ============================================================
; SECTION 4: PRAYER FLICK SYSTEM (C Key)
; ============================================================

; Initialize prayer flick timer
SetTimer, PrayClickTimer, 17

PrayClickTimer:
    if GetKeyState("c", "P") {
        Click
        Sleep, 20
        Click
        Sleep, 30
    } else {
        SetTimer, PrayClickTimer, Off
    }
return

; ============================================================
; SECTION 5: MOUSE CLICK SYSTEM (LButton)
; ============================================================

; Modified LButton with acceleration
~LButton::
    if (!LButtonActive)
        return
    
    Sleep, 50
    
    startTime := A_TickCount
    minDelay := 12
    maxDelay := 150
    growthRate := 2.6
    
    MouseClick, left, , , , , U
    
    while GetKeyState("LButton", "P") {
        if (!LButtonActive)
            break
        
        timeHeld := (A_TickCount - startTime) / 1000
        currentDelay := minDelay * Exp(growthRate * timeHeld)
        
        if (currentDelay > maxDelay)
            currentDelay := maxDelay
        
        Sleep, %currentDelay%
        
        if !GetKeyState("LButton", "P")
            break
        
        MouseClick, left, , , , , U
        Sleep, 5
        Click down
        Sleep, 0
        Click up
    }
    
    MouseClick, left, , , , , U
    startTime := 0
return

; LButton release safety
~*LButton up::
    MouseClick, left, , , , , U
    Click up
    Sleep, 10
    MouseClick, left, , , , , U
return

ExecuteGMAULEAT:
    n := 50
    MouseGetPos, xpos, ypos       ; Fixed: was using xpos twice
	BlockInput, On
	BlockInput, MouseMove
	
    ; Open inventory (F2)
    SendInput {f2}
    Sleep, %n%
    
    ; Click AGS
    MouseMove, %AGS_X%, %AGS_Y%, 0
    Sleep, %n%
    SendInput {Click}
    Sleep, %n%
	
    ; Open spectab (F5)
    SendInput {f5}
    Sleep, %n%
	
    ; Click spec
    MouseMove, %PIETYSPEC_X%, %PIETYSPEC_Y%, 0
    Sleep, %n%
    SendInput {Click}
	
	Sleep, 100 
	; click opponent
    MouseMove, %xpos%, %ypos%, 0
	Sleep, %n%
	SendInput {Click}
	Sleep, %n%
	
    
	Sleep, 350 	; Important delay for spec

    ; Open inventory again
    SendInput {f2}
    Sleep, %n%
    
    ; Eat Hard Food
    MouseMove, %HARDFOOD_X%, %HARDFOOD_Y%, 0
    Sleep, %n%
    SendInput {Click}
    Sleep, %n%
    
    ; Eat Brew
    MouseMove, %BREW_X%, %BREW_Y%, 0
    Sleep, %n%
    SendInput {Click}
    
    ; Eat Karam
    MouseMove, %KARAM_X%, %KARAM_Y%, 0
    Sleep, %n%
    SendInput {Click}
    Sleep, %n%
    
    ; Equip Phoenix Necklace
    MouseMove, %PHOENIX_X%, %PHOENIX_Y%, 0
    Sleep, %n%
    SendInput {Click}
    Sleep, %n%
	
	; Equip BULWARK
    MouseMove, %BULWARK_X%, %BULWARK_Y%, 0
    Sleep, %n%
    SendInput {Click}
    Sleep, %n%
    
    ; Run south
    MouseMove, 1500, 300, 0
    Sleep, %n%
    SendInput {Click}
    Sleep, %n%
    
    ; Return mouse
    MouseMove, %xpos%, %ypos%, 0
	BlockInput, Off
	BlockInput, MouseMoveOff
return

; H key - Manual trigger
$h::
    Gosub, ExecuteGMAULEAT
return

; F11 - Manual trigger
~*f11::
    Gosub, ExecuteGMAULEAT
return

; ============================================================
; SECTION 7: INSTA-TAB SYSTEM (V Key)
; ============================================================

; V key - Instant teleport to house
$v::
    n := 100
    MouseGetPos xpos, ypos
    
    SendInput, {F2}
    Sleep, %n%
    
    MouseMove, 1600, 873, 0
    SendInput {Click}
    Sleep, %n%
    
    MouseMove, %xpos%, %ypos%, 0
return

; ============================================================
; SECTION 8: COORDINATE SETUP (R Key)
; ============================================================

; R key - Setup all coordinates with guided prompts
+0::
    ; Get all positions via prompts
    
    PromptForCoordinate("Hover over maul and hit Enter", AGS_X, AGS_Y)
	PromptForCoordinate("Hover over phoenix necklace and hit Enter", PHOENIX_X, PHOENIX_Y)
	PromptForCoordinate("Hover over BULWARK and hit Enter", BULWARK_X, BULWARK_Y)
    PromptForCoordinate("Hover over hardfood and hit Enter", HARDFOOD_X, HARDFOOD_Y)
    PromptForCoordinate("Hover over brew and hit Enter", BREW_X, BREW_Y)
    PromptForCoordinate("Hover over karam and hit Enter", KARAM_X, KARAM_Y)
    PromptForCoordinate("Hover over pietyspec and hit Enter", PIETYSPEC_X, PIETYSPEC_Y)
	
	
    ; Open prayer (F5)
    SendInput {f5}
    Sleep, 500
    
    ; Setup pixel monitor position
    PromptForCoordinate("Hover over pixel to monitor (for G key) and hit Enter", MonitorPixelX, MonitorPixelY)
    PixelGetColor, MonitorPixelColor, %MonitorPixelX%, %MonitorPixelY%
    
    ; Setup auto retaliate position
    ; PromptForCoordinate("Hover over auto retaliate to enable for gmaul spec", AUTORETAL_X, AUTORETAL_Y)
    
    ; Save all coordinates to INI file
    SaveCoordinatesToIni()
return

PromptForCoordinate(Message, ByRef X, ByRef Y) {
    FocusAndMsgBox(Message)
    MouseGetPos, X, Y
}

FocusAndMsgBox(Message) {
    WinActivate, ahk_class SunAwtFrame
    Sleep, 100
    WinWaitActive, ahk_class SunAwtFrame, , 2
    if !ErrorLevel {
        MsgBox, %Message%
    } else {
        MsgBox, Could not activate RuneLite window! Please make sure it's running.
        return
    }
}

SaveCoordinatesToIni() {
    global AGS_X, AGS_Y, PIETYSPEC_X, PIETYSPEC_Y
    global HARDFOOD_X, HARDFOOD_Y, BREW_X, BREW_Y
    global KARAM_X, KARAM_Y
    global PHOENIX_X, PHOENIX_Y, BULWARK_X, BULWARK_Y
    IniWrite, %AGS_X%, coords.ini, AGS, X
    IniWrite, %AGS_Y%, coords.ini, AGS, Y
    IniWrite, %PIETYSPEC_X%, coords.ini, SPEC, X
    IniWrite, %PIETYSPEC_Y%, coords.ini, SPEC, Y
    IniWrite, %HARDFOOD_X%, coords.ini, HARDFOOD, X
    IniWrite, %HARDFOOD_Y%, coords.ini, HARDFOOD, Y
    IniWrite, %BREW_X%, coords.ini, BREW, X
    IniWrite, %BREW_Y%, coords.ini, BREW, Y
    IniWrite, %KARAM_X%, coords.ini, KARAM, X
    IniWrite, %KARAM_Y%, coords.ini, KARAM, Y
    IniWrite, %PHOENIX_X%, coords.ini, PHOENIX, X
    IniWrite, %PHOENIX_Y%, coords.ini, PHOENIX, Y
    IniWrite, %BULWARK_X%, coords.ini, BULWARK, X
    IniWrite, %BULWARK_Y%, coords.ini, BULWARK, Y	
}

; ============================================================
; SECTION 9: HELPERS
; ============================================================

RemoveToolTip:
    ToolTip
return

#IfWinActive