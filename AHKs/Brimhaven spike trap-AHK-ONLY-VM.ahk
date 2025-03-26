#IfWinActive, RuneLite
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Minimum and maximum interval between clicks (in milliseconds)
MinClickInterval := 300  ; Minimum interval
MaxClickInterval := 1000  ; Maximum interval

; Pixel randomization range (1-5 pixels)
PixelRandomRange := 15
Random, randsleep, 1000, 2000

; Target color to search for (Hex)
Purple := 0xFFCF00EF
Green := 0xFF00FF3A 

; Toggle key
ToggleKey := "F1"

; Initialize variables
clicking := false

; Set coordination mode for pixel and mouse
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; Hotkey to toggle clicking
Hotkey, %ToggleKey%, ToggleClicking

; Main loop
Return

ToggleClicking:
    clicking := !clicking
    if (clicking) {
        Random, InitialInterval, %MinClickInterval%, %MaxClickInterval%
        SetTimer, ClickLoop, %InitialInterval%
        Tooltip, Clicking started.
    } else {
        SetTimer, ClickLoop, Off
        Tooltip, Clicking stopped.
    }
    Return

ClickLoop:
    ; Activate RuneLite window
    WinActivate, RuneLite
    Sleep, 100 ; Small delay to ensure activation

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


    ; Search for the target color within the RuneLite window
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Purple%, 50, Fast RGB
    if (!ErrorLevel) {

        ; Move the mouse to the found pixel with random offsets and click
        MouseMove, %FoundX% , %FoundY%, 10 ; Smooth movement (Speed = 10)
        Sleep, 100
	MouseMove, 0, -20, 10, R ; Smooth movement (Speed = 10)
        Click, left

        Tooltip, Color found and clicked!
    } else {
        Tooltip, Color not found in RuneLite window!
    }

    ; Hide tooltip after a short delay
    SetTimer, HideTooltip, -2000

    ; Set the timer with a new randomized interval
    Random, NewInterval, %MinClickInterval%, %MaxClickInterval%
    SetTimer, ClickLoop, %NewInterval%
    Return

HideTooltip:
    Tooltip
    Return
