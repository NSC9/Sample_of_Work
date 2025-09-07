#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

; OSRS Agility Bot with Color Detection
; Press 1 to toggle, 2 to pause, Esc to exit

; Configuration - YOU MUST ADJUST THESE VALUES 
obstacleColors := [0xf22b2b,
					0x1d00ff,
					0x00fff1,
					0xa32bfe,
					0x30ff00,
					0xff832b,]  ; Replace with your obstacle colors
failSafeColor := 0xcf00ef                          ; Replace with your fail detection color
clickDelay := 10500                     ; Delay between clicks in ms
colorVariation := 10                            ; Color matching tolerance

; State variables
isActive := false
isPaused := false
currentObstacle := 1

; Toggle with "1" key
1:: {
    global isActive, isPaused
    isActive := !isActive
    
    if (isActive) {
        isPaused := false
        SoundBeep(1500, 100)
        ToolTip("OSRS Bot ACTIVE - Press 1 to stop, 2 to pause", A_ScreenWidth//2, 0)
        SetTimer(AgilityLoop, clickDelay)
    } else {
        SoundBeep(1000, 100)
        ToolTip()
        SetTimer(AgilityLoop, 0)
    }
}

; Pause with "2" key
2:: {
    global isActive, isPaused
    
    if (!isActive)
        return
        
    isPaused := !isPaused
    
    if (isPaused) {
        SoundBeep(800, 100)
        ToolTip("OSRS Bot PAUSED - Press 2 to resume", A_ScreenWidth//2, 0)
        SetTimer(AgilityLoop, 0)
    } else {
        SoundBeep(1500, 100)
        ToolTip("OSRS Bot RESUMED - Press 1 to stop, 2 to pause", A_ScreenWidth//2, 0)
        SetTimer(AgilityLoop, clickDelay)
    }
}

; Main agility loop {
AgilityLoop() { 
    global obstacleColors, failSafeColor, currentObstacle, colorVariation
    
    ; First check for failure condition (highest priority)
    if (FindAndClick(failSafeColor, colorVariation)) {
        ToolTip("Failure detected! Handling recovery...", A_ScreenWidth//2, 20, 2)
        SetTimer(() => ToolTip(,,,2), -2000)
        currentObstacle := 1  ; Reset to first obstacle
        return
    }
    
    ; Then try current obstacle
    if (FindAndClick(obstacleColors[currentObstacle], colorVariation)) {
        ToolTip("Clicked obstacle " currentObstacle, A_ScreenWidth//2, 20, 2)
        SetTimer(() => ToolTip(,,,2), -1000)
        
        ; Move to next obstacle (loop back to first after last)
        currentObstacle := currentObstacle + 1
        if (currentObstacle > obstacleColors.Length)
            currentObstacle := 1
            
        return
    }
    
    ; If current obstacle not found, search for any obstacle in sequence
    Loop obstacleColors.Length {
        if (FindAndClick(obstacleColors[A_Index], colorVariation)) {
            ToolTip("Found obstacle " A_Index " out of sequence", A_ScreenWidth//2, 20, 2)
            SetTimer(() => ToolTip(,,,2), -1000)
            currentObstacle := A_Index + 1
            if (currentObstacle > obstacleColors.Length)
                currentObstacle := 1
            return
        }
    }
    
    ; If nothing found
    ToolTip("No obstacles detected", A_ScreenWidth//2, 20, 2)
    SetTimer(() => ToolTip(,,,2), -1000)
} ;}}}}

; Function to find and click a color {
FindAndClick(color, variation) {
    ; Define search area (adjust these for your game window)
    startX := 0
    startY := 0
    endX := A_ScreenWidth
    endY := A_ScreenHeight
    
    try {
        ; Search for the color
        searchResult := PixelSearch(&foundX, &foundY, startX, startY, endX, endY, color, variation)
        
        if (searchResult) {
            ; Add small random offset to avoid pattern detection
            randomX := foundX + RandomInt(0, 0)
            randomY := foundY + RandomInt(0, 0)
            
            ; Move and click
            MouseMove(randomX+3, randomY+8, 7)
            Sleep(RandomInt(100, 300))
            Click("Left")
            return true
        }
    }
    
    return false
} ;}}}

; Custom random integer function to avoid recursion
RandomInt(min, max) {
    Return min + Round(Random(0.0, 1.0) * (max - min))
}

; Escape key to exit
Esc:: {
    ToolTip()
    ExitApp()
}

; Initial instructions
ToolTip("OSRS Agility Bot - Press 1 to start/stop, 2 to pause/resume, Esc to exit", A_ScreenWidth//2, 0)
SetTimer(() => ToolTip(), -5000)