#Requires AutoHotkey v2.0
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance Force

; Load library
#Include komorebic.lib.ahk

CapsLock::Escape

; Allow win + L to be set
RegWrite(1, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")

MonitorGet(2, , , &Right, &Bottom)
if (Right < Bottom) {
    FocusMonitor(1)
    ChangeLayout("rows")
    FocusMonitor(0)
}

+#Q::WinClose("A")

; Win+Esc enables lock screen for long enough to lock it.
#Escape:: {
    RegWrite(0, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")
    DllCall("LockWorkStation")
    sleep(1000)
    RegWrite(1, "REG_DWORD", "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon", "DisableLockWorkstation")
    return
}


; Focus windows
#h::Focus("left")
#j::Focus("down")
#k::Focus("up")
#l::Focus("right")
#+[::CycleFocus("previous")
#+]::CycleFocus("next")

; Move windows
#+h::Move("left")
#+j::Move("down")
#+k::Move("up")
#+l::Move("right")
#t::Promote()

; Stack windows
#Left::Stack("left")
#Right::Stack("right")
#Up::Stack("up")
#Down::Stack("down")
#;::Unstack()
#[::CycleStack("previous")
#]::CycleStack("next")

; Resize
#=::ResizeAxis("horizontal", "increase")
#-::ResizeAxis("horizontal", "decrease")
#+=::ResizeAxis("vertical", "increase")
#+-::ResizeAxis("vertical", "decrease")

; Manipulate windows
+#Space::ToggleFloat()
#+f::ToggleMonocle()

; Window manager options
#+r::Retile()
#p::TogglePause()

; Layouts
+#x::FlipLayout("horizontal")
+#y::FlipLayout("vertical")

; Workspaces
#1::FocusWorkspace(0)
#2::FocusWorkspace(1)
#3::FocusWorkspace(2)

; Move windows across workspaces
#+1::MoveToWorkspace(0)
#+2::MoveToWorkspace(1)
#+3::MoveToWorkspace(2)
