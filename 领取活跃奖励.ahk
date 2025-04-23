#Requires AutoHotkey v2.0
#SingleInstance Force
WinActivate('ahk_id 983706')
MouseClick()
Sleep 200
Send '{Escape}'
Sleep 200
Send '^b'
Sleep 200
Send '{Escape}'
Sleep 200
Sleep 5000
MouseClick()
loop 5{
    Sleep 200
    Send '^{Tab}'
    Sleep 500
    Send '{Escape}'
    Sleep 200
    Send '^b'
    Sleep 200  
    Send '{Escape}'
    Sleep 200
}
MouseClick()
Sleep 500
loop 6{
    loop 5
    {
        Sleep 500
        MouseClick()
        Sleep 500
        Send '^{Tab}'
        Sleep 500
    }
    if A_Index==6
        break
    Sleep 500
    WinActivate('ahk_id 983706')
    Sleep 500
    MouseMove(60,0,,'R')
    Sleep 500
}