#Requires AutoHotkey v2.0
#SingleInstance Force
global t:=0
xunlu := Gui('AlwaysOnTop')
addButton('段铁心',350,480)
addButton('帮派使者',500,500)
addButton('神算子',355,480)
xunlu.Add('Button','x10 y' String(10+t*30) ' w100 h30' , '修理装备').OnEvent('Click', Fixgear)
t+=1
xunlu.Add('Button','x10 y' String(10+t*30) ' w100 h30' , '幡子').OnEvent('Click', fanzi)
xunlu.Show('x1292 y374 w300')

fanzi(btn,*){
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' asktao_id)
    Sleep 100
    Send '^b'
    Sleep 100
    Send '!f'
    Sleep 200
    WinActivate('ahk_id ' wnd_id)
    Sleep 500
    MouseMove(800,540)
    Sleep 500
    MouseClick()
    Sleep 300
    Send '{Tab}'
    Sleep 300
    WinActivate('ahk_id ' wnd_id)
    MouseMove(750,336)
    Sleep 300
    MouseClick()
    Sleep 20*1000
    WinActivate('ahk_id ' wnd_id)
    Sleep 200
    MouseMove(380,470)
    MouseClick()
    WinActivate('ahk_id ' wnd_id)
    Sleep 200
    MouseMove(380,490)
    MouseClick()
    WinActivate('ahk_id ' wnd_id)
    Sleep 200
    MouseMove(890,260)
    MouseClick()


}

Fixgear(*){
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
    Sleep 100
    MouseMove(275,700)
    Sleep 100
    MouseClick()
    Sleep 100
    loop 5{
        Send('{Enter}')
        Sleep 100
        Send '^{Tab}'
        Sleep 100
    }
}


test(btn,*){
    xunlu.GetPos(&x, &y, &w, &h)
    MsgBox(x ' ' y ' ' w ' ' h)
}

addButton(name,x,y){
    global t
    xunlu.Add('Button', 'x10 y' String(10+t*30) ' w100 h30', name).OnEvent('Click', dtx)
    xunlu.Add('Button', 'x121 y' String(10+t*30) ' w100 h30', '点击').OnEvent('Click',userclick.Bind(x,y))
    t++
}


getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}

dtx(btn,*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' asktao_id)
    Send('!w')
    Send btn.text
    Send '{Enter}'
}
userclick(x,y,btn,*)
{
    getid(&wnd_id, &asktao_id)
    CoordMode 'Mouse', 'Screen'
    MouseGetPos(&mx, &my)
    CoordMode 'Mouse', 'Client'
    WinActivate('ahk_id ' wnd_id)
    MouseMove(x,y)
    Sleep 100
    MouseClick()
    Sleep 100
    CoordMode 'Mouse', 'Screen'
    MouseMove(mx,my)
    CoordMode 'Mouse', 'Client'
}