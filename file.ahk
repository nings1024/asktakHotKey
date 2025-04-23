#Requires AutoHotkey v2.0
#SingleInstance Force
;poss:=['福利','',,'活跃','自动','单人','一键自动']
poss:=Map("福利",['福利','一键领取'])
poss.Set('识界',['识界','修炼'])
poss.Set('自动',['自动','单人','一键自动'])
myMap:=poss
keys:=[]
for key in myMap
    keys.Push(key)
; 初始化变量
currentKey := ""      ; 当前显示的key
currentIndex := 1
keyIndex:=1     ; 当前显示的value索引
displayDuration := 1000000000 ; 每个tooltip显示时间(毫秒)

; 主函数：显示当前key和index对应的tooltip
ShowCurrentTooltip() {
    global
    if !currentKey || !myMap.Has(currentKey) {
        currentKey := keys[1]  ; 默认显示第一个key
        currentIndex := 1
    }
    
    values := myMap[currentKey]
    if (currentIndex > values.Length) {
        currentIndex := 1
    }
    
    ToolTip(keys[keyIndex] ' ' values[currentIndex], A_ScreenWidth//2, A_ScreenHeight//2)
    SetTimer(() => ToolTip(), -displayDuration) ; 3秒后自动消失
}

; Win+N快捷键切换到下一个值
#n:: {
    global
    MouseGetPos &xpos, &ypos 
    IniWrite xpos ' ' ypos ,'pos.ini',keys[keyIndex],myMap[currentKey][currentIndex]
    if !currentKey || !myMap.Has(currentKey) {
        currentKey := keys[1]
        currentIndex := keyIndex
    } else {
        currentIndex++
        values := myMap[currentKey]
        if (currentIndex > values.Length) {
            ; 当前key的值列表已显示完，切换到下一个key
            currentKeyIndex:=keyIndex
            if (currentKeyIndex >= keys.Length) {
                MsgBox '所有值均设置完毕'
                ExitApp()
            } else {
                keyIndex++
                currentKey := keys[keyIndex]
            }
            currentIndex := 1
        }
    }
    ShowCurrentTooltip()
}

; 初始显示
ShowCurrentTooltip()