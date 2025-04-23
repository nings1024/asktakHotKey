#Requires AutoHotkey v2.0
#SingleInstance Force
MyGui := Gui()

ProcessUserInput(*) {
    a := WinGetList("ahk_class AtTabWnd")
    veg := ["Asparagus", "Broccoli", "Cucumber"]
    loop a.Length
        MsgBox a[A_Index]
        MyGui.Add("Button", , WinGetTitle("ahk_id " . a[A_Index])).OnEvent("Click", OK.Bind(a[A_Index]))
}
ProcessUserInput()
MyGui.Show()
OK(w_id, a, *) {
    ; MsgBox w_id
    loop 20 {
        WinActivate("ahk_id " . w_id)
        Sleep 200
        Send '{Enter}'
        loop 5 {
            Sleep 300
            Send '^{Tab}'
            Sleep 200
            Send '!z'
            Sleep 200
            Send '!z'
            Sleep 200
        }
        Sleep 1000*60*6
    }
}
