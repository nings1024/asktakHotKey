#SingleInstance Force
#Requires AutoHotkey v2.0
myGui := Gui("+AlwaysOnTop", "我的GUI程序")
myGui.AddButton("h20", "刷新").OnEvent("Click", RestartSelf)
anyAskTao()
myGui.Show()

RestartSelf(*) {
    Run A_ScriptFullPath  ; 重新运行当前脚本
    ExitApp               ; 退出当前实例
}

anyAskTao() {
    wns:=WinGetList('ahk_class AtTabWnd')
    loop wns.Length {
        myGui.Add('Text',A_Index==1?'':'ys y32',StrSplit(WinGetTitle('ahk_id' wns[A_Index]),'[')[1])
        myGui.Add('Button',,'活跃奖励')
        myGui.Add('Button',,'自闭模式').OnEvent('Click', autisticMode.Bind(wns[A_Index]))
        myGui.Add('Button',,'清理窗口').OnEvent('Click', cleanWindow.Bind(wns[A_Index]))
        myGui.Add('Button',,'签到奖励').OnEvent('Click', signReward.Bind(wns[A_Index]))
        myGui.Add('Button',,'识界修炼').OnEvent('Click', Avatar.Bind(wns[A_Index]))
        ; myGui.Add('Button',,'')
    }   
}

; 定义函数 自闭模式 功能
autisticMode(wnd_id,*) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    asktao_id:=WinGetControlsHwnd('ahk_id' wnd_id)[1]
    WinActivate('ahk_id' asktao_id)
    Sleep 200
    loop 5 {
        Send '^{Tab}'
        Sleep 500
        Send '!1'
        Sleep 200
        Send '!1'
        Sleep 200
        Send '!1'
        Sleep 500
    }   
}
; 定义函数 清理窗口 功能
cleanWindow(wnd_id,*) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    asktao_id:=WinGetControlsHwnd('ahk_id' wnd_id)[1]
    WinActivate('ahk_id' asktao_id)
    Sleep 200
    loop 5 {
        Send '^{Tab}'
        Sleep 500
        Send '{Escape}'
        Sleep 200
        Send '^b'
        Sleep 500
    }   
}
; 定义函数 签到奖励 功能
signReward(wnd_id,*) {
    WinActivate('ahk_id' wnd_id)
    MouseMove(906,204)
    Sleep 500
    loop 5 {
        Sleep 200
        Send '^{Tab}'
        Sleep 500
        MouseClick()
    }
    WinActivate('ahk_id' wnd_id)
    MouseMove(835,690)
    Sleep 500
    loop 5 {
        Sleep 200
        Send '^{Tab}'
        Sleep 500
        MouseClick()
    }
}

; 定义函数 识界修炼 功能
Avatar(wnd_id,*) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    MouseMove(277,343)
    MouseClick()
    Sleep 200
    loop 5 {
        Send '^{Tab}'
        Sleep 500
        Send '!c'
        Sleep 200
        MouseClick()
        Sleep 500
    }   
}