#IfWinActive, RuneLite
#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir %A_ScriptDir%

; Configuration
SearchColor := 0xF2F2F2  ; Color from Window Spy: F2F2F2
SearchInterval := 100     ; ms between searches
SearchTolerance := 0

; Search the entire client area of RuneLite
SearchRegionX := 0        ; Start at top-left of client area
SearchRegionY := 0
SearchRegionW := 1534     ; Client width from Window Spy
SearchRegionH := 1009     ; Client height from Window Spy

; Toggle state
Toggle := false
ClickCounter := 0
MaxClicks := 1  ; Changed to 3 clicks
TargetX := 0
TargetY := 0
FoundLocation := false

; Hotkey - Space to toggle search
F9::
    Toggle := !Toggle
    if (Toggle)
    {
        ; Reset everything
        ClickCounter := 0
        TargetX := 0
        TargetY := 0
        FoundLocation := false
        
        ToolTip, Searching for color F2F2F2...
        SetTimer, SearchAndClickFiveTimes, %SearchInterval%
    }
    else
    {
        ToolTip, Search OFF
        SetTimer, SearchAndClickFiveTimes, Off
        SetTimer, HideToolTip, 2000
    }
return

; Main search and click subroutine
SearchAndClickFiveTimes:
    CoordMode, Pixel, Client
    CoordMode, Mouse, Client
    
    ; If we haven't found the initial location yet, search for it
    if (!FoundLocation)
    {
        ; Search for the target color anywhere in the region
        PixelSearch, FoundX, FoundY, SearchRegionX, SearchRegionY, SearchRegionX + SearchRegionW - 1, SearchRegionY + SearchRegionH - 1, SearchColor, SearchTolerance, Fast RGB
        
        if (ErrorLevel = 0)  ; Found the color for the first time
        {
            ; Store the location
            TargetX := FoundX
            TargetY := FoundY
            FoundLocation := true
            
            ToolTip, Found color at X:%TargetX% Y:%TargetY% - Starting 3 clicks...
            Sleep, 20
        }
        else
        {
            ; Color not found yet
            ToolTip, Searching for color F2F2F2...
            return
        }
    }
    
    ; If we have a target location and haven't reached max clicks
    if (FoundLocation && ClickCounter < MaxClicks)
    {
        ; Move to the target position
        MouseMove, %TargetX%, %TargetY%, 0
        Sleep, 20
        MouseMove, 0, 10, 0, r
        Sleep, 20
        ; Click at the target location
        Click
        ClickCounter++  ; FIXED: Increment the counter
        
        ; Show progress
        ToolTip, Click %ClickCounter%/%MaxClicks% at X:%TargetX% Y:%TargetY%
        
        ; If we've reached max clicks, stop
        if (ClickCounter >= MaxClicks)
        {
            ToolTip, Completed %MaxClicks% clicks! Stopping...
            SetTimer, SearchAndClickFiveTimes, Off
            Toggle := false
            SetTimer, HideToolTip, 3000
        }
    }
return

; Hide tooltip
HideToolTip:
    SetTimer, HideToolTip, Off
    ToolTip
return

#IfWinActive  ; End the context-sensitive hotkey