; this line is a comment.
; this code is for an Autohotkey script that works on the Windows 11 operating system. If you download Autohotkey, you must use the deprecated AHK version v1.1. 
; for Authotkey Installation, how to get the script running, and information on cyber security, see https://youtu.be/5g4filjx7eM?si=xZb8A3qP6wVRYuFZ
; It is recommended that the name of this file be changed on your local machine before use.
; The source code for this Authotkey script is located at https://github.com/NSC9/Sample_of_Work/tree/Main/AHKs/rs6.ahk

; Donate With Crypto:
; Bitcoin (BTC): bc1q2makllwj2h0shvheekyrsklhsa4syrrzutrmhr
; Litecoin (LTC): MDgCMYornMT2Rtho9tjX21wKqpqof6qYkf

; Created by https://github.com/NSC9 - GNUv3 License (https://www.gnu.org/licenses/)


; ---The actual code begins below---

; These two lines below ensure the script only works within the game window. Defaulted to Runelite
#IfWinActive,   RuneLite
; #IfWinActive,   Old School RuneScape

; This block of code is simply runetime enhancers/speed ups.
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

; this block of code allows one to shift-drag items while still being able to spam click the while left mouse button is held down. 
*Shift::
    if (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 500)
        return  ; Prevents action if the Shift key was recently pressed
    Send, {LButton Down}  ; Send left mouse button down click
    Sleep, 200            ; Wait for 200 milliseconds
    Send, {LButton Up}    ; Send left mouse button up click
return

*Shift Up::return  ; Ensures Shift key is handled properly when released

*LButton::
    Sendinput {Click} ; was send {Click}
    KeyWait, lButton, T0.11
    If ErrorLevel
    {
        While (GetKeyState("lButton", "P"))
        {
           Sendinput {Click}
           Sleep, 60
        }
        KeyWait, lButton
    }
return

#If
