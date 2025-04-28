#SingleInstance Force
#Requires AutoHotkey v2.0

getid(&wnd_id, &asktao_id)
WinActivate(wnd_id)
WinGetClientPos(,,&w,&h,'ahk_id ' wnd_id)
response := HttpGet("http://127.0.0.1:8999?hwnd=721332&t=仙缘道人")
goal:=StrSplit(response,' ')
; MsgBox('相似度'  goal[1])
; MsgBox('相似度'  goal[2])
; MsgBox('相似度'  goal[3])
ImageSearch(&x,&y,0,0,w,h, "C:\\pro\\aardio\\project\\服务端截图\\res\\仙缘道人.png")
MouseMove(x,y)


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

