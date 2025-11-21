#SingleInstance Force
#Requires AutoHotkey v2.0
resolution := ''
wns := WinGetList('ahk_class AtTabWnd')
if resolution == '' 
    if wns.Length > 0 {
        WinGetClientPos(, , &w, &h, 'ahk_id' WinGetControlsHwnd('ahk_id' wns[1])[1])
        resolution := w 'x' h
    }
getid(&wnd_id, &asktao_id)
WinActivate(wnd_id)
getX_Y('购买位置',&lx,&ly)

MouseMove(lx,ly)

getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}
getX_Y( key, &x, &y) {
    t := IniRead('a.ini', resolution, key)
    x := Number(StrSplit(t, ' ')[1])
    y := Number(StrSplit(t, ' ')[2])
}
