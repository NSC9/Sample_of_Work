; this line is a comment or a line of code that does not get processed and has the purpose of explaining the details of code which is deliniated by the symbol ";" in the beginning of this line of code.

; this code is for an Autohotkey script that works on the Windows 11 operating system. If you download Autohotkey, you must use the deprecated v1.1. 

; this script is made by Professor Caudill at https://github.com/NSC9/Sample_of_Work. Direct message me on X/Twitter https://x.com/TheAI2C for questions. A video was made showcasing this script at https://www.youtube.com/@AI2C

; Reminder to change file extensions to ".ahk" and ensure file is saved as "all types." 

; For the paranoid, change the file name to something innocuous or run the game on a virtual machine with a lot of RAM. 


; Tips are accepted at these crypto addresses:

; Bitcoin (BTC): bc1qsnvyh62qavqgn4xgq2qravy2uysav3z0qp4nym

; Litecoin (LTC): ltc1qx4dsvmrddg6rgefcy22ts0hamjene8a9mvmyma


#IfWinActive, Diablo IV 

`::suspend

#Persistent  

toggle := false
lastFPress := 0
n := 100  

action() {
    global toggle, lastFPress

    if (toggle = true)
    {
        if (A_TickCount - lastFPress >= 10000)
        {
            lastFPress := A_TickCount              
            sendinput {f} ; change to your desired hotkey (this is health potion for me)
            Sleep, n
            sendinput {c} ; change to your desired hotkey (this is shadow step for me)
            Sleep, n
        }

        sendinput {r} ; change to your desired hotkey (this is shadow clone for me)
        Sleep, n
        sendinput {c} ; change to your desired hotkey (this is shadow step for me)
        Sleep, n
        sendinput {q} ; change to your desired hotkey (this is puncture for me)
        Sleep, n
        sendinput {w} ; change to your desired hotkey (this is barrage for me)
        Sleep, n
    }
    return
}

+a::
    toggle := !toggle  
    if (toggle) {
        sendinput {c} ; change to your desired hotkey (this is shadow step for me)
        Sleep, n
        sendinput {c}
        Sleep, n
        sendinput {c}
        Sleep, n
        sendinput {f} ; change to your desired hotkey (this is health potion for me)
        Sleep, 6*n     
        lastFPress := A_TickCount 
        SetTimer, RunAction, 110
    } else {
        SetTimer, RunAction, Off 
    }
    return

RunAction:
    if (toggle) {
        action()
    }
    return
