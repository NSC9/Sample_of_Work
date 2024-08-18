#IfWinActive, Diablo IV 

`::suspend

#Persistent  

toggle := false
allowed := false
lastFPress := 0
n := 200  

action() {
    global toggle, allowed, i, j, k, lastFPress

    if (toggle = true)
    {
        ; Check if 10 seconds (10000 ms) have passed since last `f` press
        if (A_TickCount - lastFPress >= 10000)
        {
            lastFPress := A_TickCount              
            sendinput {f}
            Sleep, n
            sendinput {c}
            Sleep, n
        }

        i += 1
        j += 1
        k += 1
        if Mod(i,15) != 0 ; spam d until otherwise special exceptions trigger
        {
            sendinput {d}
            Sleep, n
            if (allowed = true)
            {
                sendinput {b}
                Sleep, n
            }
        } 
        else ; "for every 40th iteration of this loop, then do the following:"
        {
            sendinput {b}
            Sleep, n
            allowed := true
        }  
        sendinput {r}
        Sleep, n
        sendinput {c}
        Sleep, n
        sendinput {q}
        Sleep, n
        sendinput {w}
        Sleep, n
    }
    return
}

a::
    global i, j, k
    i := 0  
    j := 0
    k := 0
    toggle := !toggle  
    if (toggle) {
        sendinput {c}
        Sleep, n
        sendinput {c}
        Sleep, n
        sendinput {c}
        Sleep, n
        sendinput {f}
        Sleep, 6*n     
        lastFPress := A_TickCount  ; Reset the timer when starting
        SetTimer, RunAction, 200
    } else {
        SetTimer, RunAction, Off 
    }
    return

RunAction:
    if (toggle) {
        action()
    }
    return
