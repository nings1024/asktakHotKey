#Requires AutoHotkey v2.0
#SingleInstance Force
wns:=WinGetList('ahk_class AtTabWnd')
WinActivate('ahk_id' wns[1])
MouseMove(835,690)