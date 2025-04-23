#SingleInstance Force
#Requires AutoHotkey v2.0
t:='福利 福利'
pos:='133'
wns:=WinGetList('ahk_class AtTabWnd')
WinActivate(wns[1])
getX_Y(StrSplit(t,' ')[1],StrSplit(t,' ')[2],&x,&y)
MouseMove(x*1297/1038,y*1058/847)





getX_Y(sel,key,&x,&y){
    t:=IniRead('pos.ini',sel,key)
    x:=Number(StrSplit(t,' ')[1])
    y:=Number(StrSplit(t,' ')[2])
}