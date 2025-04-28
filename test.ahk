#SingleInstance Force
#Requires AutoHotkey v2.0
#Include %A_ScriptDir%\JSON.ahk
idmap:=Map()
myGui := Gui("+AlwaysOnTop", "我的GUI程序")
myGui.AddButton("h20", "重启").OnEvent("Click", RestartSelf)
myGui.AddButton("h20 ys", "获取ID").OnEvent("Click", getAsktaoID)
anyAskTao()
myGui.Show('x' A_ScreenWidth-400 ' y' A_ScreenHeight/2-200)

RestartSelf(*) {
    Run A_ScriptFullPath  ; 重新运行当前脚本
    ExitApp               ; 退出当前实例
}
getAsktaoID(*) {
    wns:=WinGetList('ahk_class AtTabWnd')
    loop wns.Length {
        hwnds:=Map()
        t:=A_Index
        asktao_id:=WinGetControlsHwnd('ahk_id' wns[t])[1]
        hwnds.Set(asktao_id,1)
        WinActivate('ahk_id' asktao_id)
        loop 5{
            Send '^{Tab}'
            hwnds.Set(WinGetControlsHwnd('ahk_id' wns[t])[1],1)
            Sleep 300
        }
        idmap.Set(wns[A_Index],hwnds)        
        Sleep 500
    }
}


anyAskTao() {
    wns:=WinGetList('ahk_class AtTabWnd')
    loop wns.Length {
        myGui.Add('Text',A_Index==1?'x0':'x80 ys y34',StrSplit(WinGetTitle('ahk_id' wns[A_Index]),'[')[1])
        myGui.Add('Button',,'活跃奖励').OnEvent('Click', activeReward.Bind(wns[A_Index]))
        myGui.Add('Button',,'签到奖励').OnEvent('Click', signReward.Bind(wns[A_Index]))
        myGui.Add('Button',,'识界修炼').OnEvent('Click', Avatar.Bind(wns[A_Index]))
        myGui.Add('Button',,'领取附件').OnEvent('Click', getAttachment.Bind(wns[A_Index]))
        myGui.Add('Button',,'Ctlr+B').OnEvent('Click',ClearWindoiw.Bind(wns[A_Index]) )
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

; 定义函数 签到奖励 功能
signReward(wnd_id,*) {
    WinActivate('ahk_id' wnd_id)
    getX_Y("福利","福利",&fx,&fy)
    Sleep 500
    MouseMove(fx,fy)
    Sleep 500
    loop 5 {
        Sleep 200
        Send '^{Tab}'
        Sleep 500
        MouseClick()
    }
    WinActivate('ahk_id' wnd_id)
    getX_Y("福利","一键领取",&lx,&ly)
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
; 
ClearWindoiw(wnd_id,*) {
    asktao_ids:=idmap.Get(wnd_id)
    url := "http://127.0.0.1:8999"
    data := '{"name": "John", "age": 30}'
    whr := ComObject("WinHttp.WinHttpRequest.5.1")
    whr.Open("POST", url, true)
    whr.SetRequestHeader("Content-Type", "application/json")
    whr.Send(Jxon_Dump(asktao_ids))
    whr.WaitForResponse()
}
; 定义函数 领取附件 功能
getAttachment(wnd_id,*) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    getX_Y("附件","邮箱",&lx,&ly)
    MouseMove(lx,ly)
    loop 5{
        MouseClick()
        Sleep 200
        Send '{Enter}'
        Sleep 200
        Send '^{Tab}'
        Sleep 500
    }
    WinActivate('ahk_id' wnd_id)
    getX_Y("附件","全部领取",&lx,&ly)
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
    wns:=WinGetList('ahk_class AtTabWnd')
    wnd_id:=wns[1]
    asktao_id:=WinGetControlsHwnd('ahk_id' wnd_id)[1]
    WinGetClientPos(, , &w, &h, "ahk_id " asktao_id )
    t:=IniRead('pos.ini',sel,key)
    x:=Number(StrSplit(t,' ')[1])*w/1024
    y:=Number(StrSplit(t,' ')[2])*h/768
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
