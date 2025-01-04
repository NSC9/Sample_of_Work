; AHK version 1.1.37.02

; a useful autohotkey agility bot for seer's village course in the game old school runescape. Requires Runelite Object Market Plugin with objects colored in full with hex color #FFCF00EF. This script scans the user's computer screen from bottom to top. Thus, in-game compass should be pointed north. Randomization anti-cheat features are included to obfuscate the frequency and location of clicks. 




#IfWinActive, RuneLite
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%


; Target color to search for (Hex)
TargetColor := 0xFFCF00EF

; Toggle key
ToggleKey := "F1"

; Initialize variables
clicking := false

; Set coordination mode for pixel and mouse
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; Hotkey to toggle clicking
Hotkey, %ToggleKey%, ToggleClicking

Return

ToggleClicking:
    clicking := !clicking
    if (clicking) {
        ; Generate a random interval between 2000ms (2 seconds) and 5000ms (5 seconds)
        Random, randomInterval, 1000, 3000
        ; Start the click loop with a random interval
        SetTimer, ClickLoop, %randomInterval%
        Tooltip, Clicking started.
    } else {
        ; Stop the click loop when toggled off
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

    ; Search for the target color within the RuneLite window
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %TargetColor%, 50, Fast RGB
    if (!ErrorLevel) {
        ; Move the mouse to the found pixel and then click (keeping it inside the RuneLite window)
        MouseMove, %FoundX%, %FoundY%, 10 ; Add some smooth movement (Speed = 10)
	Sleep, 100
	; Generate random offsets for X and Y
	Random, RandX, 10, 20  ; Random horizontal movement between -30 and 30 pixels
	Random, RandY, -10, -20   ; Random vertical movement between 10 and 50 pixels

	; Move the mouse relative to the current position using the random values
	MouseMove, %RandX%, %RandY%, 10, R ; Speed = 10

	Sleep, 100
        Click, left
        Tooltip, Color found and clicked!
    } else {
        Tooltip, Color not found in RuneLite window!
    }

    ; Hide tooltip after a short delay
    SetTimer, HideTooltip, -2000
    Return

HideTooltip:
    Tooltip
    Return
