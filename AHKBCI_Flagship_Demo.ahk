; these are comments
; this script is designed to improve human-machine bandwidth
; by creating shortcuts, automating repetitive tasks, making peripherals (mouse/keyboards) more comfortable
; all code is written in AutoHotKey, a programming language for Windows but Linux alternatives exist or one could use wine

#IfWinActive,   Some Windows Application
`::Suspend  ; this turns the script off
z::left  ; this rebinds keyboard button {z} to the left arrow key
x::right

*w::    ; this rebinds keyboard button {w} to send keyboard button Escape
	sendinput {Esc}
	return  

;this block of code makes the program run faster
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

x::  ; this assigns the keyboard button to do several things
	BlockInput, MouseMove  ; while this is executing, all human mouse movements are ignored
	Critical      ; tells the script to stop all other processes and run this immediately
	MouseGetPos xpos, ypos	; stores the current x,y coordinates of ones display as variables xpos and ypos
	SendInput {Click, 1197, 216, 1}   ; this performs a left mouse click at an x,y coordinate on the computers display
	Sleep, 20    ; this tells the script to wait 20 miliseconds before running the next line
	SendInput, {F4}   ; this does the same output as manually pressing f4 on the keyboard
	Sleep, 60    
	SendInput {Click, 1492, 532, 1}
	MouseMove, xpos, ypos , 0    ; this returns the mouse cursor to the original position
        Sleep, 60
	SendInput {Click, %xpos%, %ypos%,1}	
        Sleep, 20
	SendInput, {F1}
	BlockInput, MouseMoveOff    ; allows the user to control the mouse again
	Critical Off    ; turns off critical state
	return  ; says this block of code is done and to move on to the next lines of code

*lbutton::   ; this does things when the user is holding down the left mouse button 
    sendinput {Click} ; was send {Click}  ; when left mouse button is pressed, a left mouse click is executed
    KeyWait, lButton, T0.14; was T0.081   ; Wait 14 miliseconds if left button is pressed
    If ErrorLevel  ; if nothing fails, do this
    {
        While (GetKeyState("lButton", "P"))   ; do all of this in a loop while left mouse button is held down... This evaluates ands runs if GetKeyState is true
        {

	   Sendinput {Click}  ; send a left mouse click at current x,y coordinates
           Random, Rand, 15, 25 ; randomly generate a number between 15 and 25
           Sleep, %Rand%   ; do nothing for 15-25 milliseconds
        }
        KeyWait, lButton
    }
    return
