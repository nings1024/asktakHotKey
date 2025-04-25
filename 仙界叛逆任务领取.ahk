#Requires AutoHotkey v2.0
#SingleInstance Force
wns:=WinGetList('ahk_class AtTabWnd')
; 激活窗口
WinActivate(wns[1])
asktao_id:=WinGetControlsHwnd(wns[1])[1]
WinActivate(asktao_id)
Sleep 200
Send '^b'
Sleep 200
; 飞行神捕
Send '!g'
Sleep 200
WinActivate(wns[1])
MouseMove(600,640)
Sleep 200
MouseClick()
Sleep 200
A_Clipboard:='仙界神捕'
Send '^v'
Sleep 200
WinActivate(wns[1])
MouseMove(600,248)
MouseClick('Left',,,2)
Sleep 200
WinActivate(wns[1])
; 队长任务
MouseMove(400,550)
; MouseClick()
Sleep 500
Send '^{Tab}'
Sleep 500
; 队员任务
loop 4{
    WinActivate(wns[1])
    MouseMove(400,500)
    Sleep 200
    ; MouseClick()
    Sleep 200
    Send '^{Tab}'
    Sleep 500
}
Sleep 300
WinActivate(asktao_id)
Sleep 100
; 准备寻路
Send '^b'
Sleep 300
Send '!q'
Sleep 500
WinActivate(wns[1])
Sleep 200
; 尝试寻路
MouseMove(500,438) ;队长任务位置
Sleep 200
MouseClick()
Sleep 60*1000
WinActivate(wns[1])
Sleep 200
MouseMove(300,470) ;确认位置
Sleep 200
MouseClick()
; 补充自动回合
loop 5{
    Sleep 200
    Send '!z'
    Sleep 200
    Send '!z'
    Sleep 200
    Send '^{Tab}'
    Sleep 500
}
; 等待战斗结束
Sleep 60*1000
; 寻路队员
Send '!q'


