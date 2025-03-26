#IfWinActive ahk_exe cs2.exe  ; CS2 window focus (adjust to csgo.exe if testing CS:GO)

#NoEnv
SendMode Input
SetKeyDelay, 0
SetMouseDelay, 0
#SingleInstance Force  ; Ensures only one script instance runs

; Toggle for script (CapsLock to enable/disable)
global ScriptActive := 1  ; 1 = on, 0 = off
*CapsLock::
    ScriptActive := !ScriptActive
    if (ScriptActive) {
        SoundBeep, 500, 100  ; High beep = on
        TrayTip, CS2 Script, Enabled, 1
    } else {
        SoundBeep, 250, 100  ; Low beep = off
        TrayTip, CS2 Script, Disabled, 1
    }
return

; Shooting script with recoil control
*~Space::
    if (!ScriptActive)
        return

    ; Stop movement instantly
    ; Send {w up}
    ; Send {s up}
    ; Send {a up}
    ; Send {d up}

    ; Crouch on shoot (test if this works)
    ; Send {Ctrl down}  ; Using Ctrl for crouch (common CS2 binding)
    ; Sleep, 1

    ; Recoil compensation
    RecoilComp := 15  ; Increased for visibility
    ShotCount := 0      ; Track shots
    RecoilRandom := 0  ; Wider randomization
    multiplier := 0
    
    While GetKeyState("Space", "P") {
        ShotCount++
        CurrentRecoil := RecoilComp + (ShotCount * multiplier)  ; Stronger increase
        Random, RandVar, -RecoilRandom, RecoilRandom
        
        ; Try DllCall again with absolute movement flag (0x8000 | 0x0001)
        DllCall("mouse_event", "uint", 0x0001, "int", RandVar, "int", CurrentRecoil, "uint", 0, "int", 0)
        Sleep, 30
        Sendinput {Space}
    }

    ; Clean up
    ; Send {Ctrl up}
    ; Send {w up}{s up}{a up}{d up}
return


; Suspend script (Ctrl+Alt+S)
^!s::
    Suspend
    SoundBeep, % (A_IsSuspended ? 200 : 600), 100
    TrayTip, CS2 Script, % (A_IsSuspended ? "Suspended" : "Resumed"), 1
return




#IfWinActive