; this line is a comment or a line of code that does not get processed and has the purpose of explaining the details of code which is deliniated by the symbol ";" in the beginning of this line of code.

; this code is for an Autohotkey script that works on the Windows 11 operating system. If you download Autohotkey, you must use the deprecated v1.1. 

; this script is made by Professor Caudill at https://github.com/NSC9/Sample_of_Work. Direct message me on X/Twitter https://x.com/TheAI2C for questions. A video was made showcasing this script at https://www.youtube.com/@AI2C

; Tips are accepted at these crypto addresses:

; Bitcoin (BTC): bc1qsnvyh62qavqgn4xgq2qravy2uysav3z0qp4nym

; Litecoin (LTC): ltc1qx4dsvmrddg6rgefcy22ts0hamjene8a9mvmyma




; my barrage rogue character was built following Lexyu's guide https://www.icy-veins.com/d4/guides/barrage-rogue-build/
; the guide explains why it is important to prioritize certain Barrage Imbuements depending on if you are farming mobs or killing final bosses, which is the reason for some sections of this code 

; if the script gets stuck in an infinite loop, simply press control+alt+delete, press cancel, (if fullscreeen, press windows key), press arrow on toolbar, right-click Autohotkey script, click "Exit". Reload the script. (Sometimes suspend does not work when its bugged). 


; the actual executable code now begins at the next line. This line makes it so the script does not do anything outside the diablo iv game window. 

#IfWinActive,   Diablo IV 

; this next line allows the user to turn off the script with the "`" button

`::suspend

; these next few lines of code allows the user to play diablo with one button (for the most part...I may sometimes right click to Shadow Step ability to avoid damage or left click to do things outside of combat). 

; note: I am holding the button "d" for the entirety of engaged combat. 

*d::

    ; this block of code contains optional runtime enhancers to try to make everything run (computationally process) as fast as possible.
    #NoEnv
    SetWorkingDir %A_ScriptDir%
    CoordMode, Mouse, Client
    SendMode Input
    #SingleInstance Force
    SetTitleMatchMode 2
    #WinActivateForce
    #MaxHotkeysPerInterval 3000
    SetControlDelay 1
    SetWinDelay 0
    SetKeyDelay -1
    SetMouseDelay -1
    SetBatchLines -1

    ; main section 

    ; these lines drink a health potion with hotkey "f" to grant me damage boost for 8 seconds from the ability Unstable Exixirs. I then spam button "c" which Dash into an enemy. 
    sendinput {f}
    Sleep, 80
    sendinput {c}
	
    KeyWait, d, T0.105

    ; this next few lines of code creates a while loop that does all our combat ability rotations. 
    If ErrorLevel
    {
        ; think of the following variable i as a time variable which will create events depending on its remainder when divided by a number (study the modulus math function). 
        ; the whole point of the variable i is so that our ability Cold Imbuement activites immediately off cooldown and if i is has a remainder of 0 when divided, we cast Shadow Imbuement to optimize cooldowns. 
        ; for diablo gamers, I manually swap the abilities on the bar depending on if I am farming infernal horde (Season Five) waves or before the final boss. Cold Imbuement is priority cooldown for bosses, shadows for waves. 
	  i = 0 
        ; this next variable is another time variable but was made to act independly to redrink a health potion to refresh the ability Dash and to refresh damage from the legendary paragon Tricks of the Trade
	  k = 0

        ; these next few lines include loop that cycles through our abilities. Basically the script checks if button "d" is pressed and does actions when True. 
        While (GetKeyState("d", "P"))
        {

           ; these iterate our initial time variables.  
	     i += 1
	     k += 1

           ; this section is dedicated to Cold/Shadow Imbuements. If I was doing a boss, Cold Imbuement would be assigned to key "a" in the ingame ability bar. 
           ; I manually swap them depending on what combat I am doing. 
           ; I change the value of the modulus number (e.g. 15) to choose when to cast the non-priority cooldown.
           ; the point is to have the time scaled/stretched/manipulated to optimize imbuement ability up-time.
           ; these line redefines our variable to account for cycle lag between the priority and non-priority cooldowns to optimize boosted damage up-times. 
           if Mod(i,27) != 0
	     {
	        sendinput {a}
           } else {
              sendinput {b}
           }

           ; this section specifies when to redrink a health potion to refresh the ability Unstable Exixirs and when to cast Dash to refresh the damage boosts gained from the legendary paragon Tricks of the Trade
           if Mod(k,80) = 0
           {
              sendinput {f}
              Sleep, 30
              sendinput {c}
           }
	     Sleep, 30

           ; the key "w" casts the ability Barrage
	     sendinput {w}
	     Sleep, 30
           ; the key "Space" or spacebar casts the ability Evade
	     sendinput {Space}
           Sleep, 30
           ; the key "q" casts the ability Puncture
	     sendinput {q}
	     Sleep, 30

        }
        KeyWait, lButton
    }
    return
	
; final note: I find it best to autocast Dash/Shadow Imbue for trash and autocast Shadow Step/Cold Imbue for final bosses.