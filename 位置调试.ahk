#SingleInstance Force
#Requires AutoHotkey v2.0

getid(&wnd_id, &asktao_id)
WinActivate(wnd_id)
getX_Y('守卫1',&lx,&ly)
MouseMove(lx,ly)

getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}
getX_Y( key, &x, &y) {
    t := IniRead('a.ini', '1000x750', key)
    x := Number(StrSplit(t, ' ')[1])
    y := Number(StrSplit(t, ' ')[2])
}
