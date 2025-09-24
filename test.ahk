#SingleInstance Force
#Requires AutoHotkey v2.0
#Include %A_ScriptDir%\JSON.ahk
; 窗口hwnd集合
idmap := Map()
; 分辨率
resolution := ''

myGui := Gui("+AlwaysOnTop", "我的GUI程序")
myGui.AddButton("h20", "重启").OnEvent("Click", RestartSelf)
myGui.AddButton("h20 ys", "重置自动位置").OnEvent("Click", resetAutoPos)
anyAskTao()
myGui.Show('x' A_ScreenWidth - 400 ' y' A_ScreenHeight / 2 - 200 ' w300')

RestartSelf(*) {
    Run A_ScriptFullPath  ; 重新运行当前脚本
    ExitApp               ; 退出当前实例
}
resetAutoPos(*) {
    wns := WinGetList('ahk_class AtTabWnd')
    ; 获取窗口对应的进程路径
    file_path := WinGetProcessPath(wns[1])

    ; 从完整路径中提取目录
    SplitPath file_path, &OutFileName, &OutDir

    ; 构建userdata路径
    userdata_path := OutDir . "\userdata"
    ; 检查userdata目录是否存在
    if DirExist(userdata_path) {
        ; 遍历userdata下的所有子目录
        loop files userdata_path . "\*", "D" {
            ; 构建DlgPosCfg.ini的完整路径
            ini_path := A_LoopFilePath . "\DlgPosCfg.ini"

            ; 检查ini文件是否存在
            if FileExist(ini_path) {
                try {
                    ; 读取并显示文件内容
                    content := IniRead(ini_path, 'AutoFightDlg', 'x') ',' IniRead(ini_path, 'AutoFightDlg', 'y')
                    IniWrite('0', ini_path, 'AutoFightDlg', 'x')
                    IniWrite('300', ini_path, 'AutoFightDlg', 'y')
                } catch Error as e {
                }
            }
        }
    }
    ShowToolTip("处理完毕")
    ShowToolTip(text, duration := 3000) {
        ToolTip text
        SetTimer () => ToolTip(), -duration  ; 定时清除提示
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
    wns := WinGetList('ahk_class AtTabWnd')
    loop wns.Length {
        myGui.Add('Text', A_Index == 1 ? 'x0' : 'x80 ys y34', StrSplit(WinGetTitle('ahk_id' wns[A_Index]), '[')[1])
        myGui.Add('Button', , '活跃奖励').OnEvent('Click', activeReward.Bind(wns[A_Index]))
        myGui.Add('Button', , '签到奖励').OnEvent('Click', signReward.Bind(wns[A_Index]))
        myGui.Add('Button', , '识界修炼').OnEvent('Click', Avatar.Bind(wns[A_Index]))
        myGui.Add('Button', , '领取附件').OnEvent('Click', getAttachment.Bind(wns[A_Index]))
        myGui.Add('Button', , '单人任务').OnEvent('Click', Solotask.Bind(wns[A_Index]))
        myGui.Add('Button', , '登录辅助').OnEvent('Click', LoginAssist.Bind(wns[A_Index]))
    }
}

Solotask(wnd_id, *) {
    WinActivate('ahk_id ' wnd_id)
    getX_Y("自动位置", &lx, &ly)
    MouseMove(lx, ly)
    loop 5 {
        MouseClick()
        Sleep 500
        Send '^{Tab}'
        Sleep 500
    }
    WinActivate('ahk_id ' wnd_id)
    getX_Y("单人位置", &lx, &ly)
    MouseMove(lx, ly)
    loop 5 {
        MouseClick()
        Sleep 500
        Send '^{Tab}'
        Sleep 500
    }
    WinActivate('ahk_id ' wnd_id)
    getX_Y("一键自动", &lx, &ly)
    MouseMove(lx, ly)
    loop 5 {
        MouseClick()
        Sleep 500
        Send '^{Tab}'
        Sleep 500
    }
}
;定义函数 活跃奖励 功能
activeReward(wnd_id, *) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    asktao_id := WinGetControlsHwnd('ahk_id' wnd_id)[1]
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
    getX_Y('活跃位置', &lx, &ly)
    MouseMove(lx, ly)
    Sleep 500
    loop 6 {
        loop 5 {
            MouseClick()
            Sleep 200
            Send '^{Tab}'
            Sleep 500
        }
        WinActivate('ahk_id' wnd_id)
        Sleep 500
        MouseMove(60, 0, , 'R')
        Sleep 500
    }
}

; 定义函数 签到奖励 功能
signReward(wnd_id, *) {
    WinActivate('ahk_id' wnd_id)
    getX_Y("签到位置", &fx, &fy)
    Sleep 500
    MouseMove(fx, fy)
    Sleep 500
    loop 5 {
        Sleep 200
        Send '^{Tab}'
        Sleep 500
        MouseClick()
    }
    WinActivate('ahk_id' wnd_id)
    getX_Y("签到领取", &lx, &ly)
    MouseMove(lx, ly)
    Sleep 500
    loop 5 {
        Sleep 200
        Send '^{Tab}'
        Sleep 500
        MouseClick()
    }
}

; 定义函数 识界修炼 功能
Avatar(wnd_id, *) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    getX_Y("识界位置", &lx, &ly)
    MouseMove(lx, ly)
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
    getX_Y("识界修炼", &lx, &ly)
    MouseMove(lx, ly)
    loop 5 {
        MouseClick()
        Sleep 200
        Send '{Enter}'
        Sleep 200
        Send '^{Tab}'
        Sleep 500
    }
}

; 定义函数 领取附件 功能
getAttachment(wnd_id, *) {
    WinActivate('ahk_id' wnd_id)
    Sleep 200
    getX_Y("附件邮箱", &lx, &ly)
    MouseMove(lx, ly)
    loop 5 {
        MouseClick()
        Sleep 200
        Send '{Enter}'
        Sleep 200
        Send '^{Tab}'
        Sleep 500
    }
    WinActivate('ahk_id' wnd_id)
    getX_Y("附件领取", &lx, &ly)
    MouseMove(lx, ly)
    loop 5 {
        MouseClick()
        Sleep 200
        Send '{Enter}'
        Sleep 200
        Send '^{Tab}'
        Sleep 500
    }
}
LoginAssist(wnd_id, *) {
    WinActivate('ahk_id' wnd_id)
    Sleep 1000
    loop 17 {
        Send '{Enter}'
        Sleep 800
    }
}

getX_Y(key, &x, &y) {
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
    Sleep 200
    Send "^b"
    Sleep 200
    Send "{Ctrl up}"
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
/:: {
    getid(&wnd_id, &asktao_id)
    WinActivate('ahk_id ' wnd_id)
}

getid(&wnd_id, &asktao_id) {
    wnd_id := WinGetList('ahk_class AtTabWnd')[1]
    asktao_id := WinGetControlsHwnd('ahk_id ' wnd_id)[1]
}
