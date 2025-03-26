#IfWinActive, vmware.exe
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

    ; Perform second randomized click
    Random, RandX2, -%PixelRandomRange%, %PixelRandomRange%
    Random, RandY2, -%PixelRandomRange%, %PixelRandomRange%

    #IfWinActive, RuneLite
    #NoEnv
    SendMode Input
    SetWorkingDir %A_ScriptDir%

    ; Set coordination mode for pixel and mouse
    CoordMode, Pixel, Window
    CoordMode, Mouse, Window

    ; Define the target color
    PrayRenewColor := 0xFF0A00FF ; Update this if necessary

    ; Get RuneLite window dimensions
    WinGetPos, WinX, WinY, WinWidth, WinHeight, RuneLite
    if (WinWidth < 1 or WinHeight < 1) {
        Tooltip, RuneLite window not found!
    return
    }


    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Green%, 100, Fast RGB
    if (ErrorLevel = 0) {
         MouseMove, %FoundX%, %FoundY%, 20 
         Sleep, RanSleep 
         Random, RandY,-30, -40
         MouseMove, 0, %RandY%, 15, R 
         Sleep, RanSleep
         Click, left
    } 

    ; Search for the target color within the RuneLite window
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Purple%, 50, Fast RGB
    if (!ErrorLevel) {
        ; Randomize pixel adjustments
        Random, RandX, -%PixelRandomRange%, %PixelRandomRange%
        Random, RandY, -%PixelRandomRange%, %PixelRandomRange%

        ; Move the mouse to the found pixel with random offsets and click
	MouseMove, %FoundX%, %FoundY%, 10 ; Smooth movement (Speed = 10)
	Sleep, 100
	MouseMove, 20, -30, 10, r; Smooth movement (Speed = 10)
	Sleep, 100
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
