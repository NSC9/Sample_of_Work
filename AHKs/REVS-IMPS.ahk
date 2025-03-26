; AHK version 1.1.37.02

#IfWinActive, RuneLite
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; Get the RuneLite window dimensions
WinGetPos, WinX, WinY, WinWidth, WinHeight, RuneLite

; Get the handle of the RuneLite window
WinGet, hwnd, ID, RuneLite

; Get the client area dimensions
VarSetCapacity(clientRect, 16, 0)
DllCall("GetClientRect", "ptr", hwnd, "ptr", &clientRect)
ClientWidth := NumGet(clientRect, 8, "Int")
ClientHeight := NumGet(clientRect, 12, "Int")

; Calculate offsets for the client area
BorderX := (WinWidth - ClientWidth) // 2  ; Horizontal border width
BorderY := WinHeight - ClientHeight - BorderX  ; Vertical border width (includes title bar)

; Define search area within the RuneLite client
SearchAreaLeft := WinX + BorderX
SearchAreaTop := WinY + BorderY
SearchAreaRight := WinX + BorderX + ClientWidth
SearchAreaBottom := WinY + BorderY + ClientHeight


; Calculate the client area offset (top-left corner of the client relative to the window)
borderX := winWidth - clientWidth
borderY := winHeight - clientHeight

; Target colors to search for (Hex)
Blue := 0xFF0A00FF 
Purple := 0xFFCF00EF 
Green := 0xFF00FF3A 
Red := 0xFFFF0000 
LiteBlue := 0xFF00FFE7
Yellow := 0xFFFFFA00
LitePurple := FF8D48FF
Brown := 0xFF894300

; Toggle key
ToggleKey := "F1"

; Initialize variables
clicking := false
OneMinuteInterval := 15000 ; 1 minute in milliseconds
LastOneMinuteTrigger := A_TickCount
clickPaused := false
Random, RanSleep, 100, 150

; Set coordination mode for pixel and mouse
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; Hotkey to toggle clicking
Hotkey, %ToggleKey%, ToggleClicking

Return

ToggleClicking:
    clicking := !clicking
    if (clicking) {
        Random, randomInterval, 6000, 6500
        SetTimer, ClickLoop, %randomInterval%
        Tooltip, Clicking started.
    } else {
        SetTimer, ClickLoop, Off
        Tooltip, Clicking stopped.
    }
    Return

ClickLoop:
    global LastOneMinuteTrigger, Red, Purple, Green, RanSleep
    if (clickPaused) {
        Return
    }
    CurrentTime := A_TickCount
    ; Get RuneLite window position and size
    WinGetPos, WinX, WinY, WinWidth, WinHeight, RuneLite
    if (WinWidth < 1 or WinHeight < 1) {
        Tooltip, RuneLite window not found!
        Return
    }

    ; Search for primary target color
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaTop%, %SearchAreaRight%, %SearchAreaBottom%, %Brown%, 50, Fast RGB
    if (!ErrorLevel) {
	Tooltip, Brown Pixel found! 

	MouseMove, %FoundX%, %FoundY%, 10 
	Random, RandYY, -15, -30
	MouseMove, 0, %RandYY%, 10, R                     ; clicks ground items
	Random, RanSleep, 100, 150
	Sleep, RanSleep
	Sendinput {Click}
	Sleep, 15*RanSleep

    }
    ; Search for Purple target color
    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaTop%, %SearchAreaRight%, %SearchAreaBottom%, %Purple%, 50, Fast RGB
    if (!ErrorLevel) {
	Tooltip, Purple Pixel found! 

	MouseMove, %FoundX%, %FoundY%, 10 
	Random, RandYY, -15, -30
	Random, RandXX, -5, 5
	MouseMove, %RandXX%, %RandYY%, 10, R                     ; clicks purple npcs
	Random, RanSleep, 100, 150
	Sleep, RanSleep
	Sendinput {Click}
    }


    PixelSearch, FoundX, FoundY, %SearchAreaLeft%, %SearchAreaTop%, %SearchAreaRight%, %SearchAreaBottom%, %Green%, 50, Fast RGB
    if (!ErrorLevel) {
	Tooltip, Green Pixel found! 
	Sleep, RanSleep
	MouseMove, %FoundX%, %FoundY%, 10 
	Random, RandYY, -15, -30
	MouseMove, 0, %RandYY%, 10, R                     ; clicks Green food
	Random, RanSleep, 100, 150
	Sleep, RanSleep
	Sendinput {Click}
    }


    if ((CurrentTime - LastOneMinuteTrigger) >= OneMinuteInterval) {
        PauseClickLoop()
        TriggerOneMinuteEvent()
        ResumeClickLoop()
    }

PauseClickLoop() {
    global clickPaused
    clickPaused := true
    SetTimer, ClickLoop, Off
}

ResumeClickLoop() {
    global clicking, clickPaused
    clickPaused := false
    if (clicking) {
        Random, randomInterval, 200, 400
        SetTimer, ClickLoop, %randomInterval%
    }
}

TriggerOneMinuteEvent() {
global LastOneMinuteTrigger, Purple, Green, RanSleep, MedRanSleep, LongRanSleep

CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; Define the target color

; Get RuneLite window dimensions
WinGetPos, WinX, WinY, WinWidth, WinHeight, RuneLite
if (WinWidth < 1 or WinHeight < 1) {
    Tooltip, RuneLite window not found!
    return
}

; Define search area within RuneLite window
SearchAreaLeft := WinX
SearchAreaTop := WinY
SearchAreaRight := WinX + WinWidth
SearchAreaBottom := WinY + WinHeight

medsleeptime1 := 100
medsleeptime2 := 300
longsleeptime1 := 800
longsleeptime2 := 1300
PixelSearch, FoundXX, FoundYY, %SearchAreaLeft%, %SearchAreaBottom%, %SearchAreaRight%, %SearchAreaTop%, %Purple%, 50, Fast RGB
if (ErrorLevel = 0) {
	return
} 

global LastOneMinuteTrigger
LastOneMinuteTrigger := A_TickCount
}

