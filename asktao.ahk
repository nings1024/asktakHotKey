#SingleInstance Force
#Requires AutoHotkey v2.0
; 分辨率
resolution := ''
wns := WinGetList('ahk_class AtTabWnd')
if resolution == '' 
    if wns.Length > 0 {
        WinGetClientPos(, , &w, &h, 'ahk_id' WinGetControlsHwnd('ahk_id' wns[1])[1])
        resolution := w 'x' h
    }
#HotIf WinActive("ahk_class AtTabWnd") or WinActive("ahk_class AskTao")
WheelDown::{
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
    getX_Y('元魔', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
}



getX_Y( key, &x, &y) {
    t := IniRead('a.ini', resolution, key)
    x := Number(StrSplit(t, ' ')[1])
    y := Number(StrSplit(t, ' ')[2])
}


getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}