#SingleInstance force
#HotkeyInterval 2000
#HotkeyModifierTimeout 100

; Mine
CapsLock & H::Send {Left}
CapsLock & J::Send {Down}
CapsLock & K::Send {Up}
CapsLock & L::Send {Right}
CapsLock & Enter:: Send {CapsLock}

; ## Menu ##
$!H::WinMinimize, A
^!F::WinMinMaxSwitch()
!#H::HideOtherWindow()
$!M::WinMinimize, A
!#M::WinMinimizeAll
!Q::Send !{F4}
; File
$!T::Send ^t  
+!T::Send +^t
$!N::Send ^n
+!N::Send +^n
$!O::Send ^o
$!W::Send ^w
!+W::Send #w
$!S::Send ^s
$!P::Send ^p
!+P::Send #p
; Edit
!Z::Send ^z
+!Z::Send ^y
!X::Send ^x
$!C::Send ^c
!V::Send ^v
#BackSpace::Send ^{BackSpace}
<^A::Send {Home}
<^E::Send {End}
!+#V::
  clipboard = %clipboard%
  Send ^v
return
!A::Send ^a
!F::Send ^f
!G::Send {F3}
+!G::Send +{F3}
!#F::Send ^h

!Up::Send {PgUp}
!Down::Send {PgDn}
#Left::Send ^{Left}
#Right::Send ^{Right}
!+Left::Send +{Home}
!+Right::Send +{End}
!+Up::Send +{PgUp}
!+Down::Send +{PgDn}
#+Left::Send +^{Left}
#+Right::Send +^{Right}

; ## View ##
!`::NextWindow()
!=::Send ^{WheelUp}
!-::Send ^{WheelDown}
!0::Send ^0
!R::Send {F5}

$CapsLock::Send {Esc}

#C:: Send !c
#M:: Send !m
#T:: Send !t
^!A:: Send ^#a

!/:: Send ^/
!B:: Send ^b

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
