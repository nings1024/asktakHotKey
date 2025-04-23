#SingleInstance Force
#Requires AutoHotkey v2.0
t:='附件 全部领取'
pos:='133'
wns:=WinGetList('ahk_class AtTabWnd')
WinActivate(wns[1])
getX_Y1(StrSplit(t,' ')[1],StrSplit(t,' ')[2],&x,&y)
WinActivate(wns[1])
MouseMove(x,y)





getX_Y1(sel,key,&x,&y){
    wns:=WinGetList('ahk_class AtTabWnd')
    wnd_id:=wns[1]
    asktao_id:=WinGetControlsHwnd('ahk_id' wnd_id)[1]
    WinGetClientPos(, , &w, &h, "ahk_id " asktao_id )
    t:=IniRead('pos.ini',sel,key)
    x:=Number(StrSplit(t,' ')[1])*w/1024
    y:=Number(StrSplit(t,' ')[2])*h/768
}
getX_Y(sel,key,&x,&y){
    wns:=WinGetList('ahk_class AtTabWnd')
    WinGetClientPos(,,&w,&h,'ahk_id' wns[1])
    t:=IniRead('pos.ini',sel,key)
    x:=Number(StrSplit(t,' ')[1])*w/1024
    y:=Number(StrSplit(t,' ')[2])*h/768
}