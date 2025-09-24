#Requires AutoHotkey v2.0
#SingleInstance Force

; 获取所有指定类的窗口
wns := WinGetList('ahk_class AtTabWnd')

loop wns.Length {

}
ShowToolTip("处理完毕")
ShowToolTip(text, duration := 3000) {
    ToolTip text
    SetTimer () => ToolTip(), -duration  ; 定时清除提示
}
