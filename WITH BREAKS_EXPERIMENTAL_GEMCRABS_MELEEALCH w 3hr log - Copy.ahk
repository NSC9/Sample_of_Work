#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode "Input"
SetWorkingDir A_ScriptDir

; ────────────────────────────────────────────────
; CONFIG
; ────────────────────────────────────────────────
SearchRegionX := 200
SearchRegionY := 30
SearchRegionW := 1430
SearchRegionH := 900

Toggle := false
SearchTolerance := 12
CaveTolerance  := 35
RepotTolerance := 15

BaseInterval   := 2400

; Potion trigger
clickCount      := 0
clicksPerPotion := 80          ; adjust later to ~100–120

; Colors
MainColor      := unset
CaveColor      := unset
RepotColors    := []
CapturedMainHex := ""
CapturedCaveHex := ""

; ── Break timing ─────────────────────────────────
CycleDuration   := 3400000     ; ≈ 56–57 min → close to 1h
BreakMin        := 30 * 60000  ; 30 minutes in ms
BreakMax        := 40 * 60000  ; 40 minutes
NextCycleTime   := 0           ; when next break/check should happen

; Repot area
RepotRegion := {X1:1180, Y1:380, X2:1780, Y2:1080}

; ────────────────────────────────────────────────
; HOTKEYS
; ────────────────────────────────────────────────

^2::  ; Ctrl+2 = clear repot colors
{
    global RepotColors
    RepotColors := []
    ToolTip "Repot colors CLEARED", 10, 10
    SetTimer () => ToolTip(), -1800
}

3::   ; cave color
{
    global CaveColor, CapturedCaveHex
    CoordMode "Pixel", "Client"
    MouseGetPos &mx, &my
    col := PixelGetColor(mx, my)
    CaveColor := col
    CapturedCaveHex := Format("{:06X}", col)
    ToolTip "Cave: 0x" CapturedCaveHex, 10, 10
    SetTimer () => ToolTip(), -2500
}

2::   ; add repot color
{
    global RepotColors
    CoordMode "Pixel", "Client"
    MouseGetPos &mx, &my
    col := PixelGetColor(mx, my)
    RepotColors.Push(col)
    ToolTip "Repot color added (#" RepotColors.Length ")", 10, 10
    SetTimer () => ToolTip(), -2500
}

1::   ; toggle + crab color
{
    global Toggle, MainColor, CapturedMainHex, NextCycleTime, clickCount, RepotColors
    
    Toggle := !Toggle
    
    if (Toggle)
    {
        if !IsSet(CaveColor) || RepotColors.Length = 0
        {
            ToolTip "Need cave color (3) + at least 1 repot color (2)", 10, 10
            SetTimer () => ToolTip(), -4000
            Toggle := false
            return
        }
        
        CoordMode "Pixel", "Client"
        MouseGetPos &mx, &my
        col := PixelGetColor(mx, my)
        MainColor := col
        CapturedMainHex := Format("{:06X}", col)
        
        ToolTip "BOT STARTED`nCrab: 0x" CapturedMainHex "`nRepot colors: " RepotColors.Length, 10, 10
        SetTimer () => ToolTip(), -4000
        
        ; Schedule first cycle end (≈1h)
        NextCycleTime := A_TickCount + CycleDuration
        clickCount := 0
        
        SetNextSearch()
    }
    else
    {
        ToolTip "BOT STOPPED", 10, 10
        SetTimer SearchAndClick, 0
        SetTimer CheckCycleAndBreak, 0
        SetTimer () => ToolTip(), -2000
    }
}

^p::   ; Ctrl + P = force drink potion (TESTING)
{
    global clickCount
    DrinkPotion()
    ToolTip "FORCE DRINK triggered (click count was " clickCount ")", 10, 180
    SetTimer () => ToolTip(), -5000
}

; ────────────────────────────────────────────────
; HELPERS
; ────────────────────────────────────────────────

CheckCycleAndBreak()
{
    global NextCycleTime, Toggle, BreakMin, BreakMax
    
    if !Toggle
        return
    
    if (A_TickCount >= NextCycleTime)
    {
        ; ── ENTER BREAK MODE ───────────────────────
        ToolTip "TAKING 30–40 MIN BREAK...", 10, 30
        randomBreak := Random(BreakMin, BreakMax)
        
        ; Disable normal searching during break
        SetTimer SearchAndClick, 0
        
        Sleep randomBreak
        
        ; ── POST-BREAK LOGIN/RESUME SEQUENCE ───────
        ToolTip "Break finished – resuming...", 10, 30
        
        ; Your exact sequence
        Click 1021, 621
        Sleep 5000
        
        Click 1017, 550
        Sleep 15000
        
        Click 990, 690
        Sleep 5000
        
        ; Small extra safety delay before color search resumes
        Sleep 2000
        
        ; Reset click counter if desired (optional – comment out if not wanted)
        ; clickCount := 0
        
        ; Schedule next break
        NextCycleTime := A_TickCount + CycleDuration
        
        ; Resume normal operation
        SetNextSearch()
        
        ToolTip "Normal crab hunting resumed", 10, 30
        SetTimer () => ToolTip(), -4000
    }
}

SetNextSearch()
{
    global Toggle
    if Toggle
        SetTimer SearchAndClick, -2400
}

; ────────────────────────────────────────────────
; MAIN LOOP
; ────────────────────────────────────────────────

SearchAndClick()
{
    global Toggle, MainColor, CaveColor, SearchTolerance, CaveTolerance
    global SearchRegionX, SearchRegionY, SearchRegionW, SearchRegionH
    global RepotColors, RepotTolerance, RepotRegion
    global clickCount, clicksPerPotion
    
    if !Toggle
        return
    
    if WinExist("RuneLite")
    {
        if !WinActive("RuneLite")
            WinActivate "RuneLite"
    }
    else
    {
        SetNextSearch()
        return
    }
    
    CoordMode "Pixel", "Client"
    CoordMode "Mouse", "Client"
    
    ; ── CRAB ───────────────────────────────────────
    if PixelSearch(&fx, &fy, SearchRegionX, SearchRegionY, SearchRegionX+SearchRegionW-1, SearchRegionY+SearchRegionH-1, MainColor, SearchTolerance)
    {
        Send "{F4}"
        Sleep 80
        MouseMove 1450, 470, 0
        Sleep 80
        Click
        Sleep 80
        Send "{F2}"
        Sleep 80
        MouseMove 0, -2, 0, "R"
        Sleep 80
        Click
        Sleep 80
        
        MouseMove fx, fy, 0
        Sleep 80
        MouseMove 0, 65, 0, "R"
        Sleep 80
        Click
        Sleep 80
        
        clickCount++
        
        ToolTip "Crab #" clickCount "`nNext potion @ " (clicksPerPotion - Mod(clickCount, clicksPerPotion)), 10, 40
        
        if Mod(clickCount, clicksPerPotion) = 0
        {
            ToolTip "DRINKING POTION  #" clickCount, 10, 100
            DrinkPotion()
            SetTimer () => ToolTip(), -4000
        }
        
        SetNextSearch()
        return
    }
    
    ; ── CAVE fallback ──────────────────────────────
    if PixelSearch(&fx, &fy, SearchRegionX, SearchRegionY, SearchRegionX+SearchRegionW-1, SearchRegionY+SearchRegionH-1, CaveColor, CaveTolerance)
    {
        MouseMove fx, fy, 0
        Sleep 80
        MouseMove 0, 28, 0, "R"
        Sleep 80
        Click
        Sleep 80
        ToolTip "Cave clicked", 10, 70
        SetTimer () => ToolTip(), -1200
    }
    else
    {
        ToolTip "Nothing found", 10, 70
        SetTimer () => ToolTip(), -1200
    }
    
    SetNextSearch()
}

DrinkPotion()
{
    global RepotColors, RepotTolerance, RepotRegion
    
    for color in RepotColors
    {
        if PixelSearch(&rx, &ry, RepotRegion.X1, RepotRegion.Y1, RepotRegion.X2, RepotRegion.Y2, color, RepotTolerance)
        {
            MouseMove rx, ry, 0
            Sleep Random(90, 140)
            Send "{F2}"
            Sleep 80
            Send "{F2}"
            Sleep 80
            Click
            Sleep Random(80, 180)
            
            ToolTip "Potion clicked @ " rx "," ry, 10, 140
            SetTimer () => ToolTip(), -4000
            return
        }
    }
    
    ToolTip "No potion color found in region!", 10, 180
    SetTimer () => ToolTip(), -6000
}

; ────────────────────────────────────────────────
; TIMERS
; ────────────────────────────────────────────────

SetTimer CheckCycleAndBreak, 5000   ; check every 5 seconds if it's time for a break

Esc::ExitApp