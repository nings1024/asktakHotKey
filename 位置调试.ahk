#SingleInstance Force
#Requires AutoHotkey v2.0

getid(&wnd_id, &asktao_id)
WinActivate(wnd_id)
MouseMove(884,230)

getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}


; GET请求示例
HttpGet(url) {
    req := ComObject("MSXML2.XMLHTTP")
    req.open("GET", url, false) ; 同步请求
    req.send()
    return req.responseText
}

