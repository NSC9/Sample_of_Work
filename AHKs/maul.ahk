setdefaultmousespeed 1

f6:: ;f12 hotkey; you might want to use a different hotkey
    MouseGetPos, StartX, StartY
    send {f1}
    click 1405, 925
    click, StartX, StartY
    send {f5}
    click 1509, 875
    click 1509, 875
    MouseMove, StartX, StartY
    click, StartX, StartY
return

