*#up::MouseMove 0, -10, 0, "R"  ; Win+UpArrow 热键 => 上移光标
*#Down::MouseMove 0, 10, 0, "R"  ; Win+DownArrow => 下移光标
*#Left::MouseMove -10, 0, 0, "R"  ; Win+LeftArrow => 左移光标
*#Right::MouseMove 10, 0, 0, "R"  ; Win+RightArrow => 右移光标

*<#RCtrl::  ; 左 Win + 右 Control => Left-click(按住 Control/Shift 来进行 Control-Click 或 Shift-Click).
{
    SendEvent "{Blind}{LButton down}"
    KeyWait "RCtrl"  ; 防止键盘自动重复导致的重复鼠标点击.
    SendEvent "{Blind}{LButton up}"
}

*<#AppsKey::  ; 左 Win + AppsKey => Right-click
{
    SendEvent "{Blind}{RButton down}"
    KeyWait "AppsKey"  ; 防止键盘自动重复导致重复的鼠标点击.
    SendEvent "{Blind}{RButton up}"
}