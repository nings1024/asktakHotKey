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
        myGui.Add('Button',,'活跃奖励').OnEvent('Click', activeReward.Bind(wns[A_Index]))
        myGui.Add('Button',,'自闭模式').OnEvent('Click', autisticMode.Bind(wns[A_Index]))
        myGui.Add('Button',,'清理窗口').OnEvent('Click', cleanWindow.Bind(wns[A_Index]))
        myGui.Add('Button',,'签到奖励').OnEvent('Click', signReward.Bind(wns[A_Index]))
        myGui.Add('Button',,'识界修炼').OnEvent('Click', Avatar.Bind(wns[A_Index]))
        ; myGui.Add('Button',,'')
    }   
}

;定义函数 活跃奖励 功能
activeReward(wnd_id,*) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    asktao_id:=WinGetControlsHwnd('ahk_id' wnd_id)[1]
    WinActivate('ahk_id' asktao_id)
    Sleep 500
    loop 5 {
        Sleep 200
        Send '^{Tab}'
        Sleep 500
        Send '{Escape}'
        Sleep 500
    }
    WinActivate('ahk_id' wnd_id)
    ; 第一个或活跃奖励位置
    getX_Y('活跃','活跃',&lx,&ly)
    MouseMove(lx,ly)
    Sleep 500
    loop 6{
        loop 5
        {
            MouseClick()
            Sleep 200
            Send '^{Tab}'
            Sleep 500
        }
        WinActivate('ahk_id' wnd_id)
        Sleep 500
        MouseMove(60,0,,'R')
        Sleep 500
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
    t:=IniRead('pos.ini','福利','福利')
    fx:=Number(StrSplit(t,' ')[1])
    fy:=Number(StrSplit(t,' ')[2])
    t:=IniRead('pos.ini','福利','一键领取')
    lx:=Number(StrSplit(t,' ')[1])
    ly:=Number(StrSplit(t,' ')[2])
    WinActivate('ahk_id' wnd_id)
    MouseMove(fx,fy)
    Sleep 500
    loop 5 {
        Sleep 200
        Send '^{Tab}'
        Sleep 500
        MouseClick()
    }
    WinActivate('ahk_id' wnd_id)
    MouseMove(lx,ly)
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
    getX_Y("识界","识界",&lx,&ly)
    MouseMove(lx,ly)
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
    WinActivate('ahk_id' wnd_id)
    getX_Y("识界","修炼",&lx,&ly)
    MouseMove(lx,ly)
    loop 5{
        MouseClick()
        Sleep 200
        Send '{Enter}'
        Sleep 200
        Send '^{Tab}'
        Sleep 500
    }
}

getX_Y(sel,key,&x,&y){
    t:=IniRead('pos.ini',sel,key)
    x:=Number(StrSplit(t,' ')[1])
    y:=Number(StrSplit(t,' ')[2])
}