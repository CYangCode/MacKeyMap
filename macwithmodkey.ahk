; 通过 MapKeyboard 2.1 将 LAlt 映射为 LCtrl，LWin 映射为 LAlt，LCtrl 映射为 RCtrl 之后，使用以下脚本

#Requires AutoHotkey v2.0
#SingleInstance force

; Capslock
#HotIf GetKeyState("CapsLock", "P")
h::Left
j::Down
k::Up
l::Right
Enter::CapsLock
#HotIf

; Map Capslock to Escape when pressed alone
*CapsLock:: {
    KeyWait "CapsLock"
    if (A_ThisHotKey = "*CapsLock") {
        Send "{Esc}"
    } 
}

>^a:: HOME
>^e:: END
^m:: MinimizeWindow()
^q:: Send "!{F4}"

; 删除到行首
<^BackSpace:: DeleteToLineStart()

; lctrl+rctrl+
<^>^f:: WinMinMaxSwitch()
<^>^a:: ^!a
<^>^t:: ^!t

!r::#r
!e:: Send "#{e}"

<^Tab:: AltTab

DeleteToLineStart() {
    SendInput "+{Home}"
    SendInput "{Delete}"
}

WinMinMaxSwitch() {
    style := WinGetStyle("A")
    id := WinGetId("A")

    if (style & 0x1000000) {
        WinRestore id
    } else {
        WinMaximize id
    }
}

MinimizeWindow() {
    id := WinGetId("A")
    WinMinimize id
}