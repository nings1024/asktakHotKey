#Requires AutoHotkey v2.0
#SingleInstance Force
ask_id:=WinGetControlsHwnd('ahk_class AtTabWnd')[1]
WinGetClientPos(&x, &y, &w, &h, 'ahk_id' ask_id)
MsgBox IniRead('a.ini',w 'x' h,'我' )
