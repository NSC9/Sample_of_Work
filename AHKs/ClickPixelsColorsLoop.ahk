#Requires AutoHotkey v2.0

; Toggle state variable {
isActive := false ;}

; Main hotkey - toggle on/off with "1" key {
1:: {
    global isActive
    isActive := !isActive
    
    if (isActive) {
        SoundBeep(1500, 100)  ; High beep for active
        ToolTip("Script ACTIVE - Press 1 to stop, 2 to pause", A_ScreenWidth//2, 0)
        SetTimer(ClickPurplePixel, 100)  ; Check every 100ms
    } else {
        SoundBeep(1000, 100)  ; Low beep for inactive
        ToolTip()
        SetTimer(ClickPurplePixel, 0)  ; Remove timer
    }
} ;}}

; Pause hotkey - pause/resume with "2" key {
2:: {
    global isActive
    static wasActive := false
    
    if (isActive) {
        isActive := false
        wasActive := true
        SoundBeep(800, 100)  ; Middle beep for pause
        ToolTip("Script PAUSED - Press 2 to resume", A_ScreenWidth//2, 0)
        SetTimer(ClickPurplePixel, 0)
    } else if (wasActive) {
        isActive := true
        wasActive := false
        SoundBeep(1500, 100)  ; High beep for resume
        ToolTip("Script RESUMED - Press 1 to stop, 2 to pause", A_ScreenWidth//2, 0)
        SetTimer(ClickPurplePixel, 100)
    }
} ;}}}

; Function to find and click purple pixels {
ClickPurplePixel() {
    ; Array of purple colors to search for
    purpleColors := [0xCF00EF, 0x9932CC, 0x8A2BE2, 0x9370DB, 0xFF00FF]
    colorVariation := 10
    
    startX := 0
    startY := 0
    endX := A_ScreenWidth
    endY := A_ScreenHeight
    
    ; Try each purple color in the array
    for color in purpleColors {
        try {
            searchResult := PixelSearch(&foundX, &foundY, startX, startY, endX, endY, color, colorVariation)
            if (searchResult) {
                MouseMove(foundX, foundY+30, 0)
                Click("Left")
                ToolTip("Purple pixel clicked at " foundX "," foundY, A_ScreenWidth//2, 20, 2)
                SetTimer(() => ToolTip(,,,2), -1000)
                Sleep(50)
                break  ; Exit loop after finding first match
            }
        }
    }
} ;}}

; Escape key to exit script completely {
Esc:: {
    ToolTip()
    ExitApp()
} ;}

; Initial instructions {
ToolTip("Press 1 to start/stop, 2 to pause/resume, Esc to exit", A_ScreenWidth//2, 0)
SetTimer(() => ToolTip(), -3000)  ; Remove initial tooltip after 3 seconds ;}