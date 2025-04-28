#Requires AutoHotkey v2.0
getid(&wnd_id, &asktao_id)
dtx('仙缘道人')
WinGetClientPos(,,&w,&h,'ahk_id ' wnd_id)
Sleep 500
; userclick(400,550)
while (true)
{
    ImageSearch(&x,&y,0,0,w,h,'C:\\pro\\aardio\\project\\服务端截图\\res\\仙缘道人.png')
    if x!=''
        userclick(400,550)
    ImageSearch(&x,&y,0,0,w,h,'C:\\pro\\aardio\\project\\服务端截图\\res\\接受.png')
    if x!=''
        userclick(400,550)
    Sleep 3000
}















userclick(x,y,*)
{
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
    MouseMove(x,y)
    Sleep 100
    MouseClick()
    Sleep 100
}


dtx(text) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' asktao_id)
    Send('!w')
    Send text
    Send '{Enter}'
}

getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}