global RanSleep := 300

#IfWinActive, RuneLite
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Get RuneLite window position and size
WinGetPos, WinX, WinY, WinWidth, WinHeight, RuneLite
if (WinWidth < 1 or WinHeight < 1) {
    Tooltip, RuneLite window not found!
    SetTimer, HideTooltip, -2000
    Return
}

; Define search area within RuneLite window
SearchAreaLeft := WinX
SearchAreaTop := WinY
SearchAreaRight := WinX + WinWidth
SearchAreaBottom := WinY + WinHeight

; Target colors to search for (Hex)
TargetColor := 0xFFCF00EF ; object/npc marker
Green := 0xFF00FF3A
Purple := 0xFFCF00EF
Blue := 0x14C8AC
Cyan := 0x44D4A8

; Toggle key
ToggleKey := "F1"

; Initialize variables
clicking := false
OneMinuteInterval := 55000 ; 1 minute in milliseconds
LastOneMinuteTrigger := A_TickCount
clickPaused := false

; Set coordination mode for pixel and mouse
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; Hotkey to toggle clicking
Hotkey, %ToggleKey%, ToggleClicking

Return

ToggleClicking:
    clicking := !clicking
    if (clicking) {
        ; Generate a random interval between 300ms and 600ms
        Random, randomInterval, 300, 600
        SetTimer, ClickLoop, %randomInterval%
        Tooltip, Clicking started.
    } else {
        SetTimer, ClickLoop, Off
        Tooltip, Clicking stopped.
    }
    Return

ClickLoop:
    if (clickPaused) {
        Return
    }
    CurrentTime := A_TickCount ; Initialize current time
    ClickNPC()
    ClickGrid()
    CheckRedemption()
    MonitorGreenPixel()
    if ((CurrentTime - LastOneMinuteTrigger) >= OneMinuteInterval) {
        PauseClickLoop()
        TriggerOneMinuteEvent()
        ResumeClickLoop()
    }
    Return


ClickNPC() {
    global SearchAreaLeft, SearchAreaTop, SearchAreaRight, SearchAreaBottom, Purple
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Purple%, 20, Fast RGB
    if (!ErrorLevel) {
        Tooltip, Purple Pixel found!

        MouseMove, %FoundX%, %FoundY%, 10
        Random, RandYY, -5, -20
        MouseMove, 0, RandYY, 10, R
        Sleep, RanSleep
        Sendinput {Click}
        Sendinput {Escape}
        Sleep, RanSleep
    }
    Return
}

ClickGrid() {
    Loop, 4 {
        ; Determine the row and column of the current index
        row := (A_Index - 1) // 4
        col := Mod(A_Index - 1, 4)

        ; Define X and Y coordinates
        RandX := (col = 0 ? 1300 : col = 1 ? 1370 : col = 2 ? 1440 : 1509) + GenerateRandom(0, 20)
        RandY := (row = 0 ? 416 : row = 1 ? 480 : 540) + GenerateRandom(0, 20)

        ; Perform mouse movement and click
        MouseMove, RandX, RandY, 10
        Sleep, GenerateRandom(50, 100)
        Click, left
    }
    Return
}

MonitorGreenPixel() {
    global SearchAreaLeft, SearchAreaTop, SearchAreaRight, SearchAreaBottom, Green
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Green%, 20, Fast RGB
    if (!ErrorLevel) {
        StartTime := A_TickCount
        Loop {
            PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Green%, 20, Fast RGB
            if (ErrorLevel) {
                return
            }
            if (A_TickCount - StartTime >= 3000) {
                Break
            }
            Sleep, 10
        }
        ExecuteDrinkPrayerPotion()
    }
    Return
}

CheckRedemption() {
    global SearchAreaLeft, SearchAreaTop, SearchAreaRight, SearchAreaBottom, Blue
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Blue%, 20, Fast RGB
    if (ErrorLevel == 0) {
        Tooltip, Blue Pixel found!
    } else {
        PauseClickLoop()
        PerformMouseClicks(1252, 187)
        ResumeClickLoop()
    }
    Return
}

ExecuteDrinkPrayerPotion() {
    global SearchAreaLeft, SearchAreaTop, SearchAreaRight, SearchAreaBottom, Cyan
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Cyan%, 20, Fast RGB
    if (!ErrorLevel) {
        PauseClickLoop()
        MouseMove, %FoundX%, %FoundY%, 10
        Random, RandYY, -5, -20
        MouseMove, 0, RandYY, 10, R
        Sleep, RanSleep
        Sendinput {Click}
        Sleep, RanSleep
        ResumeClickLoop()
    }
    Return
}

PerformMouseClicks(X, Y) {
    global RanSleep
    Loop, 3 {
        MouseMove, %X%, %Y%, 10
        Random, RandXXX, 4, -4
        Random, RandYYY, 4, -4
        Sleep, RanSleep
        MouseMove, %RandXXX%, %RandYYY%, 10, R
        Click, left
    }
    Return
}
TriggerOneMinuteEvent() {
    global LastOneMinuteTrigger, RanSleep
    SendInput, {F4}
    Sleep, RanSleep
    MouseMove, 1290, 527, 20
    Sleep, RanSleep
    Loop, 1 {
        Random, RandY, -5, -5
        Random, RandX, -5, -5
        MouseMove, %RandX%, %RandY%, 15, R
        SendInput {Click} ; Corrected misplaced semicolon
        Sleep, 2 * RanSleep
    }
    SendInput, {F1}
    Sleep, RanSleep
    LastOneMinuteTrigger := A_TickCount
    Return
}



PauseClickLoop() {
    global clickPaused
    clickPaused := true
    SetTimer, ClickLoop, Off
    Return
}

ResumeClickLoop() {
    global clicking, clickPaused
    clickPaused := false
    if (clicking) {
        Random, randomInterval, 200, 400
        SetTimer, ClickLoop, %randomInterval%
    }
    Return
}

GenerateRandom(Min, Max) {
    Random, RandVal, %Min%, %Max%
    Return RandVal
}

HideTooltip:
    Tooltip
    Return
