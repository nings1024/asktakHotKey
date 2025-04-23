#Requires AutoHotkey v2.0
#SingleInstance force
wns:=WinGetList('ahk_class AtTabWnd')
wnd_id:=wns[2]
asktao_id:=WinGetControlsHwnd('ahk_id' wnd_id)[1]
WinGetClientPos(&x, &y, &w, &h, "ahk_id " wnd_id )
MsgBox  x "," y "," w "," h
