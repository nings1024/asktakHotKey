#SingleInstance Force
#Requires AutoHotkey v2.0

getid(&wnd_id, &asktao_id)
a()
b()
c()
WinActivate(wnd_id)
Sleep 500
; MouseMove(420,710)
MouseClick('Left',420,710)

; 打开esc
a() {
    WinActivate('ahk_id ' asktao_id)
    Sleep 100
    Send '{Escape}'
    Sleep 200

}
; 点击自动
b() {
    WinActivate('ahk_id ' wnd_id)
    Sleep 300
    MouseMove(360, 420) ; 自动位置
    Sleep 200
    MouseClick()
    Sleep 500
}
; 点击单人
c() {
    WinActivate('ahk_id ' wnd_id)
    Sleep 300
    MouseMove(400, 205) ; 单人位置
    Sleep 200
    MouseClick()
    Sleep 300
}

getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}
