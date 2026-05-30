; CSGO/CS2 AHK Script - Recoil Control + Null Movement + Return to Center on Release
#Requires AutoHotkey v2.0
#SingleInstance Force

; ===== GREEN DOT CROSSHAIR (Click-Through) =====
dot := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +E0x80000")
dot.BackColor := "Lime"
dot.Show("w3 h3 NoActivate")
dot.Move((A_ScreenWidth-3)//2, (A_ScreenHeight-6)//2)
WinSetTransColor("Black", dot)

; Track dot position for recoil movement
global dotX := (A_ScreenWidth-3)//2
global dotY := (A_ScreenHeight-6)//2

; Track total mouse movement during spray
global totalMoveX := 0
global totalMoveY := 0

; Counter variables
global adjustmentCounter := 0  ; Tracks which bullet we're on
global recoilMode := 1  ; 1 = AK47, 2 = M4, 3 = Glock, 4 = USP

; Pistol auto-fire toggle
global pistolFiring := false
global pistolFireTimer := 0

; Create tooltip timer (updates every 100ms)
SetTimer(UpdateTooltip, 100)

UpdateTooltip() {
    global adjustmentCounter, recoilMode
    ; ToolTip("Bullet: " adjustmentCounter " | Mode: " (recoilMode = 1 ? "AK47" : recoilMode = 2 ? "M4" : recoilMode = 3 ? "Glock" : "USP"))
}

; Only activate hotkeys when CS2 or CSGO is the active window
#HotIf WinActive("ahk_exe cs2.exe") || WinActive("ahk_exe csgo.exe")

; ===== MOUSE MOVEMENT HELPER FUNCTIONS =====
MoveMouse(x, y) {
    DllCall("mouse_event", "UInt", 0x0001, "UInt", x, "UInt", y, "UInt", 0, "UInt", 0)
}

; 4-line movement control helper
ApplyMovement(left, right, up, down) {
    global totalMoveX, totalMoveY
    moveX := -left + right
    moveY := -up + down
    if (moveX != 0 || moveY != 0) {
        MoveMouse(moveX, moveY)
        totalMoveX += moveX
        totalMoveY += moveY
    }
    return {x: moveX, y: moveY}
}

; Return mouse to original position
ReturnToOriginalPosition() {
    global totalMoveX, totalMoveY, dotX, dotY, dot
    
    ; Move mouse back by the total accumulated movement
    if (totalMoveX != 0 || totalMoveY != 0) {
        MoveMouse(-totalMoveX, -totalMoveY)
        
        ; Reset tracking variables
        totalMoveX := 0
        totalMoveY := 0
    }
    
    ; Reset dot to center of screen
    dotX := (A_ScreenWidth-3)//2
    dotY := (A_ScreenHeight-6)//2
    dot.Move(dotX, dotY, 3, 3)
}

; Apply recoil based on bullet number (synced with actual firing)
ApplyRecoilForBullet(bulletNum, mode) {
    global dotX, dotY, dot
    moveVals := {x: 0, y: 0}
    
    if (mode = 1) {  ; ===== AK47 MODE =====
        if (bulletNum >= 1 && bulletNum <= 3) {
            moveLeft_Amount := 0
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 20
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += -15
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 4 && bulletNum <= 6) {
            moveLeft_Amount := 0
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 20
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 7 && bulletNum <= 15) {
            moveLeft_Amount := 16
            moveRight_Amount := 12
            moveUp_Amount := 6
            moveDown_Amount := 21
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
        }
        else if (bulletNum >= 7 && bulletNum <= 10) {
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 11 && bulletNum <= 15) {
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 16 && bulletNum <= 19) {
            moveLeft_Amount := 3
            moveRight_Amount := 20
            moveUp_Amount := 10
            moveDown_Amount := 2
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 20 && bulletNum <= 25) {
            moveLeft_Amount := 14
            moveRight_Amount := 5
            moveUp_Amount := 5
            moveDown_Amount := 5
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 25 && bulletNum <= 35) {
            moveLeft_Amount := 0
            moveRight_Amount := 6
            moveUp_Amount := 0
            moveDown_Amount := 7
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
    }
    
    else if (mode = 2) {  ; ===== M4 MODE =====
        if (bulletNum >= 1 && bulletNum <= 3) {
            moveLeft_Amount := 0
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 16
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += -10
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 4 && bulletNum <= 6) {
            moveLeft_Amount := 0
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 16
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 7 && bulletNum <= 13) {
            moveLeft_Amount := 0
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 5
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
            dotX += 0
            dotY += 0
            dot.Move(dotX, dotY, 3, 3)
        }
        else if (bulletNum >= 13 && bulletNum <= 16) {
            moveLeft_Amount := 16
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 3
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
        }
        else if (bulletNum >= 17 && bulletNum <= 21) {
            moveLeft_Amount := 4
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 3
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
        }
    }
    
    else if (mode = 3) {  ; ===== GLOCK MODE (Semi-auto, toggle) =====
        ; Glock has minimal recoil - very small downward pull
        ; Adjust these values as needed
        if (bulletNum >= 1 && bulletNum <= 20) {
            moveLeft_Amount := 0
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 2   ; Small downward pull
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
        }
    }
    
    else if (mode = 4) {  ; ===== USP MODE (Semi-auto, toggle) =====
        ; USP has slightly more recoil than Glock but still minimal
        ; Adjust these values as needed
        if (bulletNum >= 1 && bulletNum <= 12) {
            moveLeft_Amount := 0
            moveRight_Amount := 0
            moveUp_Amount := 0
            moveDown_Amount := 1   ; Slightly more downward pull
            moveVals := ApplyMovement(moveLeft_Amount, moveRight_Amount, moveUp_Amount, moveDown_Amount)
        }
    }
}

; Pistol auto-fire function
PistolAutoFire() {
    global pistolFiring, adjustmentCounter, recoilMode, totalMoveX, totalMoveY
    
    if (!pistolFiring)
        return
    
    ; Increment bullet counter for recoil
    adjustmentCounter++
    
    ; Apply recoil for this shot
    ApplyRecoilForBullet(adjustmentCounter, recoilMode)
    
    ; Send click
    Send("{LButton}")
    
    ; Schedule next shot (100ms default, you can adjust this)
    SetTimer(PistolAutoFire, -80)
}

; Left click handler with toggle for pistols
~*LButton::
{
    global adjustmentCounter, recoilMode, dotX, dotY, dot, totalMoveX, totalMoveY, pistolFiring, pistolFireTimer
    
    ; Check if we're in pistol mode (Glock or USP)
    if (recoilMode = 3 || recoilMode = 4) {
        ; Toggle mode for pistols
        if (!pistolFiring) {
            ; Start firing
            pistolFiring := true
            adjustmentCounter := 0
            totalMoveX := 0
            totalMoveY := 0
            
            ; Fire first shot immediately
            adjustmentCounter := 1
            ApplyRecoilForBullet(1, recoilMode)
            Send("{LButton}")
            
            ; Start auto-fire timer (100ms between shots - adjust as needed)
            SetTimer(PistolAutoFire, -100)
        } else {
            ; Stop firing when clicking again
            pistolFiring := false
            SetTimer(PistolAutoFire, 0)
            
            ; Return mouse to original position
            ReturnToOriginalPosition()
            adjustmentCounter := 0
            ToolTip()
        }
        return
    }
    
    ; ===== AUTOMATIC WEAPONS (AK47 & M4) =====
    
    ; Reset tracking variables at start of spray
    totalMoveX := 0
    totalMoveY := 0

    ; Reset counter at start of each burst
    adjustmentCounter := 0
    
    ; Weapon timing (milliseconds between bullets)
    ; AK47: ~100ms, M4: ~90ms
    bulletDelay := (recoilMode = 1) ? 100 : 90

    ; Get the start time
    startTime := A_TickCount
    switched := false
    
    while GetKeyState("LButton", "P") {
        ; Calculate which bullet we're on based on TIME
        currentTime := A_TickCount - startTime
        currentBullet := Floor(currentTime / bulletDelay) + 1
        
        ; Only apply recoil when we actually fire a new bullet
        if (currentBullet > adjustmentCounter && currentBullet <= 31) {
            adjustmentCounter := currentBullet

            ; Apply recoil for this bullet
            ApplyRecoilForBullet(adjustmentCounter, recoilMode)
            
            ; Check if we need to switch with Q
            shouldSwitch := false
            
            if (recoilMode = 1 && adjustmentCounter = 31) {
                shouldSwitch := true
            }
            else if (recoilMode = 2 && adjustmentCounter = 22) {
                shouldSwitch := true
            }
            
            if (shouldSwitch && !switched) {
                switched := true
                Send("{LButton up}")
                Send("{3}")
                Sleep(50)
                break
            }
        }
        
        Sleep(5)
    }
    
    Send("{LButton up}")
    
    ; Return mouse to original position when LMB is released
    ReturnToOriginalPosition()
    
    adjustmentCounter := 0
    ToolTip()
}

; ===== RIGHT CLICK 180 TURN =====
~RButton::
{
    MoveMouse(3985, 0)
}

; ===== TOGGLE RECOIL MODE (O key) =====
O::
{
    global recoilMode, pistolFiring
    
    ; Stop pistol firing if active
    if (pistolFiring) {
        pistolFiring := false
        SetTimer(PistolAutoFire, 0)
    }
    
    ; Cycle through modes: 1=AK47, 2=M4, 3=Glock, 4=USP
    if (recoilMode = 1) {
        recoilMode := 2
        SoundBeep(880, 200)  ; High beep for M4
    } else if (recoilMode = 2) {
        recoilMode := 3
        SoundBeep(660, 200)  ; Medium-high beep for Glock
    } else if (recoilMode = 3) {
        recoilMode := 4
        SoundBeep(523, 200)  ; Medium beep for USP
    } else {
        recoilMode := 1
        SoundBeep(440, 200)  ; Low beep for AK47
    }
    
    modeName := (recoilMode = 1 ? "AK47" : recoilMode = 2 ? "M4" : recoilMode = 3 ? "Glock (Toggle)" : "USP (Toggle)")
    ToolTip("Recoil Mode: " modeName, A_ScreenWidth//2, A_ScreenHeight//2)
    SetTimer(() => ToolTip(), -1500)
}

; ===== GRENADE COMBO (F key) =====
F::
{
    Send("{f}")
    Sleep(1060)         
    Send("{click}")
    Sleep(30)
    Send("{e}")
}

; ===== TEST MOVEMENT (P key) =====
P::
{
    MoveMouse(0, 10)
}

#HotIf