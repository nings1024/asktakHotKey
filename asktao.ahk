; 问道辅助
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
