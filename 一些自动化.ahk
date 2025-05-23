#Requires AutoHotkey v2.0
#SingleInstance Force
global t := 0
xunlu := Gui('AlwaysOnTop')
TimeLeftText := xunlu.Add("Text", "w200 Center", "00")
xunlu.Add('Button', '', '挖取碎片').OnEvent('Click', wa_sui_pian)
xunlu.Add('Button', '', '第二位置').OnEvent('Click', xunlu2)
xunlu.Add('Button', '', '第三位置').OnEvent('Click', xunlu3)
xunlu.Add('Button', '', '计时').OnEvent('Click', StartCountdown)
xunlu.Add('Button', '', '守卫1').OnEvent('Click', shou_wei1)
xunlu.Add('Button', '', '守卫2').OnEvent('Click', shou_wei2)
xunlu.Add('Button', '', '守卫3').OnEvent('Click', shou_wei3)
xunlu.Add('Button', '', '天墉城').OnEvent('Click', tian_yong_cheng)
xunlu.Show('x1292 y374 w300')
EndTime := 0
wa_sui_pian(*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' asktao_id)
    Send '^b'
    Send '{Tab}'
    SendText('帮派使者')
    Send '{Enter}'
    Sleep 500
    WinActivate('ahk_id ' wnd_id)
    Sleep 100
    getX_Y('挖取碎片', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
    Sleep 500
    Send '{Enter}'
    Sleep 3000
    Send '{Tab}'
    SendText('23.53')
    Send '{Enter}'
}
xunlu2(*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' asktao_id)
    Send '{Tab}'
    SendText('41.42')
    Send '{Enter}'
}
xunlu3(*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' asktao_id)
    Send '{Tab}'
    SendText('59.31')
    Send '{Enter}'
}

shou_wei1(*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
    getX_Y('守卫1', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
    Sleep 500
    WinActivate('ahk_id ' wnd_id)
    getX_Y('守卫对话', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
}
shou_wei2(*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
    getX_Y('守卫2', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
    Sleep 500
    WinActivate('ahk_id ' wnd_id)
    getX_Y('守卫对话', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
}
shou_wei3(*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
    getX_Y('守卫3', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
    Sleep 500
    WinActivate('ahk_id ' wnd_id)
    getX_Y('守卫对话', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
}

tian_yong_cheng(*) {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
    getX_Y('守卫灵塔', &lx, &ly)
    MouseMove(lx, ly)
    MouseClick()
    Sleep 1000*11
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' asktao_id)
    Send '{Tab}'
    SendText('天墉城')
    Send '{Enter}'
}

getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}
getX_Y(key, &x, &y) {
    t := IniRead('a.ini', '1000x750', key)
    x := Number(StrSplit(t, ' ')[1])
    y := Number(StrSplit(t, ' ')[2])
}

StartCountdown(*) {
    global  EndTime, TimeLeftText


    ; 设置结束时间为当前时间 + 30秒
    EndTime := A_Now
    EndTime += 30, "Seconds"

    SetTimer(UpdateCountdown, 1000)
    UpdateCountdown()
}
; 更新倒计时显示
UpdateCountdown() {
    global  EndTime, TimeLeftText

    ; 计算剩余时间
    remaining := EndTime - A_Now

    if (remaining <= 0) {
        TimeLeftText.Text := "时间到！"
        SoundBeep(1500, 800) ; 播放提示音
        SetTimer(UpdateCountdown, 0) ; 清除定时器
        return
    }

    ; 更新显示
    TimeLeftText.Text := "剩余时间: " remaining "秒"
}
