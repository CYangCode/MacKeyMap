; 本脚本需要需要依赖 PowerToy 
; 将 ctrl(left), win(left), alt(left) 分别改为 win(right), alt(right), ctrl(right)
; 将 ctrl(right) + tab 映射为 Alt(right) + Tab
#SingleInstance force
#HotkeyInterval 2000
#HotkeyModifierTimeout 100

#UseHook, On
; capslock
CapsLock & H::Send {Left}
CapsLock & J::Send {Down}
CapsLock & K::Send {Up}
CapsLock & L::Send {Right}
^+CapsLock:: Send {CapsLock}
$CapsLock::Send {Esc}

; 窗口操作
; ^Tab::Send !{Tab} ; 进程窗口切换
; LCtrl & `::NextWindow() ; 同类进程窗口切换
; ^M::WinMinimize, A ; 窗口最小化
^!F::WinMinMaxSwitch() ; 最大化和窗口化之间切换

;
; 文本操作
LCtrl & BackSpace:: DeleteCurrentLine() ; 删除
; RWin & BackSpace:: Send ^{BackSpace}

; 光标操作
;  RCtrl & A:: Send {Home}
; RCtrl & E:: Send {End}

; PowerToy 的 bug 有时候修改后的 win + 一些键不能被识别, 在这里强制修改，可能不管用
; #M:: Send !M
; #T:: Send !T
; #P:: Send !P
; #B:: Send !B
; #V:: Send !V
; !E:: Send #e

DeleteCurrentLine() {
  ;  SendInput {End}
   SendInput +{Home}
   SendInput +{Home}
   SendInput {Delete}
}

NextWindow()
{
  WinGetClass, cur_class, A
  acitve_id := 0
  DetectHiddenText, On
  WinGet, id, list,,, Program Manager
  ; don't break the loop
  Loop, %id%
  {
    this_id := id%A_Index% 
    WinGetClass, this_class, ahk_id %this_id%
    if (this_class != cur_class) {
      continue
    }
    if (acitve_id = 0) {
      active_id := this_id
    }
  }
  if (active_id != 0) {
    WinActivate, ahk_id %active_id%
  }
}


WinMinMaxSwitch()
{
  WinGet, win_type, MinMax, A

  if (win_type = -1) {
    WinRestore, A
  }
  if (win_type = 0) {
    WinMaximize, A
  }
  if (win_type = 1) {
    WinRestore, A
  }
}

get_SelectedText() {

    ; See if selection can be captured without using the clipboard.
    WinActive("A") 
    ControlGetFocus ctrl
    ControlGet selectedText, Selected,, %ctrl%

    ;If not, use the clipboard as a fallback.
    If (selectedText = "") {
        originalClipboard := ClipboardAll ; Store current clipboard.
        Clipboard := ""
        SendInput ^c
        ClipWait .2
        selectedText := ClipBoard
        ClipBoard := originalClipboard
    }

    Return selectedText
}

HideOtherWindow()
{
  WinGetClass, cur_class, A
  DetectHiddenText, Off
  WinGet, id, list,,, Program Manager
  Loop, %id%
  {
    this_id := id%A_Index%
    WinGetClass, this_class, ahk_id %this_id%
    if (this_class = cur_class or this_class = "Progman" or this_class = "WorkerW" or this_class = "Shell_TrayWnd" or this_class = "Internet Explorer_Hidden") {
      continue
    }
    WinMinimize, ahk_id %this_id%
  }
}
