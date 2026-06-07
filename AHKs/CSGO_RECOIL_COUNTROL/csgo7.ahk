; =============================================================================
; CSGO/CS2 AHK Script - Recoil Control Only (Movement Lock Removed)
; =============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force

; =============================================================================
; GLOBAL VARIABLES
; =============================================================================
global visualDotX := 0
global visualDotY := 0
global isSpraying := false

; Track recoil pattern visually without moving mouse
VisualRecoilTracker() {
    global adjustmentCounter, recoilMode, visualDotX, visualDotY, dot, isSpraying
    
    if (!isSpraying)
        return
    
    ; Get the recoil value for current bullet (SAME as your actual recoil)
    recoil := GetRecoilForBullet(adjustmentCounter, recoilMode)
    
    ; Accumulate visual position (dot moves, mouse DOES NOT)
    visualDotX += recoil.x*0.005
    visualDotY += recoil.y *-0.18
    
    ; Move the dot to show where recoil is pulling
    newX := (A_ScreenWidth-3)//2 + visualDotX
    newY := (A_ScreenHeight-6)//2 + visualDotY
    dot.Move(newX, newY, 3, 3)
}

; =============================================================================
; GUI VISUAL ELEMENTS
; =============================================================================
; ----- GREEN DOT CROSSHAIR (Click-Through) -----
dot := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +E0x80000")
dot.BackColor := "Lime"
dot.Show("w3 h3 NoActivate")
dot.Move((A_ScreenWidth-3)//2, (A_ScreenHeight-6)//2)
WinSetTransColor("Black", dot)

; Create hollow circle gui for spray mode
sprayIndicator := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +E0x80000")
sprayIndicator.BackColor := "Lime"
sprayIndicator.Show("w20 h20 NoActivate Hide")
WinSetTransColor("Black", sprayIndicator)

; Track dot position for recoil movement
global dotX := (A_ScreenWidth-3)//2
global dotY := (A_ScreenHeight-6)//2

; Track total mouse movement during spray
global totalMoveX := 0
global totalMoveY := 0

; Counter variables
global adjustmentCounter := 0  ; Tracks which bullet we're on
global recoilMode := 1  ; 1 = AK47, 2 = M4 (pistol modes removed)

; Recoil adjustment mode (press M to toggle)
global adjustmentMode := false
global currentAdjustmentSet := 1  ; Which set of 3 bullets we're editing (1-10 for AK, 1-7 for M4)
global adjustmentX := 0
global adjustmentY := 0

; New variable for auto pistol swap
global autoSwapPistol := true  ; Set to false to disable auto pistol swap

; =============================================================================
; FILE PATHS & RECOIL DATA LOADING
; =============================================================================
scriptDir := A_ScriptDir
ak47File := scriptDir . "\ak47_recoil.txt"
m4File := scriptDir . "\m4_recoil.txt"

; ----- RECOIL DATA (Will be loaded from files) -----
; Initialize with empty arrays
AK47_Recoil := []
M4_Recoil := []

; Function to load recoil data from file
LoadRecoilData() {
    global AK47_Recoil, M4_Recoil
    global ak47File, m4File
    
    ; Load AK47 data
    if FileExist(ak47File) {
        AK47_Recoil := []
        loop read, ak47File {
            if (A_LoopReadLine != "") {
                parts := StrSplit(A_LoopReadLine, ",")
                if (parts.Length >= 4) {
                    AK47_Recoil.Push([Integer(parts[1]), Integer(parts[2]), Integer(parts[3]), Integer(parts[4])])
                }
            }
        }
    }
    
    ; If file doesn't exist or is empty, use default values
    if (AK47_Recoil.Length = 0) {
        AK47_Recoil := [
            [1, 3, 0, 7],       ; Set 1: Bullets 1-3
            [4, 6, 0, 7],       ; Set 2: Bullets 4-6
            [7, 9, 1, 7],       ; Set 3: Bullets 7-9
            [10, 12, 2, 7],     ; Set 4: Bullets 10-12
            [13, 15, 2, 7],     ; Set 5: Bullets 13-15
            [16, 18, 4, 7],     ; Set 6: Bullets 16-18
            [19, 21, 4, 6],     ; Set 7: Bullets 19-21
            [22, 24, 3, 6],     ; Set 8: Bullets 22-24
            [25, 27, 2, 5],     ; Set 9: Bullets 25-27
            [28, 30, 1, 5]      ; Set 10: Bullets 28-30
        ]
        SaveRecoilData()  ; Save defaults to file
    }
    
    ; Load M4 data
    if FileExist(m4File) {
        M4_Recoil := []
        loop read, m4File {
            if (A_LoopReadLine != "") {
                parts := StrSplit(A_LoopReadLine, ",")
                if (parts.Length >= 4) {
                    M4_Recoil.Push([Integer(parts[1]), Integer(parts[2]), Integer(parts[3]), Integer(parts[4])])
                }
            }
        }
    }
    
    if (M4_Recoil.Length = 0) {
        M4_Recoil := [
            [1, 3, 0, 6],       ; Set 1: Bullets 1-3
            [4, 6, 0, 6],       ; Set 2: Bullets 4-6
            [7, 9, 0, 6],       ; Set 3: Bullets 7-9
            [10, 12, 1, 5],     ; Set 4: Bullets 10-12
            [13, 15, 2, 5],     ; Set 5: Bullets 13-15
            [16, 18, 2, 4],     ; Set 6: Bullets 16-18
            [19, 20, 1, 3]      ; Set 7: Bullets 19-20
        ]
        SaveRecoilData()
    }
}

; Function to save recoil data to file
SaveRecoilData() {
    global AK47_Recoil, M4_Recoil
    global ak47File, m4File
    
    ; Save AK47
    ak47Content := ""
    for segment in AK47_Recoil {
        ak47Content .= segment[1] "," segment[2] "," segment[3] "," segment[4] "`n"
    }
    FileDelete(ak47File)
    FileAppend(ak47Content, ak47File)
    
    ; Save M4
    m4Content := ""
    for segment in M4_Recoil {
        m4Content .= segment[1] "," segment[2] "," segment[3] "," segment[4] "`n"
    }
    FileDelete(m4File)
    FileAppend(m4Content, m4File)
}

; Load recoil data on script start
LoadRecoilData()

; =============================================================================
; RECOIL HELPERS & UTILITIES
; =============================================================================
; Function to get recoil values for a bullet
GetRecoilForBullet(bulletNum, mode) {
    local recoilArray
    if (mode = 1)
        recoilArray := AK47_Recoil
    else if (mode = 2)
        recoilArray := M4_Recoil
    else
        return {x: 0, y: 0}
    
    for segment in recoilArray {
        if (bulletNum >= segment[1] && bulletNum <= segment[2]) {
            return {x: segment[3], y: segment[4]}
        }
    }
    return {x: 0, y: 0}
}

; Update tooltip to show current shot counter
SetTimer(UpdateTooltip, 50)

UpdateTooltip() {
    global adjustmentCounter, recoilMode, adjustmentMode, currentAdjustmentSet, adjustmentX, adjustmentY
    
    if (adjustmentMode) {
        maxSets := (recoilMode = 1) ? AK47_Recoil.Length : ((recoilMode = 2) ? M4_Recoil.Length : 0)
        ToolTip("ADJUSTMENT MODE`nWeapon: " ((recoilMode = 1) ? "AK47" : "M4") "`nSet " currentAdjustmentSet " of " maxSets "`nBullets: " GetSetBulletRange(recoilMode, currentAdjustmentSet) "`nMove X: " adjustmentX "`nMove Y: " adjustmentY "`nUse WASD to adjust, U to next set, Y to save and exit, ESC to cancel", A_ScreenWidth//2, A_ScreenHeight//3)
    } else {
        modeText := (recoilMode = 1) ? "AK47" : "M4"
        ToolTip("Shot: " adjustmentCounter " / " modeText, A_ScreenWidth//2, 50)
    }
}

; Helper function to get bullet range for a set
GetSetBulletRange(mode, setNum) {
    if (mode = 1) {
        if (setNum >= 1 && setNum <= AK47_Recoil.Length) {
            return AK47_Recoil[setNum][1] "-" AK47_Recoil[setNum][2]
        }
    } else if (mode = 2) {
        if (setNum >= 1 && setNum <= M4_Recoil.Length) {
            return M4_Recoil[setNum][1] "-" M4_Recoil[setNum][2]
        }
    }
    return "?"
}

; =============================================================================
; VISUAL INDICATOR FUNCTIONS
; =============================================================================
ShowSprayIndicator() {
    global sprayIndicator, dot
    
    dot.Hide()
    sprayIndicator.Show("NoActivate")
    sprayIndicator.Move((A_ScreenWidth-20)//2, (A_ScreenHeight-20)//2, 20, 20)
}

HideSprayIndicator() {
    global sprayIndicator, dot
    
    sprayIndicator.Hide()
    dot.Show("NoActivate")
    dot.Move((A_ScreenWidth-3)//2, (A_ScreenHeight-6)//2, 3, 3)
}

; =============================================================================
; MOUSE MOVEMENT HELPER FUNCTIONS
; =============================================================================
MoveMouse(x, y) {
    DllCall("mouse_event", "UInt", 0x0001, "UInt", x, "UInt", y, "UInt", 0, "UInt", 0)
}

; Apply recoil based on bullet number
ApplyRecoilForBullet(bulletNum, mode) {
    global totalMoveX, totalMoveY
    recoil := GetRecoilForBullet(bulletNum, mode)
    
    if (recoil.x != 0 || recoil.y != 0) {
        MoveMouse(recoil.x, recoil.y)
        totalMoveX += recoil.x
        totalMoveY += recoil.y
    }
}

; Return mouse to original position
ReturnToOriginalPosition() {
    global totalMoveX, totalMoveY, dotX, dotY, dot
    
    if (totalMoveX != 0 || totalMoveY != 0) {
        MoveMouse(-totalMoveX, -totalMoveY)
        totalMoveX := 0
        totalMoveY := 0
    }
    
    dotX := (A_ScreenWidth-3)//2
    dotY := (A_ScreenHeight-6)//2
    dot.Move(dotX, dotY, 3, 3)
}

; =============================================================================
; MAIN SPRAY FUNCTION - Reusable for both LButton and RButton
; =============================================================================
StartSpray() {
    global adjustmentCounter, recoilMode, totalMoveX, totalMoveY, adjustmentMode, isSpraying, visualDotX, visualDotY, autoSwapPistol
    
    if (adjustmentMode) {
        return
    }
    
    ; Only apply recoil control for rifle modes (1=AK47, 2=M4)
    if (recoilMode = 1 or recoilMode = 2) {
        ; WASD locking removed - movement is no longer blocked
        
        Send("{k down}")
        Sleep(1)
        
        ; Start spraying tracking
        isSpraying := true
        visualDotX := 0
        visualDotY := 0
        adjustmentCounter := 0
        totalMoveX := 0
        totalMoveY := 0
        
        ; Use proper bullet timing
        bulletDelay := (recoilMode = 1) ? 100 : 90
        startTime := A_TickCount
        
        ; Get max bullets for current weapon
        maxBullets := (recoilMode = 1) ? 30 : 23
        
        while GetKeyState("LButton", "P") || GetKeyState("RButton", "P") {
            currentTime := A_TickCount - startTime
            currentBullet := Floor(currentTime / bulletDelay) + 1
            
            if (currentBullet > adjustmentCounter && currentBullet <= maxBullets) {
                adjustmentCounter := currentBullet
                ApplyRecoilForBullet(adjustmentCounter, recoilMode)
                VisualRecoilTracker()
                
                ; Check if we've reached max bullets
                if (adjustmentCounter = maxBullets) {
                    break
                }
            }
            
            Sleep(1)
        }
        
        ; Cleanup
        Send("{k up}")
        
        ReturnToOriginalPosition()
        
        ; Auto swap to pistol after spraying full magazine
        if (autoSwapPistol && (adjustmentCounter = maxBullets)) {
            Sleep(50)  ; Small delay for better timing
            Send("{3}")  ; Swap to pistol (slot 3)
        }
        
        adjustmentCounter := 0
        isSpraying := false
        
        visualDotX := 0
        visualDotY := 0
        dot.Move((A_ScreenWidth-3)//2, (A_ScreenHeight-6)//2, 3, 3)
        
        ; WASD unlocking removed - no longer needed
    }
    ; For pistols and other weapons, just send normal click (no recoil control)
    else {
        Send("{LButton}")
    }
}

; =============================================================================
; ADJUSTMENT MODE FUNCTIONS
; =============================================================================
; Save current values to the active set
SaveCurrentSetValues() {
    global currentAdjustmentSet, adjustmentX, adjustmentY, recoilMode
    
    if (recoilMode = 1) {
        if (currentAdjustmentSet >= 1 && currentAdjustmentSet <= AK47_Recoil.Length) {
            AK47_Recoil[currentAdjustmentSet][3] := adjustmentX
            AK47_Recoil[currentAdjustmentSet][4] := adjustmentY
        }
    } else if (recoilMode = 2) {
        if (currentAdjustmentSet >= 1 && currentAdjustmentSet <= M4_Recoil.Length) {
            M4_Recoil[currentAdjustmentSet][3] := adjustmentX
            M4_Recoil[currentAdjustmentSet][4] := adjustmentY
        }
    }
    
    ; Save changes to file immediately
    SaveRecoilData()
}

; Load current values from the active set
LoadCurrentSetValues() {
    global currentAdjustmentSet, adjustmentX, adjustmentY, recoilMode
    
    if (recoilMode = 1) {
        if (currentAdjustmentSet >= 1 && currentAdjustmentSet <= AK47_Recoil.Length) {
            adjustmentX := AK47_Recoil[currentAdjustmentSet][3]
            adjustmentY := AK47_Recoil[currentAdjustmentSet][4]
        }
    } else if (recoilMode = 2) {
        if (currentAdjustmentSet >= 1 && currentAdjustmentSet <= M4_Recoil.Length) {
            adjustmentX := M4_Recoil[currentAdjustmentSet][3]
            adjustmentY := M4_Recoil[currentAdjustmentSet][4]
        }
    }
}

; =============================================================================
; HOTKEYS - CONDITIONAL (Only active in CS2/CSGO)
; =============================================================================
#HotIf WinActive("ahk_exe cs2.exe") || WinActive("ahk_exe csgo.exe")

; ----- WASD - No longer blocked, passes through normally -----
*w::Send("{w down}")
*w up::Send("{w up}")
*a::Send("{a down}")
*a up::Send("{a up}")
*s::Send("{s down}")
*s up::Send("{s up}")
*d::Send("{d down}")
*d up::Send("{d up}")

; ----- LEFT CLICK - Primary Fire + Recoil Control -----
~*LButton::
{
    StartSpray()
}

; ----- RIGHT CLICK - Toggles between Main Weapon (E) and Knife (Q)
; Also preserves original right-click behavior if needed

toggleState := 0  ; 0 = Main Weapon (E), 1 = Knife (Q)

~*RButton::
{
    global toggleState
    
    ; Toggle the state
    toggleState := !toggleState
    
    if (toggleState = 0)
    {
        ; Send main weapon key (E)
        Send("{E}")
    }
    else
    {
        ; Send knife key (Q)
        Send("{Q}")
    }
    
    ; Optional: Small delay if your game needs it for weapon switch
    ; Sleep 50
}

; ----- GRENADE COMBO (F key) -----
~f::
{
    Sleep(1060)
    Send("K}")
    Sleep(30)
    Send("{e}")
}

; ----- RELOAD COMBO (R key) -----
~*r::
{
    global adjustmentMode, recoilMode
    
    if (adjustmentMode) {
        Send("{r}")
        return
    }
    
    Send("{r}")
    Sleep(1520)
    Sleep(50)
    
    Send("{q}")
    Sleep(50)
    
    Send("{e}")
}

; ----- TOGGLE AUTO PISTOL SWAP (N key) - New hotkey -----
N::
{
    global autoSwapPistol
    autoSwapPistol := !autoSwapPistol
    ToolTip("Auto Pistol Swap: " (autoSwapPistol ? "ON" : "OFF"), A_ScreenWidth//2, 100)
    SetTimer(() => ToolTip(), -1500)
}

; ----- TOGGLE RECOIL MODE (O key) - Now only cycles AK47/M4 -----
O::
{
    global recoilMode, adjustmentMode
    
    if (adjustmentMode)
        return
    
    if (recoilMode = 1) {
        recoilMode := 2
    } else {
        recoilMode := 1
    }
}

; ----- TEST MOVEMENT (P key) -----
P::
{
    MoveMouse(0, 10)
}

; ----- RECOIL ADJUSTMENT MODE (Press M to toggle) -----
M::
{
    global adjustmentMode, currentAdjustmentSet, adjustmentX, adjustmentY, recoilMode
    
    if (!adjustmentMode) {
        ; Enter adjustment mode
        adjustmentMode := true
        currentAdjustmentSet := 1
        adjustmentX := 0
        adjustmentY := 0
        
        ; Load current values for set 1
        LoadCurrentSetValues()
        
        ToolTip("RECOIL ADJUSTMENT MODE ENABLED`nUse WASD to adjust values for current set`nU = Next Set, Y = Save and Exit, ESC = Cancel", A_ScreenWidth//2, A_ScreenHeight//3)
    } else {
        ; Exit adjustment mode
        adjustmentMode := false
        ToolTip()
    }
}

; ----- ADJUSTMENT MODE CONTROLS -----
#HotIf adjustmentMode && (WinActive("ahk_exe cs2.exe") || WinActive("ahk_exe csgo.exe"))

W::  ; Move up (reduce Y)
{
    global adjustmentY, currentAdjustmentSet, recoilMode, adjustmentX
    adjustmentY -= 1
    maxSets := (recoilMode = 1) ? AK47_Recoil.Length : ((recoilMode = 2) ? M4_Recoil.Length : 0)
    ToolTip("Set " currentAdjustmentSet " of " maxSets "`nBullets: " GetSetBulletRange(recoilMode, currentAdjustmentSet) "`nX=" adjustmentX ", Y=" adjustmentY "`nPress Y to save and exit", A_ScreenWidth//2, A_ScreenHeight//3)
}

S::  ; Move down (increase Y)
{
    global adjustmentY, currentAdjustmentSet, recoilMode, adjustmentX
    adjustmentY += 1
    maxSets := (recoilMode = 1) ? AK47_Recoil.Length : ((recoilMode = 2) ? M4_Recoil.Length : 0)
    ToolTip("Set " currentAdjustmentSet " of " maxSets "`nBullets: " GetSetBulletRange(recoilMode, currentAdjustmentSet) "`nX=" adjustmentX ", Y=" adjustmentY "`nPress Y to save and exit", A_ScreenWidth//2, A_ScreenHeight//3)
}

A::  ; Move left (decrease X)
{
    global adjustmentX, currentAdjustmentSet, recoilMode, adjustmentY
    adjustmentX -= 1
    maxSets := (recoilMode = 1) ? AK47_Recoil.Length : ((recoilMode = 2) ? M4_Recoil.Length : 0)
    ToolTip("Set " currentAdjustmentSet " of " maxSets "`nBullets: " GetSetBulletRange(recoilMode, currentAdjustmentSet) "`nX=" adjustmentX ", Y=" adjustmentY "`nPress Y to save and exit", A_ScreenWidth//2, A_ScreenHeight//3)
}

D::  ; Move right (increase X)
{
    global adjustmentX, currentAdjustmentSet, recoilMode, adjustmentY
    adjustmentX += 1
    maxSets := (recoilMode = 1) ? AK47_Recoil.Length : ((recoilMode = 2) ? M4_Recoil.Length : 0)
    ToolTip("Set " currentAdjustmentSet " of " maxSets "`nBullets: " GetSetBulletRange(recoilMode, currentAdjustmentSet) "`nX=" adjustmentX ", Y=" adjustmentY "`nPress Y to save and exit", A_ScreenWidth//2, A_ScreenHeight//3)
}

u::  ; Cycle to next set (U key)
{
    global currentAdjustmentSet, adjustmentX, adjustmentY, recoilMode, adjustmentMode
    
    if (!adjustmentMode)
        return
    
    ; Save current set values before moving
    SaveCurrentSetValues()
    
    maxSets := (recoilMode = 1) ? AK47_Recoil.Length : ((recoilMode = 2) ? M4_Recoil.Length : 0)
    
    ; Move to next set (wrap around to 1)
    currentAdjustmentSet++
    if (currentAdjustmentSet > maxSets)
        currentAdjustmentSet := 1
    
    ; Reset adjustment values to zero for display (will be loaded from the set)
    adjustmentX := 0
    adjustmentY := 0
    
    ; Load values from the new set
    LoadCurrentSetValues()
    
    ToolTip("Switched to Set " currentAdjustmentSet " of " maxSets "`nBullets: " GetSetBulletRange(recoilMode, currentAdjustmentSet) "`nCurrent X=" adjustmentX ", Y=" adjustmentY, A_ScreenWidth//2, A_ScreenHeight//3)
    SetTimer(() => ToolTip(), -2000)
}

y::  ; Save all changes and exit adjustment mode (Y key)
{
    global adjustmentMode, currentAdjustmentSet, adjustmentX, adjustmentY
    
    if (!adjustmentMode)
        return
    
    ; Save current values before exiting
    SaveCurrentSetValues()
    
    ; Exit adjustment mode
    adjustmentMode := false
    
    ToolTip("Changes saved! Exited adjustment mode", A_ScreenWidth//2, A_ScreenHeight//3)
    SetTimer(() => ToolTip(), -1500)
}

Enter::  ; Save current set (without exiting)
{
    global currentAdjustmentSet, adjustmentX, adjustmentY
    
    ; Save current values
    SaveCurrentSetValues()
    
    ToolTip("Saved Set " currentAdjustmentSet "! (X=" adjustmentX ", Y=" adjustmentY ")`nPress U to edit next set, Y to save all and exit", A_ScreenWidth//2, A_ScreenHeight//3)
    SetTimer(() => ToolTip(), -1500)
}

Esc::  ; Exit adjustment mode without saving current changes
{
    global adjustmentMode
    adjustmentMode := false
    ToolTip("Exited adjustment mode (changes NOT saved to current set)", A_ScreenWidth//2, A_ScreenHeight//3)
    SetTimer(() => ToolTip(), -1500)
}

#HotIf