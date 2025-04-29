#SingleInstance Force
#Requires AutoHotkey v2.0
#Include %A_ScriptDir%\JSON.ahk
; 窗口hwnd集合
idmap := Map()
; 分辨率
resolution := ''

myGui := Gui("+AlwaysOnTop", "我的GUI程序")
myGui.AddButton("h20", "重启").OnEvent("Click", RestartSelf)
myGui.AddButton("h20 ys", "获取ID").OnEvent("Click", getAsktaoID)
anyAskTao()
myGui.Show('x' A_ScreenWidth - 400 ' y' A_ScreenHeight / 2 - 200)

RestartSelf(*) {
    Run A_ScriptFullPath  ; 重新运行当前脚本
    ExitApp               ; 退出当前实例
}
getAsktaoID(*) {
    wns := WinGetList('ahk_class AtTabWnd')
    loop wns.Length {
        hwnds := Map()
        t := A_Index
        asktao_id := WinGetControlsHwnd('ahk_id' wns[t])[1]
        hwnds.Set(asktao_id, 1)
        WinActivate('ahk_id' asktao_id)
        loop 5 {
            Send '^{Tab}'
            hwnds.Set(WinGetControlsHwnd('ahk_id' wns[t])[1], 1)
            Sleep 300
        }
        idmap.Set(wns[A_Index], hwnds)
        Sleep 500
    }
}

anyAskTao() {
    global resolution
    wns := WinGetList('ahk_class AtTabWnd')
    if resolution == '' 
        if wns.Length > 0 {
            WinGetClientPos(, , &w, &h, 'ahk_id' WinGetControlsHwnd('ahk_id' wns[1])[1])
            resolution := w 'x' h
        }
    loop wns.Length {
        myGui.Add('Text', A_Index == 1 ? 'x0' : 'x80 ys y34', StrSplit(WinGetTitle('ahk_id' wns[A_Index]), '[')[1])
        myGui.Add('Text',,wns[A_Index])
        myGui.Add('Button', , '签到奖励').OnEvent('Click', signReward.Bind(wns[A_Index]))
    }
}

signReward(wnd_id,*){
    WinActivate(wnd_id)
    Sleep 500
    getX_Y('签到位置', &x, &y)
    MouseMove(x,y)
    WinGetClientPos(, , &w, &h, 'ahk_id' wnd_id)



}

getX_Y( key, &x, &y) {
    t := IniRead('a.ini', resolution, key)
    x := Number(StrSplit(t, ' ')[1])
    y := Number(StrSplit(t, ' ')[2])
}

#HotIf WinActive("ahk_class AtTabWnd") or WinActive("ahk_class AskTao")
; 分页模式下进行切换窗口
XButton1:: {
    Send "^{Tab}"
}
; 关闭当前所有弹出项目
XButton2:: {
    Send "{Esc}"
    Send "^b"
}
; 重置自动回合
AppsKey:: {
    Send "!z"
    sleep 100
    Send "!z"
}
; 恢复
^AppsKey:: {
    Sleep 500
    loop 5 {
        MouseClick()
        Send '^{Tab}'
        Sleep 500
    }
}
